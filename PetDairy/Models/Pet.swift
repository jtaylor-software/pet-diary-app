//
//  Pet.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/25/22.
//
import Foundation

/*
Moving this to just a model as part of the refactoring to use MV Pattern
 */

struct Pet: Identifiable, Hashable, Codable {
		enum PetType: String, Codable {
				case cat, dog
		}
		
		
		var id = UUID()
		let name: String
		let type: PetType
		var favoriteToy: String?
		let imageString: String?
		var age: Int
		let birthday: String
		var trait: String
		
		init(name: String = "Tom", type :PetType = .cat, favoriteToy: String? = nil, imageString: String? = nil, age: Int = 1, birthday: String = "", trait: String = "Cute") {
				self.name = name
				self.type = type
				self.favoriteToy = favoriteToy
				self.imageString = imageString
				self.age = age
				self.birthday = birthday
				self.trait = trait
		}
}
