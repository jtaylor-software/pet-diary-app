//
//  PetDetailView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/16/22.
//

import SwiftUI

struct PetDetailView: View {
		let pet: Pet
    var body: some View {
				Text("Pet Detail View \(pet.name)")
    }
}

struct PetDetailView_Previews: PreviewProvider {
    static var previews: some View {
				PetDetailView(pet:(Pet(name: "Angel", type: .cat, favoriteToy: "String")))
    }
}
