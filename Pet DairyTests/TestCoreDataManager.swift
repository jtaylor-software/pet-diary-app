//
//  TestCoreDataManager.swift
//  Pet DairyTests
//
//  Created by Jeremy Taylor on 10/23/22.
//

import XCTest
import CoreData
@testable import Pet_Dairy

class TestCoreDataManager: CoreDataManager {
		override init() {
				super.init()
				
				let persistentStoreDescription = NSPersistentStoreDescription()
				persistentStoreDescription.type = NSInMemoryStoreType
				
				let container = NSPersistentContainer(
						name: CoreDataManager.modelName)
				
				container.persistentStoreDescriptions = [persistentStoreDescription]
				
				container.loadPersistentStores { _, error in
						if let error = error as NSError? {
								fatalError("Unresolved error \(error), \(error.userInfo)")
						}
				}
				
				storeContainer = container
		}
}
