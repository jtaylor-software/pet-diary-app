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
		
		// MARK - Assignment 13
		
		/*
		 I'm adding the ItemDiscountType enum to the app along with the totalAmountAfterDiscount method, the roundToInt extension and an empty itemPrices array, and a method to display some example data. At this point I can see these being thge most useful in future weeks
		 */
		
		enum ItemDiscountType: Double, Comparable, CaseIterable {
				case standard = 5
				case thanksgiving = 10
				case christmas = 15
				case newyear = 20
				
				static func <(lhs: ItemDiscountType, rhs: ItemDiscountType) -> Bool {
						return lhs.rawValue < rhs.rawValue
				}
		}
		let id = UUID()
		let name: String
		let type: PetType
		var favoriteToy: String?
		let imageString: String?
		var age: Int
		var trait: String
		
		var pets = [Pet]()
		static var favorites = [Pet]()
		var itemPrices: [Double] = []
		
		
		init(name: String = "Tom", type :PetType = .cat, favoriteToy: String? = nil, imageString: String? = nil, age: Int = 1, trait: String = "Cute") {
				self.name = name
				self.type = type
				self.favoriteToy = favoriteToy
				self.imageString = imageString
				self.age = age
				self.trait = trait
		}
		
		static let examplePet = Pet(name: "Angel", type: .cat, favoriteToy: "String", imageString: "angel", age: 16, trait: "Loveable and lazy.")
		
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
								Pet(name: "Angel", type: .cat, favoriteToy: "String", imageString: "angel", age: 9, trait: "Loveable and lazy."),
								Pet(name: "Opal", type: .cat, favoriteToy: nil, imageString: "opal", age: 6, trait: "An energetic destroyer of all things!"),
								Pet(name: "Kitty", type: .cat, favoriteToy: "Laser Pointer", imageString: "kitty", age: 16, trait: "The eater of treats."),
								Pet(name: "Shinn", type: .cat, favoriteToy: nil, imageString: "shinn", age: 4, trait: "A cuddle bug"),
								Pet(name: "Abbie", type: .dog, favoriteToy: "Ball", imageString: "abbie", age: 5, trait: "A lover of snow."),
								Pet(name: "Rhea", type: .dog, favoriteToy: "Rope", imageString: "rhea", age: 5, trait: "Exciteable!")
						]
						
						for pet in pets {
								addPet(pet)
						}
				}
				
		}
		
		static func favorite(_ pet: Pet) {
				favorites.append(pet)
				print(favorites)
		}
		
		mutating func addExampleItemPrices() {
				if itemPrices.isEmpty {
						itemPrices = [
								25.0, 3.50, 2.25, 32.50, 7, 10, 12.25
						]
				}
		}
		
		func totalAmountAfterDiscount(totalAmount: Double, defaultDiscountPercentage: Double = 10.0) -> Double {
				let discountedAmount = totalAmount * defaultDiscountPercentage / 100
				return totalAmount - discountedAmount
		}
}

extension Double {
		func roundToInt() -> Int {
				Int(Darwin.round(self))
		}
}
