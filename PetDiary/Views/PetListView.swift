//
//  PetListView.swift
//  PetDiary
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct PetListView: View {
    @EnvironmentObject var model: PetModel
    @State var data: Data
    
    var pet: Pet
    
    var body: some View {
        NavigationLink {
            PetDetailView(data: data, pet: pet)
        } label: {
            HStack {
                Image(uiImage: UIImage(data: data) ?? UIImage())
                    .resizable()
                    .frame(width: 128, height: 128)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                Text(pet.name)
            }
        }
        .onAppear {
            data = model.loadImageFor(pet) 
        }
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        PetListView(data: Data(), pet: PetModel.examplePet)
    }
}
