//
//  Adress.swift
//  Contacts
//
//  Created by Eugis on 2/11/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

struct Address {
    
    let street: String
    let city: String
    let state: String
    let country: String
    let zipCode: String
    
}

extension Address: Argo.Decodable {
    
    static func decode(_ json: JSON) -> Decoded<Address> {
        return curry(Address.init)
            <^> json <| "street"
            <*> json <| "city"
            <*> json <| "state"
            <*> json <| "country"
            <*> json <| "zipCode"
    }
}
