//
//  CTItleLabel.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import UIKit

class CTItleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTitleLabel() {
        textColor = .label
        
        font = UIFont.systemFont(ofSize: 18, weight: .bold)
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setTitle(title: String) {
        self.text = title
    }
}
