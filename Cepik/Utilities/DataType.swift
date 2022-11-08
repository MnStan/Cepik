//
//  DataType.swift
//  Cepik
//
//  Created by Maksymilian Stan on 03/11/2022.
//

import Foundation

enum DataType: String {
    case all
    case registered
    
    var info: (name: String, bool: String) {
        switch self {
        case .all:
            return ("All", "false")
        case .registered:
            return ("Registered", "true")
        }
    }
}
