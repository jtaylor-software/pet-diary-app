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
		
		var id: UUID?
		let name: String
		var favoriteToy: String?
		let imageString: String?
		var age: Int16
		let birthday: String
		var trait: String
}
