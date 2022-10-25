//
//  CButton.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import UIKit

class CButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, color: UIColor) {
        self.init(frame: .zero)
        set(title: title, color: color)
    }
    
    private func set(title: String, color: UIColor) {
        configuration?.title = title
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
    }
    
    private func configureButton() {
        configuration = .tinted()
        configuration?.cornerStyle = .capsule
        translatesAutoresizingMaskIntoConstraints = false
    }
}
