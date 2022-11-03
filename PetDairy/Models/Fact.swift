//
//  Fact.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 11/1/22.
//

import Foundation

struct Fact: Identifiable, Codable {
    var id: UUID?
    var fact: String
    
    static let placeholder = Fact(fact: "Cats mark you as their territory when they rub their faces and bodies against you, as they have scent glands in those areas.")
}
