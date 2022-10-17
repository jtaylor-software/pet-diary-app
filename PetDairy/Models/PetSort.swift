//
//  PetSort.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/16/22.
//

import Foundation

struct PetSort: Hashable, Identifiable {
		let id: Int
		let name: String
		let descriptors: [SortDescriptor<CoreDataPet>]
		
		static let sorts: [PetSort] = [
				
				PetSort(
						id: 0,
						name: "Name | Descending",
						descriptors: [
								SortDescriptor(\CoreDataPet.name, order: .reverse)
						]),
				PetSort(
						id: 1,
						name: "Name | Ascending",
						descriptors: [
								SortDescriptor(\CoreDataPet.name, order: .forward)
						]),
				PetSort(
						id: 2,
						name: "Age | Ascending",
						descriptors: [
								SortDescriptor(\CoreDataPet.age, order: .forward),
								SortDescriptor(\CoreDataPet.name, order: .forward)
						]),
				PetSort(
						id: 3,
						name: "Age | Descending",
						descriptors: [
								SortDescriptor(\CoreDataPet.age, order: .reverse),
								SortDescriptor(\CoreDataPet.name, order: .forward)
						])
		]
		static var `default`: PetSort { sorts[3] }
}
