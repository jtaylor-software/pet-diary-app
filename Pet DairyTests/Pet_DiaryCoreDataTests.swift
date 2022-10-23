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
		var petService: PetService!
		
		override func setUp() {
				super.setUp()
				coreDataManager = TestCoreDataManager()
				petService = PetService(
						managedObjectContext: coreDataManager.mainContext,
						coreDataManager: coreDataManager)
		}
		
		override func tearDown() {
				super.tearDown()
				petService = nil
				coreDataManager = nil
		}
		
		func test_AddPet() {
				let pet = petService.add(name: "Fluffy", favoriteToy: "Socks", imageString: "https://jctaylor.org/fluffy.jpeg", age: 2, birthday: "7/4/2020", trait: "Playful!")
				
				XCTAssertNotNil(pet.name, "name should not be nil")
				XCTAssertNotNil(pet.age, "age should not be nil")
				XCTAssertTrue(pet.imageString == "https://jctaylor.org/fluffy.jpeg")
				XCTAssertTrue(pet.birthday == "7/4/2020")
				XCTAssertTrue(pet.favoriteToy == "Socks")
				XCTAssertTrue(pet.trait == "Playful!")
		}
		
		func test_SavePet() {
				let derivedContext = coreDataManager.newDerivedContext()
					expectation(
						forNotification: .NSManagedObjectContextDidSave,
						object: coreDataManager.mainContext) { _ in
							return true
					}

					derivedContext.perform {
							let pet = self.petService.add(name: "Fluffy", favoriteToy: "Socks", imageString: "https://jctaylor.org/fluffy.jpeg", age: 2, birthday: "7/4/2020", trait: "Playful!")

						XCTAssertNotNil(pet)
					}

					waitForExpectations(timeout: 2.0) { error in
						XCTAssertNil(error, "Save did not occur")
					}
		}
		
		func test_GetPet() {
				_ = petService.add(name: "Fluffy", favoriteToy: "Socks", imageString: "https://jctaylor.org/fluffy.jpeg", age: 2, birthday: "7/4/2020", trait: "Playful!")
		
				let getPets = petService.getPets()

				XCTAssertNotNil(getPets)
				XCTAssertTrue(getPets?.count == 1)
		}

}
