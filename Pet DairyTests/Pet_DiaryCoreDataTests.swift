//
//  Pet_DiaryCoreDataTests.swift
//  Pet DairyTests
//
//  Created by Jeremy Taylor on 10/23/22.
//

import XCTest
@testable import Pet_Dairy

class PetDiaryCoreDataTest: XCTestCase {
		var coreDataManager: CoreDataManager!
		var coreDataPet: CoreDataPet!
		
		override func setUp() {
				super.setUp()
				coreDataManager = TestCoreDataManager()
				coreDataPet = CoreDataPet(context: coreDataManager.mainContext)
		}
		
		override func tearDown() {
				super.tearDown()
				coreDataPet = nil
				coreDataManager = nil
		}
		
		func testAddPet() {
				let pet = coreDataPet
				coreDataPet.name = "Fluffy"
				coreDataPet.age = 2
				coreDataPet.birthday = "7/4/2020"
				coreDataPet.favoriteToy = "Socks"
				coreDataPet.trait = "Playful!"
				
				XCTAssertNotNil(pet?.name, "name should not be nil")
				XCTAssertNotNil(pet?.age, "age should not be nil")
				XCTAssertTrue(pet?.birthday == "7/4/2022")
				XCTAssertTrue(pet?.favoriteToy == "Socks")
				XCTAssertTrue(pet?.trait == "Playful!")
		}
}
