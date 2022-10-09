//
//  SplashScreen.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/8/22.
//

import SwiftUI

struct SplashScreen: View {
		@State private var emojiOffset: CGFloat = -1000
		@State private var resetEmojiAnimation = false
		@State private var emojis = Emojis.previewData
		@State private var isActive = false
		
		@EnvironmentObject var model: PetModel
		
		var body: some View {
				ZStack {
						Text("Welcome to Pet Diary!")
								.font(.largeTitle)
								.fontWeight(.bold)
						VStack {
								if isActive {
										PetTabView()
								} else {
										ForEach(emojis) { emoji in
												Text(emoji.emoji)
														.font(.largeTitle)
														.rotationEffect(.degrees(emoji.rotation))
														.offset(x: emoji.x, y: emojiOffset)
														.onAppear() {
																Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true) { timer in
																		if (emojiOffset >= 400) {
																				if (resetEmojiAnimation) {
																						Timer.scheduledTimer(withTimeInterval: 1, repeats: false) {_ in
																								emojiOffset = 0
																								resetEmojiAnimation.toggle()
																						}
																						resetEmojiAnimation = false
																						
																				}
																		}
																		withAnimation(.easeInOut(duration: 0.05)) {
																				emojiOffset += 1
																		}
																}
														}
										}
								}
						}
						.onAppear {
								DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
										withAnimation {
												self.isActive = true
										}
								}
								Task { @MainActor in
										model.webservice.getDataFromApi()
										await model.webservice.getCookie()
								}
						}
				}
		}
}

struct SplashScreen_Previews: PreviewProvider {
		static var previews: some View {
				SplashScreen()
						.environmentObject(PetModel())
				SplashScreen()
						.previewLayout(.fixed(width: 568, height: 320))
						.environmentObject(PetModel())
				SplashScreen()
						.preferredColorScheme(.dark)
						.environmentObject(PetModel())
				SplashScreen()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 568, height: 320))
						.environmentObject(PetModel())
				SplashScreen()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 926, height: 428))
						.environmentObject(PetModel())
		}
}

struct Emojis: Identifiable {
		let id = UUID()
		let emoji: String
		let rotation: Double
		let x: CGFloat
}

extension Emojis {
		static let previewData: [Emojis] = [
				Emojis(emoji: "😸", rotation: 0, x: 0),
				Emojis(emoji: "😻", rotation: 30, x: -100),
				Emojis(emoji: "🐶", rotation: 0, x: -50),
				Emojis(emoji: "🐕", rotation: 100, x: 30),
				Emojis(emoji: "🦴", rotation: 20, x: -120),
				Emojis(emoji: "😺", rotation: 0, x: 10),
				Emojis(emoji: "😸", rotation: 10, x: 70),
				Emojis(emoji: "🐶", rotation: 0, x: -40),
				Emojis(emoji: "🦆", rotation: 30, x: 90),
				Emojis(emoji: "🐹", rotation: 0, x: 140)
		]
}

