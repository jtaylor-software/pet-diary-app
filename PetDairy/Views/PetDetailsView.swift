//
//  PetDetailsView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct PetDetailsView: View {
    @EnvironmentObject var model: PetModel
    @State private var fact = ""
    
    let data: Data
    let pet: Pet
    
    var body: some View {
        GeometryReader { geo in
            VStack {
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
                Text("Did You Know?")
                    .fontWeight(.semibold)
                    .padding(.vertical, 5)
                Text(fact)
                
                Spacer()
                
                Button {
                    fact = model.randomPetFact()
                } label: {
                    Text("New Pet Fact")
                }
            }
            .onAppear {
                fact = model.randomPetFact()
            }
            .padding()
            
        }
       
    }
    
}


struct PetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PetDetailsView(data: Data(), pet: PetModel.examplePet)
            .environmentObject(PetModel())
    }
}
