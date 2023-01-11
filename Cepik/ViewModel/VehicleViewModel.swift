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
    var vehicleInfo: VehicleSearchInfo!
    var dispatchGroup: DispatchGroup!

    var areThereMoreVehicles: ObservableObject<Bool> = ObservableObject(value: true)
    
    func getTitle(dataType: String) -> String {
        return VehicleOrigin(rawValue: dataType)?.info.name ?? ""
    }
    
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
    
    func fetchData() {
        if areThereMoreVehicles.value {
            guard let province = vehicleInfo.provinceNumber else { return }
            guard let dateFrom = vehicleInfo.dateFrom else { return }
            guard let dateTo = vehicleInfo.dateTo else { return }
            guard let dataType = vehicleInfo.dataType else { return }
            print(dataType, VehicleOrigin(rawValue: dataType)?.info.urlComponent)
            print("tutaj")
            
            
            
            if dataType == VehicleOrigin.all.rawValue {
                guard let origin = VehicleOrigin(rawValue: dataType)?.info.urlComponent else { return }
                taskFetchData(province: province, dateFrom: dateFrom, dateTo: dateTo, origin: origin, page: 1)
            } else {
                DispatchQueue.global().async {
                    self.dispatchGroup = DispatchGroup()
                    self.dispatchGroup.enter()
                    
                    
                    guard let origin = VehicleOrigin(rawValue: dataType)?.info.urlComponent else {
                        self.dispatchGroup.leave()
//                        self.areThereMoreVehicles.value = false
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
        print("Origin    ", origin)
        Task {
            do {
                vehicleNetworkRequest.value = try await NetworkManager.shared.getVehiclesInfo(province: province, dateFrom: convertDateForNetworkCall(stringDate: dateFrom.convertToDayMonthYearFormat()), dateTo: convertDateForNetworkCall(stringDate: dateTo.convertToDayMonthYearFormat()), origin: origin, page: page)
                
                if vehicleNetworkRequest.value?.data.count ?? 0 < 500 {
                    if dispatchGroup != nil {
                        dispatchGroup.leave()
                    } else {
                        areThereMoreVehicles.value = false
                    }
                    
                } else {
                    guard let nextPage = vehicleNetworkRequest.value?.meta?.page else { return }
                    print("Next page", nextPage)
                    taskFetchData(province: province, dateFrom: dateFrom, dateTo: dateTo, origin: origin, page: nextPage + 1)
                }
            } catch {
                print("Something went wrong in taskFetchData", error, error.localizedDescription.debugDescription, error.localizedDescription.description)
            }
        }
    }
}
