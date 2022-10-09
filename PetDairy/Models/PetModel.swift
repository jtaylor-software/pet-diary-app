//
//  PetModel.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/22/22.
//

import Foundation

/*
 Aggragate root - part of MV Design Pattern
 */

@MainActor
class PetModel: ObservableObject { // Observer pattern
		@Published private(set) var pets: [Pet] = []
		@Published private (set) var favoritePets: [Pet] = []
		
		var description = ""
		
		static let examplePet = Pet(name: "Angel", type: .cat, favoriteToy: "String", imageString: "angel", age: 9, birthday: "8/13/2013", trait: "Loveable and lazy.")
		
		init() {
				loadFavorites()
		}
		
		private func addPet(_ pet: Pet) {
				pets.append(pet)
		}
		
		func addExamplePets() {
				if pets.isEmpty {
						let pets = [
								Pet(name: "Angel", type: .cat, favoriteToy: "String", imageString: "angel", age: 9, birthday: "8/13/2013", trait: "Loveable and lazy."),
								Pet(name: "Opal", type: .cat, favoriteToy: nil, imageString: "opal", age: 6, birthday: "9/1/2016", trait: "An energetic destroyer of all things!"),
								Pet(name: "Kitty", type: .cat, favoriteToy: "Laser Pointer", imageString: "kitty", age: 16,birthday: "6/1/1997", trait: "The eater of treats."),
								Pet(name: "Shinn", type: .cat, favoriteToy: nil, imageString: "shinn", age: 4,birthday: "5/4/2018", trait: "A cuddle bug"),
								Pet(name: "Abbie", type: .dog, favoriteToy: "Ball", imageString: "abbie", age: 5,birthday: "7/6/2017", trait: "A lover of snow."),
								Pet(name: "Rhea", type: .dog, favoriteToy: "Rope", imageString: "rhea", age: 5,birthday: "4/3/2017", trait: "Exciteable!")
						]
						
						for pet in pets {
								addPet(pet)
						}
				}
				
		}
		
		func favoritesContains(_ pet: Pet) -> Bool {
				favoritePets.contains(pet)
		}
		
		func addFavorite(_ pet: Pet) {
				objectWillChange.send()
				favoritePets.insert(pet, at: 0)
				saveFavorites()
		}
		
		func removeFavorite(_ pet: Pet) {
				guard let index = favoritePets.firstIndex(of: pet) else { return }
				favoritePets.remove(at: index)
				objectWillChange.send()
				
				saveFavorites()
		}
		
		func getDocumentsDirectory() -> URL {
				// find all possible documents directories for this user
				let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
				
				// just send back the first one, which ought to be the only one
				return paths[0]
		}
		
		func loadFavorites() {
				// Memento pattern
				let url = getDocumentsDirectory().appendingPathComponent("Favorites.json")
				do {
						let jsonData = try Data(contentsOf: url)
						let favorites = try JSONDecoder().decode([Pet].self, from: jsonData)
						favoritePets = favorites
				} catch {
						print("Error loading json data.")
				}
		}
		
		func saveFavorites() {
				/* Refactor save method to write a plist to user documents directory.
				 Memento pattern
				 */
				
				let url = getDocumentsDirectory().appendingPathComponent("Favorites.json")
				do {
						let savedData =	try JSONEncoder().encode(favoritePets)
						try savedData.write(to: url)
				} catch {
						print("Error saving json data")
				}
		}
		
		// MARK: - Assignment 2 and 3
		
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
