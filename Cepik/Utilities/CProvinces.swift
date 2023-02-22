//
//  Provinces.swift
//  Cepik
//
//  Created by Maksymilian Stan on 29/10/2022.
//

import Foundation
import UIKit

enum CProvinces: String, CaseIterable {
    case dolnoslaskie
    case kujawsko_pomorskie
    case lubelskie
    case lubuskie
    case łodzkie
    case małopolskie
    case mazowieckie
    case opolskie
    case podkarpackie
    case podlaskie
    case pomorskie
    case slaskie
    case swietokrzyskie
    case warminsko_mazurskie
    case wielkopolskie
    case zachodniopomorskie
    
    var info: (number: String, name: String) {
        switch self {
        case .dolnoslaskie:
            return ("02", "dolnośląskie")
        case .kujawsko_pomorskie:
            return ("04", "kujawsko-pomorskie")
        case .lubelskie:
            return ("06", "lubelskie")
        case .lubuskie:
            return ("08", "lubuskie")
        case .łodzkie:
            return ("10", "łódzkie")
        case .małopolskie:
            return ("12", "małopolskie")
        case .mazowieckie:
            return ("14", "mazowieckie")
        case .opolskie:
            return ("16", "opolskie")
        case .podkarpackie:
            return ("18", "podkarpackie")
        case .podlaskie:
            return ("20", "podlaskie")
        case .pomorskie:
            return ("22", "pomorskie")
        case .slaskie:
            return ("24", "śląskie")
        case .swietokrzyskie:
            return ("26", "świętokrzyskie")
        case .warminsko_mazurskie:
            return ("28", "warmińsko-mazurskie")
        case .wielkopolskie:
            return ("30", "wielkopolskie")
        case .zachodniopomorskie:
            return ("32", "zachodniopomorskie")
        }
    }
}
