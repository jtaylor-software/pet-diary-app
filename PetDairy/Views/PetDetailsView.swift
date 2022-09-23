//
//  PetDetailsView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct PetDetailsView: View {
		@EnvironmentObject var model: PetModel // Part of MV Design Pattern
		
		let pet: Pet
		
		var body: some View {
				GeometryReader { geo in
						HStack(spacing: 20) {
								VStack {
												Image(pet.imageString!)
																.resizable()
																.scaledToFit()
																.frame(width: geo.size.width * 0.45, alignment: .bottomTrailing)
														.clipShape(Circle())
														
										Button {
												if model.favoritesContains(pet) {
														model.removeFavorite(pet)
												} else {
														model.addFavorite(pet)
												}
										} label: {
												Text(model.favoritesContains(pet) ? "Remove favorite" : "Favorite")
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
				PetDetailsView(pet: PetModel.examplePet)
						.environmentObject(PetModel())
		}
}
