//
//  OnboardingView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI

struct OnboardingView: View {
		@Environment(\.colorScheme) var colorScheme
		@Environment(\.dismiss) var dismiss
		
		var body: some View {
				VStack {
						Text("Pet Diary!")
								.padding()
								.foregroundColor(.primary)
						
						GeometryReader { geo in
								Image((colorScheme == .light ? Constants.Onboarding.lightModeCatImage : Constants.Onboarding.darkModeCatImage).rawValue)
										.resizable()
										.scaledToFit()
										.clipShape(Capsule())
										.frame(width: geo.size.width * 0.8)
										.frame(width: geo.size.width, height: geo.size.height)
						}
						Group {
								Text("Keep track of all your pets in one place.")
								Text("See detailed information for each pet.")
								Text("Add and track expenses for each pet.")
								Text("Add images of your pets to a photo gallery.")
								Text("See a list and images of your pets friends.")
						}
				}
		}
}

struct OnboardingView_Previews: PreviewProvider {
		static var previews: some View {
				OnboardingView()
				OnboardingView()
						.previewLayout(.fixed(width: 568, height: 320))
				OnboardingView()
						.preferredColorScheme(.dark)
				OnboardingView()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 568, height: 320))
		}
}
