//
//  PetDetailsView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct PetDetailsView: View {
		@EnvironmentObject var favorites: Favorites
		
		let pet: Pet
		
		var body: some View {
				GeometryReader { geo in
						HStack {
								VStack {
										ZStack(alignment: .bottomLeading) {
												Image(pet.imageString!)
																.resizable()
																.scaledToFit()
																.clipShape(Circle())
														.frame(width: geo.size.width * 0.65)
												
												Text("Birthday: \(pet.birthday)")
														.background(.black.opacity(0.8))
														.font(.callout.bold())
														.foregroundColor(.white)
														.frame(width: geo.size.width * 0.65, height: geo.size.height * 0.05)
														
										}
														
										Button {
												if favorites.contains(pet) {
														favorites.remove(pet)
												} else {
														favorites.add(pet)
												}
										} label: {
												Text(favorites.contains(pet) ? "Remove favorite" : "Favorite")
														.padding()
										}
										
								}
								.padding(.leading)
								
								VStack(alignment: .leading, spacing: 5) {
										Text("Name: \(pet.name)")
										Text("Age: \(pet.age)")
										Text("Bio: \(pet.trait)")
										
								}
						}
				}
		}
				
}


struct PetDetailsView_Previews: PreviewProvider {
		static var previews: some View {
				PetDetailsView(pet: Pet.examplePet)
						.environmentObject(Favorites())
		}
}
