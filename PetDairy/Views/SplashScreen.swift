//
//  SplashScreen.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/8/22.
//

import SwiftUI

struct SplashScreen: View {
		@EnvironmentObject var model: PetModel
		
		var body: some View {
				VStack {
						Text("Splash screen")
				}
				.onAppear {
						Task { @MainActor in
								do {
										try await model.webservice.getDataFromApi()
								} catch {
										print(error)
								}
								await model.webservice.getCookie()
						}
				}
		}
}

struct SplashScreen_Previews: PreviewProvider {
		static var previews: some View {
				SplashScreen()
		}
}
