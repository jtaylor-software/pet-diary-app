//
//  PetDetailView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/16/22.
//

import SwiftUI

struct PetDetailView: View {
		let pet: CoreDataPet
    
		var body: some View {
				NavigationView {
						PetDetailsView(pet: pet)
				}
    }
}

//struct PetDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//				PetDetailView(pet: PetModel.examplePet)
//						.environmentObject(PetModel(webservice: Webservice()))
//    }
//}

