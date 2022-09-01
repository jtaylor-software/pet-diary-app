//
//  WelcomeView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI

struct WelcomeView: View {
	var body: some View {
		VStack {
			Text("Welcome to Pet Diary!")
				.font(.largeTitle)
			
			Text("Please swipe from the left edge to show the left-hand menu.")
				.foregroundColor(.secondary)
		}
		
	}
}

struct WelcomeView_Previews: PreviewProvider {
	static var previews: some View {
		WelcomeView()
			WelcomeView()
					.previewLayout(.fixed(width: 568, height: 320))
			WelcomeView()
					.preferredColorScheme(.dark)
			WelcomeView()
					.preferredColorScheme(.dark)
					.previewLayout(.fixed(width: 568, height: 320))
	}
}
