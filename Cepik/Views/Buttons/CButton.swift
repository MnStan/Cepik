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
    
    func set(title: String, color: UIColor) {
        configuration?.title = title
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configureTextSettings()
    }
    
    private func configureTextSettings() {
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        titleLabel?.maximumContentSizeCategory = .accessibilityExtraLarge
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.minimumScaleFactor = 0.7
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.numberOfLines = 0
        titleLabel?.sizeToFit()
    }
    
    private func configureButton() {
        configuration = .tinted()
        configuration?.cornerStyle = .capsule
        translatesAutoresizingMaskIntoConstraints = false
    }
}
