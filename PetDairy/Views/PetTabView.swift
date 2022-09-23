//
//  PetTabView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct PetTabView: View {
		@AppStorage("PetDairyCurrentTab") var selectedTab = 1
		@EnvironmentObject var model: PetModel
		
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
								.badge(model.favoritePets.count)
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
