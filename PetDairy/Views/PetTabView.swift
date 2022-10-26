//
//  PetTabView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct PetTabView: View {
    // Singleton pattern as AppStorage is a wrapper for UserDefaults
    @AppStorage("PetDairyCurrentTab") var selectedTab = 1
    @EnvironmentObject var model: PetModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                        .resizable()
                    Text("Home")
                }
                .tag(0)
            FavoritesView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                    
                }
                .tag(1)
                .badge(model.favoritePets.count)
        }
    }
}

struct PetTabView_Previews: PreviewProvider {
    static var previews: some View {
        PetTabView()
            .environmentObject(PetModel(webservice: Webservice()))
        PetTabView()
            .previewLayout(.fixed(width: 568, height: 320))
            .environmentObject(PetModel(webservice: Webservice()))
        PetTabView()
            .preferredColorScheme(.dark)
            .environmentObject(PetModel(webservice: Webservice()))
        PetTabView()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 568, height: 320))
            .environmentObject(PetModel(webservice: Webservice()))
        PetTabView()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 926, height: 428))
            .environmentObject(PetModel(webservice: Webservice()))
    }
}
