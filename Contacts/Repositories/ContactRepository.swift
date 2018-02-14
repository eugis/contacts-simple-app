//
//  ContactRepository.swift
//  Contacts
//
//  Created by Eugis on 2/6/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire
import Argo

protocol ContactRepository {
    
    func fetchContacts() -> SignalProducer<[Contact], NSError>
}

class ContactRepositoryImplementation: ContactRepository {

    // TODO: this would be nice to change if more paths are added
    let contactsURL = "https://s3.amazonaws.com/technical-challenge/v3/contacts.json".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
    
    func fetchContacts() -> SignalProducer<[Contact], NSError> {
        return SignalProducer { [weak self] observer, disposable in
            guard let strongSelf = self else { observer.sendInterrupted(); return}
            let request = Alamofire.request(strongSelf.contactsURL)
            disposable.observeEnded { request.progress.cancel() }
            request.responseData { [weak self] data in
                guard let strongSelf = self else { observer.sendInterrupted(); return}
                strongSelf.parse(requestData: data, observer: observer, disposable: disposable)
            }
        }
    }
}

fileprivate extension ContactRepositoryImplementation {
    
    fileprivate func parse(requestData: DataResponse<Data>, observer:Signal<[Contact], NSError>.Observer, disposable:Lifetime) {
        guard let data = requestData.data else { observer.send(error: requestData.error! as NSError); return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else  { observer.send(error: serializationError); return}
        let decodedUser: Decoded<[Contact]> = [Contact].decode(JSON(json))
        switch decodedUser {
        case .failure(let error): observer.send(error: error as NSError)
        case .success(let contacts):
            observer.send(value:contacts)
            observer.sendCompleted()
        }
    }
    
    private var serializationError: NSError {
        return NSError(domain: "contacts.error",
                       code: 100,
                       userInfo: ["error": "Serialization error"])
    }
}
