//
//  Pet.swift
//  PetDiary
//
//  Created by Jeremy Taylor on 8/25/22.
//
import UIKit

struct Pet: Identifiable, Hashable, Codable {
    
    var id: UUID?
    let name: String
    var favoriteToy: String?
    var age: Int
    let birthday: String
    var trait: String
}
