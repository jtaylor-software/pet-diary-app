//
//  AddUpdatePetView.swift
//  PetDiary
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
    @State private var showingAlert = false
    
    var pet: Pet?
    
    var disableForm: Bool {
        nameText.isEmpty || favoriteToyText.isEmpty || ageText.isEmpty || birthdayText.isEmpty || traitText.isEmpty
    }
    
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
                
                
                .navigationBarTitle(pet == nil ? "Add Pet" : "Update Pet")
                .onAppear {
                    updatePet()
                }
                
                .toolbar {
                    Button {
                        if let pet = pet {
                            addUpdatePet(pet: pet)
                        } else {
                            addUpdatePet(pet: nil)
                        }
                        
                        dismiss()
                    }
                label: {
                    Text(pet == nil ? "Save" : "Update")
                }
                .disabled(disableForm)
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $selectedImage)
                }
            }
            onChange(of: selectedImage) { _ in loadImage() }
            
        }
        .alert("Network Problem!", isPresented: $showingAlert) {
            
        } message: {
            Text("Could not connect to server to add pet.\nPlease check your network connection")
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        
        
        image = Image(uiImage: selectedImage)
        
    }
    func updatePet() {
        guard let pet = pet else { return }
        nameText = pet.name
        favoriteToyText = pet.favoriteToy ?? "Everything!"
        ageText = String(pet.age)
        birthdayText = pet.birthday
        traitText = pet.trait
        
        selectedImage = UIImage(data: model.loadImageFor(pet) )
        
        
        addUpdatePet(pet: pet)
    }
    
    func addUpdatePet(pet: Pet?) {
        if var pet = pet {
            // Update Pet
            guard let selectedImage = selectedImage else { return }
            model.saveImageFor(pet, image: selectedImage)
            
            pet.age = Int(ageText) ?? 1
            pet.favoriteToy = favoriteToyText
            pet.trait = traitText
            
            Task {
                do {
                    try await model.updatePet(pet)
                } catch {
                    print(error)
                    showingAlert = true
                }
            }
        } else {
            // Adding Pet
            let pet = Pet(id: UUID(), name: nameText, favoriteToy: favoriteToyText, age: Int(ageText) ?? 1, birthday: birthdayText, trait: traitText)
            guard let selectedImage = selectedImage else { return }
            model.saveImageFor(pet, image: selectedImage)
            Task {
                do {
                    try await model.addPet(pet)
                    try await model.fetchPets()
                } catch {
                    print(error)
                    showingAlert = true
                }
            }
        }
    }
}

struct AddUpdatePetView_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdatePetView(pet: PetModel.examplePet)
    }
}
