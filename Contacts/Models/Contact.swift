//
//  Contact.swift
//  Contacts
//
//  Created by Eugis on 1/27/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

struct Contact {
    
    let id: String
    let name: String
    let avatar: Avatar
    let isFavorite: Bool
    let companyName: String? 
    let address: Address?
    let birthdate: Date?
    let phones: [Phone]?
    let email: String?
    
    func switchFavorite() -> Contact {
        let favorite = !self.isFavorite
        return Contact(id: id,
                       name: name,
                       avatar: avatar,
                       isFavorite:favorite,
                       companyName:companyName,
                       address: address,
                       birthdate: birthdate,
                       phones:phones,
                       email:email)
    }

}

extension Contact: Argo.Decodable {

    static func decode(_ json: JSON) -> Decoded<Contact> {
        let contact = curry(Contact.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> Avatar.decode(json)
        return contact
            <*> json <| "isFavorite"
            <*> json <|? "companyName"
            <*> json <|? "address"
            <*> json <|? "birthdate"
            <*> phones(from: json)
            <*> json <|? "emailAddress"
    }
    
    static private func phones(from json: JSON) -> Decoded<[Phone]?> {
        var decoded: Decoded<[Phone]?>? = .none
        var phones: [Phone] = []
        PhoneType.all().forEach() { phoneType in
            let numberDecodable:Decoded<String?> = json <|? ["phone", phoneType.rawValue]
            switch numberDecodable {
            case .success(let number):
                if let number = number, let phone = Phone(with: number, for: phoneType) {
                    phones.append(phone)
                }
            case .failure(let error):
                decoded = .failure(error)
            }
        }
        
        if let decode = decoded {
            return decode
        }
        return .success(phones.count == 0 ? .none : phones)
    }

}

