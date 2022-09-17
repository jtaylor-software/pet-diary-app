//
//  FavoritesView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
				List(Pet.favorites) { pet in
						PetListView(pet: pet)
				}
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
				FavoritesView()
						.previewLayout(.fixed(width: 568, height: 320))
				FavoritesView()
						.preferredColorScheme(.dark)
				FavoritesView()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 568, height: 320))
				FavoritesView()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 926, height: 428))
    }
}
