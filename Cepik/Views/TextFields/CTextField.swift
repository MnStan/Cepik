//
//  CTextField.swift
//  Cepik
//
//  Created by Maksymilian Stan on 20/10/2022.
//

import UIKit

class CTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 0.1
        backgroundColor = .gray
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title3)
        maximumContentSizeCategory = .accessibilityLarge
        minimumFontSize = 8
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        isUserInteractionEnabled = true
    }
    
}
