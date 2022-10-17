//
//  CoreDataPet+CoreDataProperties.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/16/22.
//
//

import Foundation
import CoreData


extension CoreDataPet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataPet> {
        return NSFetchRequest<CoreDataPet>(entityName: "CoreDataPet")
    }

    @NSManaged public var name: String?
    @NSManaged public var favoriteToy: String?
    @NSManaged public var imageString: String?
    @NSManaged public var age: Int16
    @NSManaged public var birthday: String?
    @NSManaged public var trait: String?
    @NSManaged public var favorite: Bool
		
		var wrappedName: String {
				name ?? ""
		}
		
		var wrappedTrait: String {
				trait ?? "Cute"
		}
}

extension CoreDataPet : Identifiable {

}
