//
//  PetService.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/23/22.
//

import Foundation
import CoreData

class PetService {
		// MARK: - Properties
		let managedObjectContext: NSManagedObjectContext
		let coreDataManager: CoreDataManager
		
		// MARK: - Initializers
		init(managedObjectContext: NSManagedObjectContext, coreDataManager: CoreDataManager) {
				self.managedObjectContext = managedObjectContext
				self.coreDataManager = coreDataManager
		}
}

extension PetService {
		@discardableResult
		public func add(name: String?, favoriteToy: String?, imageString: String?, age: Int16, birthday: String?, trait: String?) -> CoreDataPet {
				let pet = CoreDataPet(context: managedObjectContext)
				pet.name = name
				pet.favoriteToy = favoriteToy
				pet.imageString = imageString
				pet.age = age
				pet.birthday = birthday
				pet.trait = trait
				
				coreDataManager.saveContext(managedObjectContext)
				return pet
		}
		
		public func getPets() -> [CoreDataPet]? {
				let petsFetch: NSFetchRequest<CoreDataPet> = CoreDataPet.fetchRequest()
				do {
						let results = try managedObjectContext.fetch(petsFetch)
						return results
				} catch let error as NSError {
						print("Fetch error: \(error) description: \(error.userInfo)")
				}
				return nil
		}
		
		@discardableResult
		public func update(_ pet: CoreDataPet) -> CoreDataPet {
				coreDataManager.saveContext(managedObjectContext)
				return pet
		}
		
		public func delete(_ pet: CoreDataPet) {
				managedObjectContext.delete(pet)
				coreDataManager.saveContext(managedObjectContext)
		}
}
