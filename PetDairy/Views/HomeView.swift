//
//  ContentView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI

struct HomeView: View {
	@State private var isShowingOnboarding = false
	
	var body: some View {
		NavigationView {
			Text("This will list user pets.")
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
		
		.sheet(isPresented: $isShowingOnboarding) {
			OnboardingView()
		}
		
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
