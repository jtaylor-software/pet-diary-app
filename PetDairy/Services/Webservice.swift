//
//  Webservice.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/8/22.
//

import Foundation

enum NetworkError: Error {
		case badUrl, decodingError, badRequest
}

class Webservice {
		func getPets() async throws -> [Pet] {
				// https://br-cat-api.herokuapp.com/pets
				guard let url = URL(string: Constants.API.baseUrl.rawValue) else {
						throw NetworkError.badUrl
				}
				
				let (data, response) = try await URLSession.shared.data(from: url)
				guard let httpResponse = response as? HTTPURLResponse,
							httpResponse.statusCode == 200 else {
						throw NetworkError.badRequest
				}
				
				guard let pets = try? JSONDecoder().decode([Pet].self, from: data) else {
						throw NetworkError.decodingError
				}
				
				return pets
		}
}

