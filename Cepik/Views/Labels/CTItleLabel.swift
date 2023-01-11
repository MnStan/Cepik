//
//  CTItleLabel.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import UIKit

class CTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.text = title
    }
    
    private func configureTitleLabel() {
        textColor = .label
        
        font = UIFont.preferredFont(forTextStyle: .title3)
        adjustsFontForContentSizeCategory = true
        textAlignment = .left
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
        maximumContentSizeCategory = .extraExtraLarge
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setTitle(title: String) {
        self.text = title
    }
}
