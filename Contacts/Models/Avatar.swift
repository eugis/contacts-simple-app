//
//  Avatar.swift
//  Contacts
//
//  Created by Eugis on 2/12/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

struct Avatar {
    
    let smallImageURL: String
    let largeImageURL: String
}

extension Avatar: Argo.Decodable {
    
    static func decode(_ json: JSON) -> Decoded<Avatar> {
        return curry(Avatar.init)
            <^> json <| "smallImageURL"
            <*> json <| "largeImageURL"
    }
}

