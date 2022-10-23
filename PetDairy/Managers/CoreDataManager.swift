//
//  CoreDataManager.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/16/22.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
	public static let modelName = "PetModel"

	public init() {
	}

	public lazy var mainContext: NSManagedObjectContext = {
		return storeContainer.viewContext
	}()

	public lazy var storeContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: CoreDataManager.modelName)
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()

	public func newDerivedContext() -> NSManagedObjectContext {
		let context = storeContainer.newBackgroundContext()
		return context
	}

	public func saveContext() {
		saveContext(mainContext)
	}

	public func saveContext(_ context: NSManagedObjectContext) {
		if context != mainContext {
			saveDerivedContext(context)
			return
		}

		context.perform {
			do {
				try context.save()
			} catch let error as NSError {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}
	}

	public func saveDerivedContext(_ context: NSManagedObjectContext) {
		context.perform {
			do {
				try context.save()
			} catch let error as NSError {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}

			self.saveContext(self.mainContext)
		}
	}
}
