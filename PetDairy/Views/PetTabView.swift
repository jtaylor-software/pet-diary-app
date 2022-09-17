//
//  PetTabView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct PetTabView: View {
		@AppStorage("PetDairyCurrentTab") var selectedTab = 1
		@EnvironmentObject var favorites: Favorites
		
		var body: some View {
				TabView(selection: $selectedTab) {
						OnboardingView()
								.tabItem {
										Image(systemName: "pawprint.circle")
												.resizable()
										Text("Features")
								}
								.tag(0)
						HomeView()
								.tabItem {
										Image(systemName: "house")
												.resizable()
										Text("Home")
								}
								.tag(1)
						FavoritesView()
								.tabItem {
										Image(systemName: "star")
										Text("Favorites")
										
								}
								.tag(2)
								.badge(favorites.pets.count)
				}
		}
}

struct PetTabView_Previews: PreviewProvider {
		static var previews: some View {
				PetTabView()
				PetTabView()
						.previewLayout(.fixed(width: 568, height: 320))
				PetTabView()
						.preferredColorScheme(.dark)
				PetTabView()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 568, height: 320))
				PetTabView()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 926, height: 428))
		}
}
