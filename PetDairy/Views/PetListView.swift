//
//  PetListView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct PetListView: View {
		let pet: Pet
		
		var body: some View {
				NavigationLink {
						PetDetailView(pet: pet)
				} label: {
						HStack {
								Image(pet.imageString!)
										.resizable()
										.scaledToFit()
										.clipShape(Circle())
										.frame(width: 100, height: 100)
								Text(pet.name)
						}
						
				}
		}
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
				PetListView(pet: PetModel.examplePet)
    }
}
