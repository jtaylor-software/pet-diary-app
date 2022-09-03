//
//  ContentView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI

struct HomeView: View {
		@State private var isShowingOnboarding = false
		@State private var pet = Pet()
		
		var body: some View {
				NavigationView {
						ForEach(pet.pets) { pet in
								
								VStack(alignment: .leading) {
										HStack {
												Text(pet.name)
												Text("Favorite toy: \(pet.favoriteToy ?? "Anything")")
										}
								}
						}
						
						// MARK: - Assignment 13 test code
						
						ForEach(pet.itemPrices, id: \.self) { item in
								VStack(alignment: .leading) {
										Text("Total amount after discount $\(pet.totalAmountAfterDiscount(totalAmount: item).roundToInt())")
								}
						}
						
						
						.navigationTitle("Welcome, Jeremy!")
						.toolbar {
								ToolbarItem(placement: .navigationBarTrailing) {
										Button {
												isShowingOnboarding = true
										} label: {
												Image(systemName: "pawprint.circle")
														.resizable()
														.frame(width: CGFloat(Constants.General.OnboardingImageFrame.rawValue), height: CGFloat(Constants.General.OnboardingImageFrame.rawValue))
														.padding(.top)
										}
										
								}
						}
						WelcomeView()
				}
				.onAppear {
						pet.addExamplePets()
						pet.addExampleItemPrices()
						
				}
				
				.sheet(isPresented: $isShowingOnboarding) {
						OnboardingView()
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
