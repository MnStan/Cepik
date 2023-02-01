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
    
    func getInformation(vehicleInfo: VehiclesDetailDataAttributes) -> [Dictionary<String, String>.Element]{
        let mirror = Mirror(reflecting: vehicleInfo)
        var dictionary: [String: String] = [:]
        
        for child in mirror.children {
            if let key = child.label {
                if let value = child.value as? String {
                    if value != "---" && value != "-" {
                        if let keyToDisplay = VehicleInfoDescription(rawValue: key) {
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

