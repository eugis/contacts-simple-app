//
//  ContactViewCell.swift
//  Contacts
//
//  Created by Eugis on 1/27/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import UIKit

internal class ContactViewCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 112.0
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buisnessLabel: UILabel!
    
    public func bind(_ cellViewModel: ContactViewModel) {
        nameLabel.text = cellViewModel.name
        buisnessLabel.text = cellViewModel.profession
        favoriteImageView.image = UIImage(named: cellViewModel.contactClass.value.imageName)
        imageView?.load(imageURLString: cellViewModel.smallAvatarURL,
                        with: "icon-avatar-small")
    }
}

