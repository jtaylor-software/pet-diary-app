//
//  PetDairyApp.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI

@main
struct PetDairyApp: App {
		@StateObject var favorites = Favorites()
		
    var body: some Scene {
        WindowGroup {
            PetTabView()
								.environmentObject(favorites)
        }
    }
}
