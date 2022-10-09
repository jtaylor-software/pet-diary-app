//
//  Webservice.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/8/22.
//

import Foundation

class Webservice {
		// MARK: - Assignment 2 and 3
		var description = ""
		
		enum NetworkError: Error {
				case badUrl
				case badRequest
		}
		
		func getDataFromApi() async throws {
				// https://api.thecatapi.com/v1/images/search?limit=10&breed_ids=beng&api_key
				
				let configuration = URLSessionConfiguration.default
				let session = URLSession(configuration: configuration)
				
				var components = URLComponents()
						components.scheme = "https"
						components.host = "api.thecatapi.com"
						components.path = "/v1/images/search"
						components.queryItems = [
								URLQueryItem(name: "limit", value: "10"),
								URLQueryItem(name: "breed_ids", value: "beng"),
								URLQueryItem(name: "api_key", value: "live_OS0AlihNEPcNEc2RH2NFpzFNk0LkwEzaPODESSsQT0kv4LCFhrJDo6r3Vb5iUIRy")
						]
				
				guard let url = components.url else {
						throw NetworkError.badUrl
				}
			
				let (data, response) = try await session.data(from: url)
				guard let httpResponse = response as? HTTPURLResponse,
							(200..<300).contains(httpResponse.statusCode) else {
						throw NetworkError.badRequest
				}
				print("Data Downloaded \(data)")
				
		}
		
		// MARK: - Assignment 5
		
		func getCookie() async {
			func setDescription(for cookies: [HTTPCookie]? = nil) {
				Task { @MainActor in
					guard let cookies = cookies, !cookies.isEmpty else {
						description = "Cookies: N/A"

						return
					}

					var descriptionString = ""
						guard let cookie = cookies.first else {
								descriptionString = "No cookies"
								return
						}

						descriptionString += "Cookie name: \(cookie.name) Cookie value: \(cookie.value)\n"
					

					description = descriptionString
						print(description)
				}
			}

			guard let url = URL(string: "https://raywenderlich.com") else {
				setDescription()

				return
			}

			do {
				let (_, response) = try await URLSession.shared.data(from: url)

				guard let httpResponse = response as? HTTPURLResponse,
					let fields = httpResponse.allHeaderFields as? [String: String]
				else {
					setDescription()

					return
				}

				let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)

				setDescription(for: cookies)
			} catch {
				setDescription()
			}
		}
}
