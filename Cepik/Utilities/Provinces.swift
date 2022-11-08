//
//  Provinces.swift
//  Cepik
//
//  Created by Maksymilian Stan on 29/10/2022.
//

import Foundation
import UIKit

enum Provinces: String, CaseIterable {
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

#warning("Screen sizes czy potrzebne?")
enum ScreenSize {
    
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
