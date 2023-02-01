//
//  NetworkManager.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.cepik.gov.pl/"
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func getVehiclesInfo(province: String, dateFrom: String, dateTo: String, origin: String, page: Int = 1) async throws -> Vehicles {
        var endPoint = String()
        
        endPoint = baseURL + "pojazdy?wojewodztwo=\(province)&data-od=\(dateFrom)&data-do=\(dateTo)&typ-daty=1&pokaz-wszystkie-pola=false&limit=500&page=\(page)\(origin)"
        
        guard let encodedURL = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { throw CError.invalidVehicleInfo }
        
            guard let url = URL(string: encodedURL) else {
                throw CError.invalidVehicleInfo
            }
        
        let (data, response) = try await
        URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CError.invalidResponse
        }
        
        do {
            return try decoder.decode(Vehicles.self, from: data)
        } catch {
            throw CError.invalidDataFromServer
        }
    }
    
    func getVehiclesDetailInfo(id: String) async throws -> VehicleDetailInfo {
        let endPoint = baseURL + "pojazdy/\(id)"
        
        guard let url = URL(string: endPoint) else {
            throw CError.invalidVehicleInfo
        }

        let (data, response) = try await
        URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CError.invalidResponse
        }
        
        do {
            return try decoder.decode(VehicleDetailInfo.self, from: data)
        } catch {
            throw CError.invalidDataFromServer
        }
    }
    
    func getDatesForDatePicker() async throws -> Vehicles {
        let todayDate = Date().convertToDayMonthYearFormat().components(separatedBy: "/").reversed().joined()
        let endPoint = baseURL + "pojazdy?wojewodztwo=12&data-od=\(todayDate)&data-do=\(todayDate)&typ-daty=1&tylko-zarejestrowane=true&pokaz-wszystkie-pola=false&limit=1&page=1"
        
        guard let url = URL(string: endPoint) else {
            throw CError.invalidDates
        }
        
        let (data, response) = try await
        URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CError.invalidResponse
        }
        
        do {
            return try decoder.decode(Vehicles.self, from: data)
        } catch {
            throw CError.invalidDataFromServer
        }
    }
}
