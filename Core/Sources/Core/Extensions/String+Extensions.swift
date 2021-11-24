//
//  String+Extensions.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import Foundation

extension String {

    public func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
