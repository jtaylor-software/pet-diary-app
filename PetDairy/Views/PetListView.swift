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
                AsyncImage(url: URL(string: pet.imageString ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 128, height: 128)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                Text(pet.name)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                }
            }
        }
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
				PetListView(pet: PetModel.examplePet)
    }
}
