//
//  Phone.swift
//  Contacts
//
//  Created by Eugis on 2/11/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

enum PhoneType: String {
    case home = "home"
    case work = "work"
    case mobile = "mobile"
    
    static func all() -> [PhoneType] {
        return [.home, .work, .mobile]
    }
}

struct Phone {
    
    let areaCode: String
    let number: String
    let type: PhoneType
    
    init?(with completeNumber: String, for type: PhoneType) {
        var numberComponents = completeNumber.split(separator: "-")
        
        if numberComponents.count == 0 { return nil }
        
        areaCode = String(numberComponents.remove(at: 0))
        number = String(numberComponents.joined(separator: "-"))
        self.type = type
    }
}
