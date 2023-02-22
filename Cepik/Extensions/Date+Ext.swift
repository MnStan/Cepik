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
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "en_PL_POSIX")
        return formatter.string(from: self)
    }
}
