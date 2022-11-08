//
//  Date+Ext.swift
//  Cepik
//
//  Created by Maksymilian Stan on 29/10/2022.
//

import Foundation

extension Date {
    
    func convertToDayMonthYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_PL_POSIX")
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
}
