//
//  ContentView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import SwiftUI
import CoreData

struct HomeView: View {
		@EnvironmentObject var model: PetModel // Part of MV Design Pattern
		@Environment(\.managedObjectContext) private var viewContext
		@FetchRequest(
				sortDescriptors: PetSort.default.descriptors,
				animation: .default)
		 private var pets: FetchedResults<CoreDataPet>
		@State private var selectedSort = PetSort.default

		
		var body: some View {
				NavigationView {
						List(pets) { pet in
								PetListView(pet: pet)
								
						}
						.toolbar {
								ToolbarItemGroup(placement: .navigationBarTrailing) {
									SortSelectionView(
										selectedSortItem: $selectedSort,
										sorts: PetSort.sorts)
									.onChange(of: selectedSort) { _ in
										pets.sortDescriptors = selectedSort.descriptors
									}
								}
						}
						
						.navigationTitle("Pet List")
						.navigationViewStyle(.stack)
				}
		}
}

struct HomeView_Previews: PreviewProvider {
		static var previews: some View {
				HomeView()
						.environmentObject(PetModel(webservice: Webservice()))
				HomeView()
						.previewLayout(.fixed(width: 568, height: 320))
						.environmentObject(PetModel(webservice: Webservice()))
				HomeView()
						.preferredColorScheme(.dark)
						.environmentObject(PetModel(webservice: Webservice()))
				HomeView()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 568, height: 320))
						.environmentObject(PetModel(webservice: Webservice()))
				HomeView()
						.preferredColorScheme(.dark)
						.previewLayout(.fixed(width: 926, height: 428))
						.environmentObject(PetModel(webservice: Webservice()))
		}
}

