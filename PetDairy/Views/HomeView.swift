//
//  ContentView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI
import CoreData

struct HomeView: View {
		@EnvironmentObject var model: PetModel // Part of MV Design Pattern
		@FetchRequest(
				sortDescriptors: [])
		var pets: FetchedResults<CoreDataPet>
		
		var body: some View {
				NavigationView {
						List(pets) { pet in
								PetListView(pet: pet)
								
						}
						.toolbar {
								ToolbarItemGroup(placement: .navigationBarTrailing) {
										
								}
						}
						
						.navigationTitle("Pet List")
						.navigationViewStyle(.stack)
				}
		}
}

struct HomeView_Previews: PreviewProvider {
		static var previews: some View {
				HomeView()
						.environmentObject(PetModel(webservice: Webservice()))
				HomeView()
						.previewLayout(.fixed(width: 568, height: 320))
						.environmentObject(PetModel(webservice: Webservice()))
				HomeView()
						.preferredColorScheme(.dark)
						.environmentObject(PetModel(webservice: Webservice()))
				HomeView()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 568, height: 320))
						.environmentObject(PetModel(webservice: Webservice()))
				HomeView()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 926, height: 428))
						.environmentObject(PetModel(webservice: Webservice()))
		}
}

