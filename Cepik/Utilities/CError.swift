//
//  CError.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import Foundation

enum CError: String, Error {
    case defaultError = "Coś poszło nie tak"
    case invalidResponse = "Nieprawidłowa odpowiedź serwera. Proszę spróbować ponownie"
    case invalidDataFromServer = "Dane odebrane z serwera są nieprawidłowe. Proszę spróbować ponownie"
    case invalidVehicleInfo = "Nieprawidłowe informacje na temat pojazdu. Proszę spróbować ponownie"
    case unableToComplete = "Nie można ukończyć żądania do serwera. Proszę sprawdzić połączenie z internetem i spróbować ponownie"
}
