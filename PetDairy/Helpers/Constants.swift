//
//  Constants.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 8/19/22.
//

import Foundation

enum Constants {
   enum API: String {
        static let baseUrl = "https://br-pet-api.herokuapp.com/"
        case baseUrlBad = "https://br-pet-api.herokuapp.com/petz"
       
       enum Endpoint {
           static let facts = "facts"
           static let pets = "pets"
       }
        
    }
}
