//
//  Constants.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import Foundation

enum Constants {
	enum General: Int {
		case OnboardingImageFrame = 48
	}
	
	enum Onboarding: String {
		case lightModeCatImage = "lightModeCatOnboarding"
		case darkModeCatImage = "darkModeCatOnboarding"
		case circleImage = "circle"
	}
		
		enum API: String {
				case baseUrl = "https://br-cat-api.herokuapp.com/pets"
		}
}
