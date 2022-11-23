//
//  DatePickerViewModel.swift
//  Cepik
//
//  Created by Maksymilian Stan on 23/11/2022.
//

import Foundation

class DatePickerViewModel {
    let datesNetworkRequest: ObservableObject<MetaInformations?> = ObservableObject(value: nil)
    
    func getDates() {
        Task {
            do {
//                datesNetworkRequest.value = try await NetworkManager.shared.getDatesForDatePicker()
            } catch {
                print("Something went wrong with dates network request")
            }
        }
    }
}
