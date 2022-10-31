//
//  AddUpdatePetView.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/30/22.
//

import SwiftUI
import UIKit

struct AddUpdatePetView: View {
    @EnvironmentObject var model: PetModel
    @Environment(\.dismiss) var dismiss
    
    @State private var nameText = ""
    @State private var favoriteToyText = ""
    @State private var ageText = ""
    @State private var birthdayText = ""
    @State private var traitText = ""
    @State private var image: Image?
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Name", text: $nameText)
                    TextField("Favorite Toy", text: $favoriteToyText)
                    TextField("Age ex: 4", text: $ageText)
                    TextField("Birthday ex: 7/4/2020", text: $birthdayText)
                    TextField("Trait ex: Cute and cuddly", text: $traitText)
                }
                
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                
                .onTapGesture {
                    showingImagePicker = true
                }
                
                
                .navigationBarTitle("Add Pet")
                
                .toolbar {
                    Button {
                        addPet()
                        
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $selectedImage)
                }
            }
            onChange(of: selectedImage) { _ in loadImage() }
            
        }
    }
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        
        
        image = Image(uiImage: selectedImage)
        
    }
    
    func addPet() {
       let pet = Pet(id: UUID(), name: nameText, favoriteToy: favoriteToyText, age: Int(ageText) ?? 1, birthday: birthdayText, trait: traitText)
        guard let selectedImage = selectedImage else { return }
        model.saveImageFor(pet, image: selectedImage)
        Task {
            do {
                try await model.addPet(pet)
            } catch {
                print(error)
            }
        }
    }
}

struct AddUpdatePetView_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdatePetView()
    }
}
