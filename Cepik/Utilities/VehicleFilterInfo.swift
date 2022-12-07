//
//  VehicleFilterInfo.swift
//  Cepik
//
//  Created by Maksymilian Stan on 07/12/2022.
//

import Foundation

enum VehicleFilterInfo {
    case brand
    case diesel
    case gas
    case electric
    case hybrid
    
    var info: (field: String, name: String) {
        switch self {
        case .brand:
            return ("", "")
        case .diesel:
            return ("rodzaj-paliwa", "OLEJ NAPĘDOWY")
        case .gas:
            return ("rodzaj-paliwa", "BENZYNA")
        case .electric:
            return ("rodzaj-paliwa", "ENERGIA ELEKTRYCZNA")
        case .hybrid:
            return ("rodzaj-pierwszego-paliwa-alternatywnego", "ENERGIA ELEKTRYCZNA")
        }
    }
}
