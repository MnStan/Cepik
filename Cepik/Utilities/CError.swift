//
//  CError.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import Foundation

enum CError: String, Error {
    case emptyTextField = "Nie może być puste"
    case defaultCase = "Coś poszło nie tak"
    case defaultError = "Proszę spróbować ponownie"
    case invalidResponse = "Nieprawidłowa odpowiedź serwera. Proszę spróbować ponownie"
    case invalidDataFromServer = "Dane odebrane z serwera są nieprawidłowe. Proszę spróbować ponownie"
    case invalidVehicleInfo = "Nieprawidłowe informacje na temat pojazdu. Proszę spróbować ponownie"
    case invalidDates = "Nieprawidłowe informacje na temat daty. Proszę spróbować ponownie"
    case unableToComplete = "Nie można ukończyć żądania do serwera. Proszę sprawdzić połączenie z internetem i spróbować ponownie"
    case dates = "Złe daty!"
    case datesError = "Data od nie może być późniejsza niż data do"
    case empty = "Wszystkie pola muszą być uzupełnione"
    case emptyError = "Uzupełnij pola"
}
