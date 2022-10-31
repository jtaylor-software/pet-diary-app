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
//                if let image = pet.imageData {
//                    Image(data: image)!
//                        .frame(width: 128, height: 128)
//                        .clipShape(RoundedRectangle(cornerRadius: 25))
//                }
                
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
