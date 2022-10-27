//
//  PetModel.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/22/22.
//

import Foundation
import SwiftUI

class PetModel: ObservableObject { // Observer pattern
    @Published private(set) var pets: [Pet] = []
    @Published private (set) var favoritePets: [Pet] = []
    
    let webservice: Webservice
    
    init(webservice: Webservice) {
        self.webservice = webservice
        loadPets()
    }
    
    static let examplePet = Pet(name: "Angel",favoriteToy: "String", imageString: "angel", age: 9, birthday: "8/13/2013", trait: "Loveable and lazy.")
    
    func waitForAnimation() async {
        try? await Task.sleep(nanoseconds: 4_000_000_000)
    }
    
    @MainActor
    func populatePets() async throws {
        if pets.isEmpty {
            pets = try await webservice.getPets()
            savePets()
            
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
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
