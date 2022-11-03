//
//  PetTabView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct PetTabView: View {
    @AppStorage("PetDairyCurrentTab") var selectedTab = 0
    @EnvironmentObject var model: PetModel
    @State private var showingAlert = false
    
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
        .task {
            if model.pets.isEmpty {
                do {
                    try await model.fetchPets()
                } catch {
                    print(error)
                    showingAlert = true
                }
            }
        }
        .alert("Network Problem", isPresented: $showingAlert) {
        } message: {
            Text("Couldn't connect to the network to fetch pets.\n Please check your connection.")
        }
    }
}

struct PetTabView_Previews: PreviewProvider {
    static var previews: some View {
        PetTabView()
            .environmentObject(PetModel())
        PetTabView()
            .previewLayout(.fixed(width: 568, height: 320))
            .environmentObject(PetModel())
        PetTabView()
            .preferredColorScheme(.dark)
            .environmentObject(PetModel())
        PetTabView()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 568, height: 320))
            .environmentObject(PetModel())
        PetTabView()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 926, height: 428))
            .environmentObject(PetModel())
    }
}
