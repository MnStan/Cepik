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
    let networkAlert: ObservableObject<CError?> = ObservableObject(value: nil)

    let datesNetworkRequest: ObservableObject<Vehicles?> = ObservableObject(value: nil)
    
    
    /// Checking if textfield text property is not empty
    /// - Parameters:
    ///   - viewsArray: Array of views with textfields
    ///   - emptyHandler: A way to pass String for Alert
    ///   - completion: A way to pass if there is even one empty textField
    func checkTextFields(viewsArray: [CItemSettingsView], emptyHandler: (String?, CItemSettingsView?) -> (), completion: (Bool) -> ()) {
        var empty = false
        
        viewsArray.forEach {
            guard let input = $0.textField.text else { return }
            if input.isEmpty {
                empty = true
                emptyHandler(CError.emptyTextField.rawValue, $0)
            } else {
                emptyHandler(nil, nil)
            }
        }
        
        empty == true ? completion(true) : completion(false)
    }
    
    func getDates() {
        Task {
            do {
                datesNetworkRequest.value = try await NetworkManager.shared.getDatesForDatePicker()
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
        
        let info = VehicleSearchInfo(provinceNumber: CProvinces(rawValue: province)?.info.number, dateFrom: self.pickedDate.value, dateTo: self.pickedDateTo.value, dataType: dataType)

        let vehiclesVC = VehiclesVC()
        vehiclesVC.viewModel.vehicleInfo = info
        
        return vehiclesVC
    }
}
