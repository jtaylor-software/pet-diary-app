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
    let network = NetworkMonitor()
    
    
    init() {
        let webservice = Webservice()
        _model = StateObject(wrappedValue: PetModel(webservice: webservice))
    }
    
    var body: some Scene {
        WindowGroup {
            if !network.isActive {
                NoNetworkView()
                    .environmentObject(model)
                    .environmentObject(network)
            } else {
                SplashScreen()
                    .environmentObject(model)
                    .environmentObject(network)
            }
        }
    }
}
