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

    
    func segmentedValueChanged(selectedIndex: Int) {
        print("Tag", selectedIndex)
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
