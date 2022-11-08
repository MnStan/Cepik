//
//  CItemsStackView.swift
//  Cepik
//
//  Created by Maksymilian Stan on 20/10/2022.
//

import UIKit

class CItemsStackView: UIStackView {
    
    var inputViewsArray: [CItemSettingsView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 10
        self.distribution = .fillEqually
    }
    
    convenience init(viewsArray: [CItemSettingsView]) {
        self.init(frame: .zero)
        
        
        
        viewsArray.forEach {
            self.addArrangedSubview($0)
        }
    }
}
