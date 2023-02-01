//
//  VehicleViewModel.swift
//  Cepik
//
//  Created by Maksymilian Stan on 16/11/2022.
//

import Foundation

class VehicleViewModel {
    
    var startVehicles = Vehicles()
    var vehicles = Vehicles()
    var vehiclesNetworkRequest = Vehicles()
    var vehicleInfo: VehicleSearchInfo!
    var dispatchGroup: DispatchGroup!

    var areThereMoreVehicles: ObservableObject<Bool> = ObservableObject(value: true)
    var networkAlert: ObservableObject<CError?> = ObservableObject(value: nil)
    
    func countVehicles() -> Int {
        return vehicles.data.count
    }
    
    func getVehicle(at: Int) -> String {
        getNameToDisplay(vehicle: vehicles.data[at])
    }
    
    func getVehicleId(at: Int) -> String {
        vehicles.data[at].id ?? ""
    }
    
    func getTitle(dataType: String) -> String {
        VehicleOrigin(rawValue: dataType)?.info.name ?? ""
    }
    
    func searchVehicles(filter: String) {
        var filteredVehicles = Vehicles()
        
        filteredVehicles.data = startVehicles.data.filter {
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
        
        self.vehicles = filteredVehicles
    }
    
    func saveVehicles() {
        startVehicles = vehicles
    }
    
    func notSearching() {
        vehicles = startVehicles
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
                    return "Nieznany"
                } else {
                    return vehicleCompany
                }
            }
            
            if let vehicleName = vehicle.attributes?.model {
                if vehicleName.contains("---") {
                    return "Nieznany"
                } else {
                    return vehicleName
                }
            }
        }
        
        return "Nieznany"
    }
    
    func sortVehicles() {
        self.vehicles.data.sort { first, second in
            
            let lhsCompany = first.attributes?.marka ?? "Nieznany"
            let lhsModel = first.attributes?.model ?? "Nieznany"
            let rhsCompany = second.attributes?.marka ?? "Nieznany"
            let rhsModel = second.attributes?.model ?? "Nieznany"
            
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
        
        saveVehicles()
    }
    
    private func convertDateForNetworkCall(stringDate: String) -> String {
        let convertedString = stringDate.components(separatedBy: "/")
        
        return convertedString.reversed().joined()
    }
    
    func fetchData() {
        vehicles = Vehicles()
        if areThereMoreVehicles.value {
            guard let province = vehicleInfo.provinceNumber else { return }
            guard let dateFrom = vehicleInfo.dateFrom else { return }
            guard let dateTo = vehicleInfo.dateTo else { return }
            guard let dataType = vehicleInfo.dataType else { return }

            if dataType == VehicleOrigin.all.rawValue {
                guard let origin = VehicleOrigin(rawValue: dataType)?.info.urlComponent else { return }
                taskFetchData(province: province, dateFrom: dateFrom, dateTo: dateTo, origin: origin, page: 1)
            } else {
                DispatchQueue.global().async {
                    self.dispatchGroup = DispatchGroup()
                    self.dispatchGroup.enter()
                    
                    
                    guard let origin = VehicleOrigin(rawValue: dataType)?.info.urlComponent else {
                        self.dispatchGroup.leave()
                        return
                    }
                    
                    self.taskFetchData(province: province, dateFrom: dateFrom, dateTo: dateTo, origin: origin, page: 1)
                    
                    self.dispatchGroup.wait()
                    self.dispatchGroup.enter()
                    
                    guard let secondOrigin = VehicleOrigin(rawValue: dataType)?.info.urlSecondComponent else {
                        self.dispatchGroup.leave()
                        self.areThereMoreVehicles.value = false
                        return
                    }
                    
                    self.taskFetchData(province: province, dateFrom: dateFrom, dateTo: dateTo, origin: secondOrigin, page: 1)
                    
                    self.dispatchGroup.wait()
                    self.areThereMoreVehicles.value = false
                }
            }
        }
    }
    
    func taskFetchData(province: String, dateFrom: Date, dateTo: Date, origin: String, page: Int) {
        Task {
            do {
                vehiclesNetworkRequest = try await NetworkManager.shared.getVehiclesInfo(province: province, dateFrom: convertDateForNetworkCall(stringDate: dateFrom.convertToDayMonthYearFormat()), dateTo: convertDateForNetworkCall(stringDate: dateTo.convertToDayMonthYearFormat()), origin: origin, page: page)
                
                if vehiclesNetworkRequest.data.count < 500 {
                    if dispatchGroup != nil {
                        vehicles.data.append(contentsOf: vehiclesNetworkRequest.data)
                        dispatchGroup.leave()
                    } else {
                        vehicles.data.append(contentsOf: vehiclesNetworkRequest.data)
                        areThereMoreVehicles.value = false
                    }
                    
                } else {
                    vehicles.data.append(contentsOf: vehiclesNetworkRequest.data)
                    guard let nextPage = vehiclesNetworkRequest.meta?.page else { return }
                    taskFetchData(province: province, dateFrom: dateFrom, dateTo: dateTo, origin: origin, page: nextPage + 1)
                }
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
