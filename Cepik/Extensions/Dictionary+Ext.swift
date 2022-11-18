//
//  Dictionary+Ext.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/11/2022.
//

import Foundation

extension Dictionary {
    mutating func switchKey(fromKey: Key, toKey: Key) {
        if let value = removeValue(forKey: fromKey) {
            self[toKey] = value
        }
    }
}
