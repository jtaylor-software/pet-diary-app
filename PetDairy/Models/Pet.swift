//
//  Pet.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/25/22.
//
import Foundation

/*
 Normally I would make Pet a struct that would then be used as an array in
 a PetViewModel class.
 
 To avoid Homework confusion I'll use a single struct for this week
 */

struct Pet: Identifiable {
		enum PetType: String {
				case cat, dog
		}
		let id = UUID()
		let name: String
		let type: PetType
		var favoriteToy: String?
		
		var pets = [Pet]()
		
		init(name: String = "Tom", type :PetType = .cat, favoriteToy: String? = nil) {
				self.name = name
				self.type = type
				self.favoriteToy = favoriteToy
		}
		
		mutating func addPet(_ pet: Pet) {
				pets.append(pet)
		}
		
		func printInfoForPets(_ pets: [Pet]) {
				for pet in pets {
						if let favoriteToy = pet.favoriteToy {
								print("Name \(pet.name), type \(pet.type), favorite toy \(favoriteToy)")
						} else {
								print("Name \(pet.name), type \(pet.type)")
						}
				}
		}
		
		mutating func addExamplePets() {
				if pets.isEmpty {
						let pets = [
								Pet(name: "Angel", type: .cat, favoriteToy: "String"),
								Pet(name: "Opal", type: .cat, favoriteToy: nil),
								Pet(name: "Kitty", type: .cat, favoriteToy: "Laser Pointer"),
								Pet(name: "Shinn", type: .cat, favoriteToy: nil),
								Pet(name: "Abbie", type: .dog, favoriteToy: "Ball"),
								Pet(name: "Rhea", type: .dog, favoriteToy: "Rope")
						]
						
						for pet in pets {
								addPet(pet)
						}
				}
				
		}
}
