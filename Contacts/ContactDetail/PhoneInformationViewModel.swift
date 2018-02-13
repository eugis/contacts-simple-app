//
//  PhoneInformationViewModel.swift
//  Contacts
//
//  Created by Eugis on 2/12/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation

class PhoneInformationViewModel: BaseInformationViewModel {
    
    private let phone: Phone
    
    init(phone: Phone) {
        self.phone = phone
        let firstInformation = "(\(phone.areaCode)) \(phone.number)"
        super.init(title: "phone", firstInformation: firstInformation)
    }
    
    override var informationType: String? {
        return phone.type.rawValue.capitalized
    }

}
