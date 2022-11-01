//
//  Fact.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 11/1/22.
//

import Foundation

class Fact: NSObject, Identifiable, Codable {
    var id: UUID?
    var fact: String
}
