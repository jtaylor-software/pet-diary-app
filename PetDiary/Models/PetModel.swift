//
//  PetModel.swift
//  PetDiary
//
//  Created by Jeremy Taylor on 9/22/22.
//

import Foundation
import SwiftUI


final class PetModel: ObservableObject {
    @Published private(set) var pets: [Pet] = []
    @Published private (set) var favoritePets: [Pet] = []
    @Published private (set) var petFacts: [Fact] = []
    
    static let examplePet = Pet(name: "Angel", favoriteToy: "String", age: 9, birthday: "8/13/2013", trait: "Lovable and lazy.")
    
    init() {
        loadPets()
        loadFavorites()
    }
    
    func waitForAnimation() async {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
    }
    
    @MainActor
    func fetchPets() async throws {
        let urlString = Constants.API.baseUrl + Constants.API.Endpoint.pets
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let petResponse: [Pet] = try await HttpClient.shared.fetch(url: url)
        
        self.pets = petResponse
        savePets()
    }
    
    @MainActor
    func fetchFacts() async throws {
        let urlString = Constants.API.baseUrl + Constants.API.Endpoint.facts
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let factsResponse: [Fact] = try await HttpClient.shared.fetch(url: url)
        
        self.petFacts = factsResponse
    }
    
    func randomPetFact() -> String {
        petFacts.randomElement()?.fact ?? "Cats mark you as their territory when they rub their faces and bodies against you, as they have scent glands in those areas."
    }
    
    func delete(at offsets: IndexSet) {
            offsets.forEach { i in
                guard let petID = pets[i].id else {
                    return
                }
                
                guard let url = URL(string: Constants.API.baseUrl + Constants.API.Endpoint.pets + "/\(petID)") else {
                    return
                }
                
                Task {
                    do {
                        try await HttpClient.shared.delete(at: petID, url: url)
                    } catch {
                        print("??? error: \(error)")
                    }
                }
            }
            
            pets.remove(atOffsets: offsets)
            savePets()
        }

    
    
    @MainActor
    func addPet(_ pet: Pet) async throws {
        let urlString = Constants.API.baseUrl + Constants.API.Endpoint.pets
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let newPet = Pet(id: UUID(), name: pet.name, favoriteToy: pet.favoriteToy, age: Int(pet.age), birthday: pet.birthday, trait: pet.trait)
        
        try await HttpClient.shared.sendData(to: url,
                                             object: newPet,
                                             httpMethod: HttpMethods.POST.rawValue)
        pets.append(newPet)
        savePets()
    }
    
    @MainActor
    func updatePet(_ pet: Pet) async throws {
        let urlString = Constants.API.baseUrl + Constants.API.Endpoint.pets
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let updatePet = Pet(id: pet.id!, name: pet.name, favoriteToy: pet.favoriteToy, age: Int(pet.age), birthday: pet.birthday, trait: pet.trait)
        
        try await HttpClient.shared.sendData(to: url,
                                             object: updatePet,
                                             httpMethod: HttpMethods.PUT.rawValue)
        
        // Find index of pet in pets array
        guard let index = pets.firstIndex(of: pet) else { return }
        // Remove pet at found index
        pets.remove(at: index)
        // Insert updated pet at that index
        pets.insert(updatePet, at: index)
        savePets()
    }
    
    
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func loadImageFor(_ pet: Pet) -> Data {
        let url = getDocumentsDirectory().appendingPathComponent("\(pet.name).png")
        do {
            let petImageData = try Data(contentsOf: url)
            return petImageData
            
        } catch {
            print("Error loading image data from disk.")
        }
        return (UIImage(named: "placeholder")?.pngData())!
    }
    
    func saveImageFor(_ pet: Pet, image: UIImage) {
        let documentsDirectory = getDocumentsDirectory()
        let url = documentsDirectory.appendingPathComponent("\(pet.name).png")
        
        // Convert to Data
        if let data = image.pngData() {
            do {
                try data.write(to: url)
            } catch {
                print("Unable to write image data to disk.")
            }
        }
    }
    
    func loadPets() {
        let url = getDocumentsDirectory().appendingPathComponent("Pets.plist")
        do {
            let petsData = try Data(contentsOf: url)
            let petsPlistData = try PropertyListDecoder().decode([Pet].self, from: petsData)
            pets = petsPlistData
        } catch {
            print("Error loading plist data.")
        }
    }
    
    func savePets() {
        
        let url = getDocumentsDirectory().appendingPathComponent("Pets.plist")
        do {
            let savedData =	try PropertyListEncoder().encode(pets)
            try savedData.write(to: url, options: .atomic)
        } catch {
            print("Error saving plist data")
        }
    }
    
    
    func favoritesContains(_ pet: Pet) -> Bool {
        favoritePets.contains(pet)
    }
    
    func addFavorite(_ pet: Pet) {
        objectWillChange.send()
        favoritePets.insert(pet, at: 0)
        saveFavorites()
    }
    
    func removeFavorite(_ pet: Pet) {
        guard let index = favoritePets.firstIndex(of: pet) else { return }
        favoritePets.remove(at: index)
        objectWillChange.send()
        
        saveFavorites()
    }
    
    func loadFavorites() {
        let url = getDocumentsDirectory().appendingPathComponent("Favorites.json")
        do {
            let jsonData = try Data(contentsOf: url)
            let favorites = try JSONDecoder().decode([Pet].self, from: jsonData)
            favoritePets = favorites
        } catch {
            print("Error loading json data.")
        }
    }
    
    func saveFavorites() {
        let url = getDocumentsDirectory().appendingPathComponent("Favorites.json")
        do {
            let savedData =    try JSONEncoder().encode(favoritePets)
            try savedData.write(to: url)
        } catch {
            print("Error saving json data")
        }
    }
}
