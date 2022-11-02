//
//  PetDetailView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/16/22.
//

import SwiftUI

struct PetDetailView: View {
    @EnvironmentObject var model: PetModel
    
    let data: Data
    let pet: Pet
    
    var body: some View {
        NavigationView {
            PetDetailsView(data: data, pet: pet)
        }
    }
}

struct PetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PetDetailView(data: Data(), pet: PetModel.examplePet)
            .environmentObject(PetModel())
    }
}

