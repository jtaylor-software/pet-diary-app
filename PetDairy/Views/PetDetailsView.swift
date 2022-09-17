//
//  PetDetailsView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct PetDetailsView: View {
		let pet: Pet
		
		var body: some View {
				GeometryReader { geo in
						HStack {
								VStack {
										Image(pet.imageString!)
												.resizable()
												.scaledToFit()
												.clipShape(Circle())
												.frame(width: geo.size.width * 0.65)
										
										Button {
												Pet.favorite(pet)
										} label: {
												Text("Favorite")
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
		}
}
