//
//  DateFormatter.swift
//  YllowTest
//
//  Created by Admin on 07/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import Foundation


class FormatterDate {
    
    static func date(getDate: Double) -> String {
        
        
        let date = NSDate(timeIntervalSince1970: getDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formatterDate = dateFormatter.string(from: date as Date)
        return formatterDate
    }
}
