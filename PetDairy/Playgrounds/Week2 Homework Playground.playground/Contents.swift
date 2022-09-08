import UIKit

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
}

let angel = Pet(name: "Angel", type: .cat, favoriteToy: "String")
let opal = Pet(name: "Opal", type: .cat, favoriteToy: nil)
let kitty = Pet(name: "Kitty", type: .cat, favoriteToy: "Laser Pointer")
let shinn = Pet(name: "Shinn", type: .cat, favoriteToy: nil)
let abbie = Pet(name: "Abbie", type: .dog, favoriteToy: "Ball")
let rhea = Pet(name: "Rhea", type: .dog, favoriteToy: "Rope")


var pet = Pet()
pet.addPet(angel)
pet.addPet(opal)
pet.addPet(kitty)
pet.addPet(shinn)
pet.addPet(abbie)
pet.addPet(rhea)

pet.printInfoForPets(pet.pets)
