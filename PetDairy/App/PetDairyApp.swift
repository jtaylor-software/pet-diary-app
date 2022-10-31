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
        _model = StateObject(wrappedValue: PetModel())
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(model)
            
        }
    }
}
