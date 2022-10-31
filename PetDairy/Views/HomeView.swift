//
//  ContentView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: PetModel
    @State private var isShowingAddPet = false
    
    var body: some View {
        NavigationView {
            List(model.pets) { pet in
                PetListView(data: Data(), pet: pet)
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddPet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddPet) {
                AddUpdatePetView()
            }
            
            .navigationTitle("Pet List")
            .navigationViewStyle(.stack)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PetModel())
        HomeView()
            .previewLayout(.fixed(width: 568, height: 320))
            .environmentObject(PetModel())
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(PetModel())
        HomeView()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 568, height: 320))
            .environmentObject(PetModel())
        HomeView()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 926, height: 428))
            .environmentObject(PetModel())
    }
}

