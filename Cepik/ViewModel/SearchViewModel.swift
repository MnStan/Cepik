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
    
    func segmentedValueChanged(selectedIndex: Int) {
        print(selectedIndex)
    }
    
    func fetchData(vehicleInfo: VehicleSearchInfo) {
        print(vehicleInfo)
        guard let province = vehicleInfo.provinceNumber else { return }
        guard let dateFrom = vehicleInfo.dateFrom else { return }
        guard let dateTo = vehicleInfo.DateTo else { return }
        guard let dataType = vehicleInfo.dataType else { return }
        
        print(dateFrom, dateTo)
        
        Task {
            do {
                vehicles = try await NetworkManager.shared.getVehiclesInfo(province: province, dateFrom: convertDateForNetworkCall(stringDate: dateFrom.convertToDayMonthYearFormat()), dateTo: convertDateForNetworkCall(stringDate: dateTo.convertToDayMonthYearFormat()), registered: dataType, page: 1)
                countObjects(vehiclesData: vehicles)
            } catch {
                print("Something went wrong")
            }
        }
    }
    
    private func convertDateForNetworkCall(stringDate: String) -> String {
        print("String date", stringDate)
        var convertedString = stringDate.components(separatedBy: ".")
        if convertedString.first?.count == 1 {
            convertedString[0] = "0" + convertedString[0]
        }
        print(convertedString)
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
        
        vehiclesData.data?.forEach {
            var valueToDictionary: Int!
            
            if let value = vehiclesDictionary[$0.attributes?.marka ?? "Unkowned"] {
                valueToDictionary = value + 1
            } else {
                valueToDictionary = 1
            }
            
            vehiclesDictionary.updateValue(valueToDictionary, forKey: $0.attributes?.marka ?? "Unknowned")
        }
        
        vehiclesDictionary.sorted { $0.1 > $1.1 }.forEach {
            print($0.key, $0.value)
        }
        
        print(vehiclesData)
    }
}
