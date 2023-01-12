//
//  SearchViewModel.swift
//  Cepik
//
//  Created by Maksymilian Stan on 20/10/2022.
//

import Foundation

class SearchViewModel {
    
    var vehicles: Vehicles!
    
    let pickedDate: ObservableObject<Date?> = ObservableObject(value: nil)
    let pickedDateTo: ObservableObject<Date?> = ObservableObject(value: nil)
    let networkError: ObservableObject<Bool> = ObservableObject(value: false)

    let datesNetworkRequest: ObservableObject<Vehicles?> = ObservableObject(value: nil)
    
    func getDates() {
        Task {
            do {
                datesNetworkRequest.value = try await NetworkManager.shared.getDatesForDatePicker()
            } catch {
                networkError.value = true
            }
        }
    }
    
    func segmentedValueChanged(selectedIndex: Int) {
    }
    
    func substractOneDay(date: Date) -> Date {
        Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
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
    
    func createVC(province: String, dataType: String) -> VehiclesVC {
        let province = province.removeDiacritics().replacingOccurrences(of: "-", with: "_")
        
        let info = VehicleSearchInfo(provinceNumber: Provinces(rawValue: province)?.info.number, dateFrom: self.pickedDate.value, dateTo: self.pickedDateTo.value, dataType: dataType)
        
        #warning("SEARCHVM PRINT")
        print(info)
        
        let vehiclesVC = VehiclesVC()
        vehiclesVC.viewModel.vehicleInfo = info
        
        return vehiclesVC
    }
    
    private func countObjects(vehiclesData: Vehicles) {
        var vehiclesDictionary: [String: Int] = [:]
        
        vehiclesData.data.forEach {
            var valueToDictionary: Int!
            
            if let value = vehiclesDictionary[$0.attributes?.marka ?? "Nieznany"] {
                valueToDictionary = value + 1
            } else {
                valueToDictionary = 1
            }
            
            vehiclesDictionary.updateValue(valueToDictionary, forKey: $0.attributes?.marka ?? "Nieznany")
        }
    }
}
