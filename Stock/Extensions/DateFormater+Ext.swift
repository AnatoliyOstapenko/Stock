//
//  DateFormater+Ext.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 25.11.2022.
//

import Foundation
// deprecated
extension DateFormatter {
    var newsFormated: DateFormatter {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        return formater
    }
}

// It's simpliest way to convert date to string as my opinion
extension Date {
    var dateToString: String {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        let string = formater.string(from: self)
        return string
    }
}

extension Double {
    var timeIntervalToString: String {
        let date = Date(timeIntervalSince1970: self)
        let formater = DateFormatter()
        formater.dateStyle = .long
        let string = formater.string(from: date)
        return string
    }
}
