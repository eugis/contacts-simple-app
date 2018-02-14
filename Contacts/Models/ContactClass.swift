//
//  ContactClass.swift
//  Contacts
//
//  Created by Eugis on 2/11/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation

enum ContactsClass: UInt {
    case favorite
    case noFavorite
    
    // TODO: should be localized 
    var title: String {
        switch self {
        case .favorite: return "Favorite Contacts"
        case .noFavorite: return "Others Contacts"
        }
    }
    
    var imageName: String {
        switch self {
        case .favorite: return "icon-favorite-true"
        case .noFavorite: return "icon-favorite-false"
        }
    }
}
