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
        formatter.timeStyle = .none
        return formatter.date(from: self) ?? Date()
    }
    
    func removeDiacritics() -> String {
        self.folding(options: .diacriticInsensitive, locale: .autoupdatingCurrent)
    }
}
