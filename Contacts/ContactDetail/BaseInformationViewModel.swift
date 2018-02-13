//
//  BaseInformationViewModel.swift
//  Contacts
//
//  Created by Eugis on 2/12/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation

class BaseInformationViewModel {
    
    private let _title: String
    
    let firstInformation: String
    private(set) var secondInformation: String? = .none
    private(set) var informationType: String? = .none
    
    init(title: String, firstInformation: String) {
        self._title = title
        self.firstInformation = firstInformation
    }
    
    var title: String {
        return _title.uppercased()
    }
}
