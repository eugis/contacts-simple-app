//
//  ContactHeaderView.swift
//  Contacts
//
//  Created by Eugis on 2/11/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class ContactHeaderViewCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 269.0
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buisnessLabel: UILabel!
    
    func bind(viewModel: ContactViewModel) {
        nameLabel.text = viewModel.name
        buisnessLabel.text = viewModel.profession
        avatarImageView.load(imageURLString: viewModel.largeAvatarURL,
                             with: "icon-avatar-large")
    }
}

