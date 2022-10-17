//
//  PetDairyApp.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI

@main
struct PetDairyApp: App {
		@StateObject private var model: PetModel // Part of MV Design Pattern & Observer Pattern
		@StateObject private var coreDataManager = CoreDataManager()
		
		init() { // Part of MV Design Pattern
				let webservice = Webservice()
				_model = StateObject(wrappedValue: PetModel(webservice: webservice))
		}
		
		var body: some Scene {
				WindowGroup {
						SplashScreen()
								.environmentObject(model) // Part of MV Design Pattern
								.environment(\.managedObjectContext, coreDataManager.container.viewContext)
				}
		}
}
