//
//  Vehicles.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import Foundation

struct Vehicles: Codable {
    
    var data: [VehiclesData] = []
    var meta: MetaInformations?
}

struct VehiclesData: Codable {
    
    var id: String?
    var type: String?
    var attributes: VehiclesDataAttributes?
}

struct VehiclesDataAttributes: Codable {
    
    var marka: String?
    var model: String?
}

struct MetaInformations: Codable {
    var datePublished: String
    var dateModified: String
    var page: Int
    var count: Int
    
    private enum CodingKeys: String, CodingKey {
        case datePublished = "schema:datePublished"
        case dateModified = "schema:dateModified"
        case page = "page"
        case count = "count"
    }
}
