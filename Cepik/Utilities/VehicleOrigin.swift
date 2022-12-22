//
//  VehicleOrigin.swift
//  Cepik
//
//  Created by Maksymilian Stan on 07/12/2022.
//

import Foundation

enum VehicleOrigin: String {
    case new
    case used
    case all
    
    var info: (name: String, urlComponent: String, urlSecondComponent: String?) {
        switch self {
        case .new:
            return ("New", "&filter[pochodzenie-pojazdu]=NOWY%20ZAKUPIONY%20W%20KRAJU", nil)
        case .used:
            return ("Used", "&filter[pochodzenie-pojazdu]=UŻYW. IMPORT INDYW", "&filter[pochodzenie-pojazdu]=UŻYW. ZAKUPIONY W KRAJU")
        case .all:
            return ("All", "", nil)
        }
    }
}
