//
//  CoreDataManager.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/16/22.
//

import Foundation
import CoreData

class CoreDataManager {
		static let shared = CoreDataManager()
		private var persistentContainer: NSPersistentContainer
		
		private init() {
				persistentContainer = NSPersistentContainer(name: "PetModel")
				persistentContainer.loadPersistentStores { description, error in
						if let error = error {
								fatalError("Unable to initialize Core Data stack \(error)")
						}
				}
		}
		
		var viewContext: NSManagedObjectContext {
				persistentContainer.viewContext
		}
}
