//
//  ContactListViewModel.swift
//  Contacts
//
//  Created by Eugis on 1/27/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol ContactManager: class {
    func changeClass(of contact: ContactViewModel, from oldClass: ContactsClass)
}

class ContactListViewModel {
    
    let title = "Contacts"
    let contacts: MutableProperty<[ContactsClass: [ContactViewModel]]> = MutableProperty([:])
    private let contactRepository: ContactRepository
    
    init(contactRepository: ContactRepository = ContactRepositoryImplementation()) {
        self.contactRepository = contactRepository
        self.fetchContacts()
    }
    
    // TODO: Should be a better way to map result. NICER
    func fetchContacts() {
        contacts <~ contactRepository.fetchContacts()
                        .liftError()
                        .map { contacts in
                            let favoriteContacts = contacts.filter { $0.isFavorite }
                                .map { ContactViewModel(with: $0, contactManager: self) }
                                .sorted(by: { $0.name < $1.name })
                            let noFavoriteContacts = contacts.filter { !$0.isFavorite }
                                .map { ContactViewModel(with: $0, contactManager: self) }
                                .sorted(by: { $0.name < $1.name })
                            return  [ .favorite : favoriteContacts, .noFavorite : noFavoriteContacts]
        }
    }
    
    func contactViewModel(for row:Int, in contactClass: ContactsClass) -> ContactViewModel? {
        return contacts.value[contactClass]?[row]
    }
    
    func rows(in contactClass: ContactsClass) -> Int {
        return contacts.value[contactClass]?.count ?? 0
    }
    
    var sectionCounts: Int {
        return contacts.value.keys.count
    }
    
}

extension ContactListViewModel: ContactManager {
    
    //TODO: revise this to improve
    func changeClass(of contact: ContactViewModel, from oldClass: ContactsClass) {
        guard var oldList = contacts.value[oldClass] else { return }
        guard let oldIndex = (oldList.index { $0 === contact }) else { return }
        oldList.remove(at: oldIndex)
        var newList = contacts.value[contact.contactClass.value] ?? []
        
        let newIndex = newList.index(where: { contact.name < $0.name }) ?? newList.endIndex
        newList.insert(contact, at: newIndex)
        contacts.value = [oldClass:oldList, contact.contactClass.value:newList]
    }
}

extension SignalProducer {
    
    func liftError() -> SignalProducer<Value, NoError> {
        return self.flatMapError { _ in SignalProducer<Value, NoError>.empty }
    }
    
}
