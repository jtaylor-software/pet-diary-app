//
//  PetDairyApp.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI

@main
struct PetDairyApp: App {
		@StateObject private var model: PetModel // Part of MV Design Pattern
		@StateObject var favorites = Favorites()
		
		init() { // Part of MV Design Pattern
				_model = StateObject(wrappedValue: PetModel())
		}
		
    var body: some Scene {
        WindowGroup {
            PetTabView()
								.environmentObject(model) // Part of MV Design Pattern
								.environmentObject(favorites)
        }
    }
}
