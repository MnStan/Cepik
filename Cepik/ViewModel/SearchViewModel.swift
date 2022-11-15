//
//  SearchViewModel.swift
//  Cepik
//
//  Created by Maksymilian Stan on 20/10/2022.
//

import Foundation

class SearchViewModel {
    
    var vehicles: Vehicles!
    
    static let pickedDate: ObservableObject<Date?> = ObservableObject(value: nil)
    static let pickedDateTo: ObservableObject<Date?> = ObservableObject(value: nil)
    static let vehicleNetworkRequest: ObservableObject<Vehicles?> = ObservableObject(value: nil)
    let sortedVehicles: ObservableObject<Vehicles?> = ObservableObject(value: nil)
    
    private var page: Int = 1
    var areThereMoreVehicles: ObservableObject<Bool> = ObservableObject(value: true)
    
    func segmentedValueChanged(selectedIndex: Int) {
        print(selectedIndex)
    }
    
    func fetchData(vehicleInfo: VehicleSearchInfo) {
        if areThereMoreVehicles.value {
            guard let province = vehicleInfo.provinceNumber else { return }
            guard let dateFrom = vehicleInfo.dateFrom else { return }
            guard let dateTo = vehicleInfo.dateTo else { return }
            guard let dataType = vehicleInfo.dataType else { return }
            
            Task {
                do {
                    SearchViewModel.vehicleNetworkRequest.value = try await NetworkManager.shared.getVehiclesInfo(province: province, dateFrom: convertDateForNetworkCall(stringDate: dateFrom.convertToDayMonthYearFormat()), dateTo: convertDateForNetworkCall(stringDate: dateTo.convertToDayMonthYearFormat()), registered: dataType, page: page)
                    
                    if SearchViewModel.vehicleNetworkRequest.value?.data.count ?? 0 < 500 {
                        areThereMoreVehicles.value = false
                        print("Vehicles", SearchViewModel.vehicleNetworkRequest.value?.data.count ?? 0)
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
    
    func sortVehicles(vehicles: Vehicles) {
        var sorted = vehicles

        sorted.data.sort { first, second in
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
    
    private func convertDateForNetworkCall(stringDate: String) -> String {
        let convertedString = stringDate.components(separatedBy: "/")

        return convertedString.reversed().joined()
    }
    
    func formatStringToDate(stringDate: String) -> Date? {
        stringDate.convertStringToDate()
    }
    
    func checkDates(firstDate: String, secondDate: String, completion: @escaping ((_ validation: Bool) -> Void)) {
        
        let firstDateConverted = firstDate.convertStringToDate()
        let secondDateConverted = secondDate.convertStringToDate()
        
        if firstDateConverted > secondDateConverted {
            completion(false)
        } else {
            completion(true)
        }
    }
    
    private func countObjects(vehiclesData: Vehicles) {
        var vehiclesDictionary: [String: Int] = [:]
        
        vehiclesData.data.forEach {
            var valueToDictionary: Int!
            
            if let value = vehiclesDictionary[$0.attributes?.marka ?? "Unkowned"] {
                valueToDictionary = value + 1
            } else {
                valueToDictionary = 1
            }
            
            vehiclesDictionary.updateValue(valueToDictionary, forKey: $0.attributes?.marka ?? "Unknowned")
        }
        
//        vehiclesDictionary.sorted { $0.1 > $1.1 }.forEach {
//            print($0.key, $0.value)
//        }
        
//        print(vehiclesData)
    }
}
