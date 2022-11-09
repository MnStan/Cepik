//
//  CError.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import Foundation

enum CError: String, Error {
    case defaultError = "Something went wrong"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidDataFromServer = "Data received from the server was invalid. Pleas try again"
    case invalidVehicleInfo = "This vehicle informations created an invalid request. Please try again"
    case unableToComplete = "Unable to complete this network request. Please check your internet connection"
}
