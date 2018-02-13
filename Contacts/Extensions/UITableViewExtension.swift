//
//  UITableViewExtension.swift
//  Contacts
//
//  Created by Eugis on 2/11/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    public func dequeue<T: UITableViewCell>(cell cellType: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T
    }
    
    public func register<T: UITableViewCell>(cell cellType: T.Type) {
        let nib = UINib(nibName: cellType.nibName, bundle: .none)
        self.register(nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
}
