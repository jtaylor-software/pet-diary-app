////
////  FavoritesView.swift
////  PetDiary
////
////  Created by Jeremy Taylor on 9/17/22.
////

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var model: PetModel
    var body: some View {
        NavigationView {
            List(model.favoritePets) { pet in
                PetListView(data: Data(), pet: pet)
            }
            .navigationTitle("Favorite Pets")
            .navigationViewStyle(.stack)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(PetModel())
        FavoritesView()
            .previewLayout(.fixed(width: 568, height: 320))
            .environmentObject(PetModel())
        FavoritesView()
            .preferredColorScheme(.dark)
            .environmentObject(PetModel())
        FavoritesView()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 568, height: 320))
            .environmentObject(PetModel())
        FavoritesView()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 926, height: 428))
            .environmentObject(PetModel())
    }
}
