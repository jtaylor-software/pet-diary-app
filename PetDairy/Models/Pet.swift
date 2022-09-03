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
		
		var pets = [Pet]()
		var itemPrices: [Double] = []
		
		
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
