//
//  String.swift
//  Post
//
//  Created by isa nur fajar on 11/08/22.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
         dateFormatter.timeZone = TimeZone.current
         dateFormatter.locale = Locale.current
         return dateFormatter.date(from: "2015-04-01T11:42:00") 
    }
}
