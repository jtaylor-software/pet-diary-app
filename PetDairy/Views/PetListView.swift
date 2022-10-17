//
//  PetListView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 9/17/22.
//

import SwiftUI
import CoreData

struct PetListView: View {
		@Environment(\.managedObjectContext) private var viewContext
		@FetchRequest(
				sortDescriptors: PetSort.default.descriptors,
				animation: .default)
		private var pets: FetchedResults<CoreDataPet>
		@State private var selectedSort = PetSort.default
		
		let pet: CoreDataPet
		
		var body: some View {
				NavigationLink {
						PetDetailView(pet: pet)
				} label: {
						HStack {
								AsyncImage(url: URL(string: pet.imageString ?? "")) { image in
										image.resizable()
								} placeholder: {
										Color.gray
								}
								.frame(width: 128, height: 128)
								.clipShape(RoundedRectangle(cornerRadius: 25))
								Text(pet.wrappedName)
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
				}
		}
}

//struct PetListView_Previews: PreviewProvider {
//    static var previews: some View {
//				PetListView(pet: PetModel.examplePet)
//    }
//}
