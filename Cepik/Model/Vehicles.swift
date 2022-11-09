//
//  Vehicles.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import Foundation

struct Vehicles: Codable {
    var data: [VehiclesData] = []
}

struct VehiclesData: Codable {
    var id: String?
    var type: String?
    var attributes: VehiclesDataAtributes?
}

struct VehiclesDataAtributes: Codable {
    var marka: String?
    let model: String?
    let wariant: String?
}
