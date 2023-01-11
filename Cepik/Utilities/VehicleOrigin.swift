//
//  VehicleOrigin.swift
//  Cepik
//
//  Created by Maksymilian Stan on 07/12/2022.
//

import Foundation

enum VehicleOrigin: String, CaseIterable {
    case new
    case newFromCountry
    case newImported
    case used
    case usedFromCountry
    case usedImported
    case all
    
    var info: (name: String, urlComponent: String, urlSecondComponent: String?) {
        switch self {
        case .new:
            return ("New", "&filter[pochodzenie-pojazdu]=NOWY ZAKUPIONY W KRAJU", "&filter[pochodzenie-pojazdu]=NOWY IMPORT INDYW")
        case .newFromCountry:
            return ("New from country", "&filter[pochodzenie-pojazdu]=NOWY ZAKUPIONY W KRAJU", nil)
        case .newImported:
            return ("New imported", "&filter[pochodzenie-pojazdu]=NOWY IMPORT INDYW", nil)
        case .used:
            return ("Used", "&filter[pochodzenie-pojazdu]=UŻYW. IMPORT INDYW", "&filter[pochodzenie-pojazdu]=UŻYW. ZAKUPIONY W KRAJU")
        case .usedFromCountry:
            return ("Used from country", "&filter[pochodzenie-pojazdu]=UŻYW. ZAKUPIONY W KRAJU", nil)
        case .usedImported:
            return ("Used imported", "&filter[pochodzenie-pojazdu]=UŻYW. IMPORT INDYW", nil)
        case .all:
            return ("All", "", nil)
        }
    }
}
