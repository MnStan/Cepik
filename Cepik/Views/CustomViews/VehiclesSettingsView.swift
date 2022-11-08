//
//  VehiclesSettingsView.swift
//  Cepik
//
//  Created by Maksymilian Stan on 29/10/2022.
//

import UIKit

class VehiclesSettingsView: UIView {
    
    let item1 = CItemSettingsView(title: "Province", symbol: SFSymbols.province)
    let item2 = CItemSettingsView(title: "Date from", symbol: SFSymbols.province)
    let item3 = CItemSettingsView(title: "Date to", symbol: SFSymbols.province)
    let item4 = CItemSettingsView(title: "Data type", symbol: SFSymbols.province)
    let item5 = CItemSettingsView(title: "Fields", symbol: SFSymbols.province)
    
    var viewsArray: [CItemSettingsView]!

    override init(frame: CGRect) {
        super.init(frame: frame)
        itemsInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func itemsInit() {
        viewsArray = [item1, item2, item3, item4, item5]
        let ac = UIAlertAction(title: "test", style: .default)
    }
    
}

extension VehiclesSettingsView: UITextViewDelegate {
    
}
