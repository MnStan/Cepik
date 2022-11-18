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
    
    func getVehiclesInfo(province: String, dateFrom: String, dateTo: String, registered: String, page: Int = 1) async throws -> Vehicles {
        print(province, dateFrom, dateTo, registered)
        var endPoint = String()
        
        endPoint = baseURL + "pojazdy?wojewodztwo=\(province)&data-od=\(dateFrom)&data-do=\(dateTo)&typ-daty=1&tylko-zarejestrowane=\(registered)&pokaz-wszystkie-pola=false&limit=500&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            throw CError.invalidVehicleInfo
        }
        
#warning("Url print")
        print(url)
        
        let (data, response) = try await
        URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Response error")
            throw CError.invalidResponse
        }
        
        do {
            return try decoder.decode(Vehicles.self, from: data)
        } catch {
#warning("error alert!")
            throw CError.invalidDataFromServer
        }
    }
    
    func getVehiclesDetailInfo(id: String) async throws -> VehicleDetailInfo {
        let endPoint = baseURL + "pojazdy/\(id)"
        
        guard let url = URL(string: endPoint) else {
            throw CError.invalidVehicleInfo
        }
        
#warning("Url print")
        print(url)
        
        let (data, response) = try await
        URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Response error")
            throw CError.invalidResponse
        }
        
        do {
            return try decoder.decode(VehicleDetailInfo.self, from: data)
        } catch {
#warning("error alert!")
            throw CError.invalidDataFromServer
        }
    }
}
