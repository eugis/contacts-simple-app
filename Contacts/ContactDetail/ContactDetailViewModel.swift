//
//  ContactDetailViewModel.swift
//  Contacts
//
//  Created by Eugis on 1/27/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class ContactViewModel {
    
    // This won´t be a let if the contact class where persist in the server
    private var contact: Contact
    private weak var contactManager: ContactManager?
    
    let contactClass: MutableProperty<ContactsClass> = MutableProperty(.noFavorite)
    
    lazy private var informationViewModel = self.generateInformationViewModels()
    
    lazy private(set) var favoriteAction = Action<Void, Void, NoError>(execute: { [weak self] _ in
        guard let strongSelf = self else { return SignalProducer.empty }
        switch strongSelf.contactClass.value {
        case .favorite:
            strongSelf.contactClass.value = .noFavorite
        case .noFavorite: strongSelf.contactClass.value = .favorite
        }
        strongSelf.contactManager?.changeClass(of: strongSelf, from: (strongSelf.contact.isFavorite ? .favorite : .noFavorite))
        strongSelf.contact = strongSelf.contact.switchFavorite()
        return SignalProducer.empty
    })
    
    init(with contact: Contact, contactManager: ContactManager) {
        self.contact = contact
        self.contactManager = contactManager
        contactClass.value = contact.isFavorite ? .favorite : .noFavorite
    }
 
}


extension ContactViewModel {
    
    var name: String {
        return contact.name
    }
    
    var profession: String? {
        return contact.companyName
    }
    
    var isFavorite: Bool {
        return contact.isFavorite
    }
    
    var largeAvatarURL: String {
        return contact.avatar.largeImageURL
    }
    
    var smallAvatarURL: String {
        return contact.avatar.smallImageURL
    }
}

// MARK: information section

extension ContactViewModel {
    
    func informationViewModel(for row:Int) -> BaseInformationViewModel? {
        return informationViewModel[row]
    }
    
    var informationRows: Int {
        return informationViewModel.count
    }
}

fileprivate extension ContactViewModel {
    
    fileprivate func generateInformationViewModels() -> [BaseInformationViewModel] {
        var information:[BaseInformationViewModel] = []

        information = information + (contact.phones ?? []).map(PhoneInformationViewModel.init)

        if let address = contact.address {
            information.append(AddressInformationViewModel(with: address))
        }
        
        if let email = contact.email {
            information.append(BaseInformationViewModel(title: "email", firstInformation: email))
        }
        
        if let birthday = contact.birthday {
            information.append(BaseInformationViewModel(title: "birthday", firstInformation: birthday.string))
        }
        
        return information
    }
}
