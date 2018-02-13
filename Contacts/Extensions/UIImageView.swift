//
//  UIImageView.swift
//  Contacts
//
//  Created by Eugis on 2/12/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    
    func load(imageURLString: String, with placeholderName: String) {
        guard let url = URL(string: imageURLString) else { return }
        let placeholderImage = UIImage(named: placeholderName)
        self.af_setImage(withURL: url,
                         placeholderImage: placeholderImage,
                         filter: .none,
                         progress: .none, progressQueue: DispatchQueue.main,
                         imageTransition: .crossDissolve(2.0),
                         runImageTransitionIfCached: false,
                         completion: .none)
    }
}
