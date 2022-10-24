//
//  Pet_DairyUITests.swift
//  Pet DairyUITests
//
//  Created by Jeremy Taylor on 10/23/22.
//

import XCTest

class Pet_DairyUITests: XCTestCase {
		let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
				app.launch()

		}
		
//		func test_HomeButton() {
//				
//				let tabBar = app.tabBars["Tab Bar"]
//				let homeTabBarButton = tabBar.buttons["Home"]
//				
//				homeTabBarButton.tap()
//		}
		
		func testPlayingWithQueries() {
				let app = XCUIApplication()
				let tabBars = app.tabBars

				let buttonOrder = [tabBars.buttons.element(boundBy: 0)]
				print(buttonOrder)
			}
}
