//
//  Favorites.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import Foundation

class Favorites: ObservableObject {
		var pets: Array<Pet>
		private let saveKey = "Favorites"
		
		init() {
				if let data = UserDefaults.standard.data(forKey: saveKey) {
						if let decoded = try? JSONDecoder().decode(Array<Pet>.self, from: data) {
								pets = decoded
								return
						}
				}
				pets = []
		}
		
		func contains(_ pet: Pet) -> Bool {
				pets.contains(pet)
		}
		
		func add(_ pet: Pet) {
				objectWillChange.send()
				pets.insert(pet, at: 0)
				save()
		}
		
		func remove(_ pet: Pet) {
				guard let index = pets.firstIndex(of: pet) else { return }
				pets.remove(at: index)
				objectWillChange.send()
				
				save()
		}
		
		func save() {
				if let data = try? JSONEncoder().encode(pets) {
								UserDefaults.standard.set(data, forKey: saveKey)
				}
		}
}
