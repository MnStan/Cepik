//
//  VehicleInfoViewModel.swift
//  Cepik
//
//  Created by Maksymilian Stan on 16/11/2022.
//

import Foundation
import UIKit

class VehicleInfoViewModel {
    
    let vehicleDetailNetworkRequest: ObservableObject<VehicleDetailInfo?> = ObservableObject(value: nil)
    let networkAlert: ObservableObject<CError?> = ObservableObject(value: nil)
    
    
    /// This function takes each Vehicle Detail Data Attribute thanks to reflection which describes parts that make up this struct and check if they contain useful information for user and put it in dictionary
    /// - Parameter vehicleInfo: Vehicle info fetched from server
    /// - Returns: Dictionary that contain detail element name and associated value
    func getInformation(vehicleInfo: VehiclesDetailDataAttributes) -> [Dictionary<String, String>.Element]{
        print(vehicleInfo)
        
        let mirror = Mirror(reflecting: vehicleInfo)
        var dictionary: [String: String] = [:]
        
        for child in mirror.children {
            if let key = child.label {
                if let value = child.value as? String {
                    if value != "---" && value != "-" {
                        if let keyToDisplay = CVehicleInfoDescription(rawValue: key) {
                            dictionary.updateValue(value, forKey: keyToDisplay.info)
                        } else {
                            dictionary.updateValue(value, forKey: key)
                        }
                    }
                }
            }
        }

        return dictionary.sorted { $0.0 < $1.0 }
    }
    
    func fetchData(vehicleId: String) {
        Task {
            do {
                vehicleDetailNetworkRequest.value = try await NetworkManager.shared.getVehiclesDetailInfo(id: vehicleId)
            } catch CError.invalidVehicleInfo {
                networkAlert.value = CError.invalidVehicleInfo
            } catch CError.invalidResponse {
                networkAlert.value = CError.invalidResponse
            } catch CError.invalidDataFromServer {
                networkAlert.value = CError.invalidDataFromServer
            } catch {
                networkAlert.value = CError.defaultError
            }
        }
    }
}

