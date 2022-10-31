//
//  PetDetailsView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct PetDetailsView: View {
    @EnvironmentObject var model: PetModel
    
    let data: Data
    let pet: Pet
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 20) {
                VStack {
                    
                    Image(uiImage: UIImage(data: data) ?? UIImage())
                            .resizable()
                        
                            .frame(width: 128, height: 128)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                    
                    
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
        PetDetailsView(data: Data(), pet: PetModel.examplePet)
            .environmentObject(PetModel())
    }
}
