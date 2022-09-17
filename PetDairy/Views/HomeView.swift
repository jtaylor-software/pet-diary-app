//
//  ContentView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI

struct HomeView: View {
		@State private var pet = Pet()
		
		var body: some View {
				NavigationView {
						List(pet.pets) { pet in
								NavigationLink {
										PetDetailView(pet: pet)
								} label: {
										Text(pet.name)
										
								}

						}
						
						.navigationTitle("Pet List")
						
						WelcomeView()
				}
				.onAppear {
						pet.addExamplePets()
				}
		}
}

struct HomeView_Previews: PreviewProvider {
		static var previews: some View {
				HomeView()
				HomeView()
						.previewLayout(.fixed(width: 568, height: 320))
				HomeView()
						.preferredColorScheme(.dark)
				HomeView()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 568, height: 320))
				HomeView()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 926, height: 428))
		}
}
