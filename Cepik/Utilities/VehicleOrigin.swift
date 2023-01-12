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
            return ("Nowe", "&filter[pochodzenie-pojazdu]=NOWY ZAKUPIONY W KRAJU", "&filter[pochodzenie-pojazdu]=NOWY IMPORT INDYW")
        case .newFromCountry:
            return ("Nowe zakupione w kraju", "&filter[pochodzenie-pojazdu]=NOWY ZAKUPIONY W KRAJU", nil)
        case .newImported:
            return ("Nowe sprowadzone", "&filter[pochodzenie-pojazdu]=NOWY IMPORT INDYW", nil)
        case .used:
            return ("Używane", "&filter[pochodzenie-pojazdu]=UŻYW. IMPORT INDYW", "&filter[pochodzenie-pojazdu]=UŻYW. ZAKUPIONY W KRAJU")
        case .usedFromCountry:
            return ("Używane zakupione w kraju", "&filter[pochodzenie-pojazdu]=UŻYW. ZAKUPIONY W KRAJU", nil)
        case .usedImported:
            return ("Używane sprowadzone", "&filter[pochodzenie-pojazdu]=UŻYW. IMPORT INDYW", nil)
        case .all:
            return ("Wszystkie", "", nil)
        }
    }
}
