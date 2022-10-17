//
//  PetModel.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/22/22.
//

import Foundation
import SwiftUI

/*
 Aggragate root - part of MV Design Pattern
 */

@MainActor
class PetModel: ObservableObject { // Observer pattern
		@Published private(set) var pets: [Pet] = []
		@Published private (set) var favoritePets: [Pet] = []
		
		@Environment(\.managedObjectContext) var moc
		
		let webservice: Webservice
		
		init(webservice: Webservice) {
				self.webservice = webservice
				loadPets()
		}
		
		static let examplePet = Pet(name: "Angel",favoriteToy: "String", imageString: "angel", age: 9, birthday: "8/13/2013", trait: "Loveable and lazy.")
		
		func populatePets() async throws {
				if pets.isEmpty {
						pets = try await webservice.getPets()
				}
				
		}
		
		
		// MARK - Assignment 2
		
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
						print(petsPlistData)
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
		
		func addPetsToCoreData() {
				if !UserDefaults.standard.bool(forKey: Constants.CoreData.dataImpprted.rawValue) {
						for pet in pets {
								let coreDataPet = CoreDataPet(context: moc)
								coreDataPet.name = pet.name
								coreDataPet.imageString = pet.imageString
								coreDataPet.favoriteToy = pet.favoriteToy
								coreDataPet.trait = pet.trait
								coreDataPet.age = pet.age
								coreDataPet.birthday = pet.birthday
								
								do {
										try moc.save()
								} catch {
										let nserror = error as NSError
										fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
								}
						}
						UserDefaults.standard.set(true, forKey: Constants.CoreData.dataImpprted.rawValue)
				}
				
		}
}
