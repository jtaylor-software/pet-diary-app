//
//  PetDairyApp.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI

@main
struct PetDairyApp: App {
		@StateObject private var model: PetModel
		
		init() {
				let webservice = Webservice()
				_model = StateObject(wrappedValue: PetModel(webservice: webservice))
		}
		
		var body: some Scene {
				WindowGroup {
						SplashScreen()
								.environmentObject(model) 
				}
		}
}
