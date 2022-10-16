//
//  PetModel.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/22/22.
//

import Foundation

/*
 Aggragate root - part of MV Design Pattern
 */

@MainActor
class PetModel: ObservableObject { // Observer pattern
		@Published private(set) var pets: [Pet] = []
		@Published private (set) var favoritePets: [Pet] = []
		
		let webservice = Webservice()
		
		static let examplePet = Pet(name: "Angel", type: .cat, favoriteToy: "String", imageString: "angel", age: 9, birthday: "8/13/2013", trait: "Loveable and lazy.")
		
		init() {
				loadPets()
		}
		
		private func addPet(_ pet: Pet) {
				pets.append(pet)
		}
		
		func favoritesContains(_ pet: Pet) -> Bool {
				favoritePets.contains(pet)
		}
		
		func addFavorite(_ pet: Pet) {
				objectWillChange.send()
				favoritePets.insert(pet, at: 0)
				savePets()
		}
		
		func removeFavorite(_ pet: Pet) {
				guard let index = favoritePets.firstIndex(of: pet) else { return }
				favoritePets.remove(at: index)
				objectWillChange.send()
				
				savePets()
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
}
