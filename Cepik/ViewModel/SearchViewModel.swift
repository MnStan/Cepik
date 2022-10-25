//
//  SearchViewModel.swift
//  Cepik
//
//  Created by Maksymilian Stan on 20/10/2022.
//

import Foundation

class SearchViewModel {
    
    var vehicles: Vehicles!
    
    var formattedDate: ObservableObject<String?> = ObservableObject(value: nil)
    
    func segmentedValueChanged(selectedIndex: Int) {
        print(selectedIndex)
    }
    
    func fetchData() {
        Task {
            do {
                vehicles = try await NetworkManager.shared.getVehiclesInfo()
                countObjects(vehiclesData: vehicles)
            } catch {
                print("Something went wrong")
            }
        }
    }
    
    func formatDate(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        formattedDate.value = formatter.string(from: date)
    }
    
    private func countObjects(vehiclesData: Vehicles) {
        var vehiclesDictionary: [String: Int] = [:]
        
        vehiclesData.data.forEach {
            var valueToDictionary: Int!
            if let value = vehiclesDictionary[$0.attributes.marka] {
                valueToDictionary = value + 1
            } else {
                valueToDictionary = 1
            }
            vehiclesDictionary.updateValue(valueToDictionary, forKey: $0.attributes.marka)
        }
        
        vehiclesDictionary.sorted { $0.1 > $1.1 }.forEach {
            print($0.key, $0.value)
        }
    }
}
