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
    
    #warning("Change that")
    private let restURL = "pojazdy?wojewodztwo=30&data-od=20120102&data-do=20130505&typ-daty=1&tylko-zarejestrowane=true&pokaz-wszystkie-pola=false&fields=marka&limit=200&page=1"
    
    // https://api.cepik.gov.pl/pojazdy?wojewodztwo=30&data-od=20000401&data-do=20020401&typ-daty=1&tylko-zarejestrowane=true&pokaz-wszystkie-pola=false&limit=100&page=1
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func getVehiclesInfo() async throws -> Vehicles {
        guard let url = URL(string: baseURL + restURL) else {
            print("Url error")
            throw CError.defaultError
        }
        
        #warning("Change errors")
        
        let (data, response) = try await
        URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Response error")
            throw CError.defaultError
        }
        
        do {
            return try decoder.decode(Vehicles.self, from: data)
        } catch {
            print(error)
            throw CError.defaultError
        }
        
    }
}
