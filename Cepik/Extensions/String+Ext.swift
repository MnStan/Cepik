//
//  String+Ext.swift
//  Cepik
//
//  Created by Maksymilian Stan on 03/11/2022.
//

import Foundation

extension String {
    
    func convertStringToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "en_PL_POSIX")
        return formatter.date(from: self) ?? Date()
    }
    
    func convertStringToDatePickerDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_PL_POSIX")
        return formatter.date(from: self) ?? Date()
    }
    
    func removeDiacritics() -> String {
        self.folding(options: .diacriticInsensitive, locale: .autoupdatingCurrent)
    }
}
