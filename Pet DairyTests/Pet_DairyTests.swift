//
//  Pet_DairyTests.swift
//  Pet DairyTests
//
//  Created by Jeremy Taylor on 10/22/22.
//

import XCTest
@testable import Pet_Dairy

final class Pet_DairyTests: XCTestCase {
		var expectation: XCTestExpectation!
		let timeout: TimeInterval = 2
		
		override func setUp() {
				expectation = expectation(description: "Server responds in reasonable time")
		}
		
		func test_noServerResponse() {
				let url = URL(string: "https://invalidurl")!
				URLSession.shared.dataTask(with: url) { data, response, error in
						defer { self.expectation.fulfill() }
						XCTAssertNil(data)
						XCTAssertNil(response)
						XCTAssertNotNil(error)
				}
				.resume()
				
				waitForExpectations(timeout: timeout)
		}
		
		func test_decodePets() {
				let url = URL(string: Constants.API.baseUrl.rawValue)!
				
				URLSession.shared.dataTask(with: url) { data, response, error in
						defer { self.expectation.fulfill() }
						
						XCTAssertNil(error)
				}
				.resume()
				
				waitForExpectations(timeout: timeout)
		}
}
