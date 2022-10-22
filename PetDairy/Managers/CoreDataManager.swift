//
//  CoreDataManager.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/16/22.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
		let container = NSPersistentContainer(name: "PetModel")
		
		init() {
				container.loadPersistentStores { description, error in
						if let error = error {
								print("Core Data failed to load: \(error.localizedDescription)")
						}
						self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
				}
		}
}
