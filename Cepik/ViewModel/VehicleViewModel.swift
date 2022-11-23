//
//  VehicleViewModel.swift
//  Cepik
//
//  Created by Maksymilian Stan on 16/11/2022.
//

import Foundation

class VehicleViewModel {
    
    let vehicleNetworkRequest: ObservableObject<Vehicles?> = ObservableObject(value: nil)
    var startVehicles = Vehicles()
    let sortedVehicles: ObservableObject<Vehicles?> = ObservableObject(value: nil)
    let filteredVehicles: ObservableObject<Vehicles?> = ObservableObject(value: nil)
    
    private var page: Int = 1
    var areThereMoreVehicles: ObservableObject<Bool> = ObservableObject(value: true)
    
    func searchVehicles(filter: String) {
        let vehicles = startVehicles
        var filteredVehicles = vehicles
        
        filteredVehicles.data = vehicles.data.filter {
            switch ($0.attributes?.model, $0.attributes?.marka) {
            case (let model?, let marka?):
                return model.lowercased().contains(filter.lowercased()) || marka.lowercased().contains(filter.lowercased()) || (marka + " " + model).lowercased().contains(filter.lowercased())
            case (let model?, _):
                return model.lowercased().contains(filter.lowercased())
            case (_, let marka?):
                return marka.lowercased().contains(filter.lowercased())
            case (_, _):
                return false
            }
        }
        
        self.filteredVehicles.value = filteredVehicles
    }
    
    func saveVehicles(vehicles: Vehicles) {
        startVehicles = vehicles
    }
    
    func notSearching() {
        filteredVehicles.value = startVehicles
    }
    
    func getNameToDisplay(vehicle: VehiclesData) -> String{
        if let vehicleCompany = vehicle.attributes?.marka, let vehicleName = vehicle.attributes?.model {
            if vehicleName.contains("---") {
                return vehicleCompany
            } else {
                if vehicleName.contains(vehicleCompany) {
                    return vehicleName
                } else {
                    return vehicleCompany + " " + vehicleName
                }
            }
        } else {
            if let vehicleCompany = vehicle.attributes?.marka {
                if vehicleCompany.contains("---") {
                    return "Unknowned"
                } else {
                    return vehicleCompany
                }
            }
            
            if let vehicleName = vehicle.attributes?.model {
                if vehicleName.contains("---") {
                    return "Unknowned"
                } else {
                    return vehicleName
                }
            }
        }
        
        return "Unknowned"
    }
    
    func sortVehicles(vehicles: Vehicles) {
        var sorted = vehicles

        sorted.data.sort { first, second in
            #warning("Vehicles without company name at the end after sorting")
            
            let lhsCompany = first.attributes?.marka ?? "unknowned"
            let lhsModel = first.attributes?.model ?? "unknowned"
            let rhsCompany = second.attributes?.marka ?? "unknowned"
            let rhsModel = second.attributes?.model ?? "unknowned"
            
            let lhs = lhsCompany + " " + lhsModel
            let rhs = rhsCompany + " " + rhsModel
            
            if lhsModel.contains(lhsCompany) {
                return lhsModel < rhs
            }
            
            if rhsModel.contains(rhsCompany) {
                return lhs < rhsModel
            }
            
            if lhsModel.contains(lhsCompany) && rhsModel.contains(rhsCompany) {
                return lhsModel < rhsModel
            }
            
            return lhs < rhs
        }

        sortedVehicles.value = sorted
    }
    
    private func convertDateForNetworkCall(stringDate: String) -> String {
        let convertedString = stringDate.components(separatedBy: "/")

        return convertedString.reversed().joined()
    }
    
    func fetchData(vehicleInfo: VehicleSearchInfo) {
        if areThereMoreVehicles.value {
            guard let province = vehicleInfo.provinceNumber else { return }
            guard let dateFrom = vehicleInfo.dateFrom else { return }
            guard let dateTo = vehicleInfo.dateTo else { return }
            guard let dataType = vehicleInfo.dataType else { return }
            
            Task {
                do {
                    vehicleNetworkRequest.value = try await NetworkManager.shared.getVehiclesInfo(province: province, dateFrom: convertDateForNetworkCall(stringDate: dateFrom.convertToDayMonthYearFormat()), dateTo: convertDateForNetworkCall(stringDate: dateTo.convertToDayMonthYearFormat()), registered: dataType, page: page)
                    
                    if vehicleNetworkRequest.value?.data.count ?? 0 < 500 {
                        areThereMoreVehicles.value = false
                        print("Vehicles", vehicleNetworkRequest.value?.data.count ?? 0)
                    } else {
                        page += 1
                        fetchData(vehicleInfo: vehicleInfo)
                    }
                } catch {
                    print("Something went wrong")
                }
            }
        }
    }
}
