//
//  AddressInformationViewModel.swift
//  Contacts
//
//  Created by Eugis on 2/11/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation

class AddressInformationViewModel: BaseInformationViewModel {
    
    private let address: Address
    
    init(with address: Address) {
        self.address = address
        super.init(title: "address", firstInformation: address.street)
    }

    override var secondInformation: String? {
        return "\(address.city), \(address.state) \(address.zipCode), \(address.country)"
    }
    
}
