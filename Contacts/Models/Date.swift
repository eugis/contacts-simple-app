//
//  Date.swift
//  Contacts
//
//  Created by Eugis on 2/12/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import Argo

extension Date: Argo.Decodable {
    
    private static let InputFormat = "yyyy-MM-dd"
    
    public static func decode(_ json: JSON) -> Decoded<Date> {
        switch json {
        case let .string(s):
            if let date = formatter(with: Date.InputFormat).date(from: s) {
                return pure(date)
            }
        default: break
        }
        return .failure(.custom("\(json) is not a date"))
    }

}

extension Date {
    
    private static let PrintFormat = "MMMM d, yyyy"
    
    var string: String {
        let dateFormatter = Date.formatter(with: Date.PrintFormat)
        return dateFormatter.string(from: self)
    }
    
    fileprivate static func formatter(with format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
