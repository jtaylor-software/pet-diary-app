//
//  FavoritesView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI

struct FavoritesView: View {
		@EnvironmentObject var favorites: Favorites
    var body: some View {
				NavigationView {
						List(favorites.pets) { pet in
								PetListView(pet: pet)
						}
						.navigationTitle("Favorite Pets")
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
