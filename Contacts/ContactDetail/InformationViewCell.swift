//
//  InformationCellView.swift
//  Contacts
//
//  Created by Eugis on 2/11/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import UIKit

class InformationViewCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 100.0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstInformationLabel: UILabel!
    @IBOutlet weak var secondInformationLabel: UILabel!
    
    @IBOutlet weak var classLabel: UILabel!
    
    func bind(information: BaseInformationViewModel) {
        titleLabel.text = information.title
        firstInformationLabel.text = information.firstInformation
        secondInformationLabel.text = information.secondInformation
        classLabel.text = information.informationType
    }
}
