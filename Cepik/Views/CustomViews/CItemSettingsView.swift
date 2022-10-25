//
//  CItemSettingsView.swift
//  Cepik
//
//  Created by Maksymilian Stan on 20/10/2022.
//

import UIKit

class CItemSettingsView: UIView {

    var itemLabel = CTItleLabel()
    var symbol = CImageView(frame: .zero)
    var textField = CTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewStyle()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, symbol: String) {
        self.init(frame: .zero)
        self.symbol.setImage(imageName: symbol)
        itemLabel.setTitle(title: title)
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            symbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            symbol.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            symbol.widthAnchor.constraint(equalToConstant: 20),
            symbol.heightAnchor.constraint(equalTo: symbol.widthAnchor),
            
            itemLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            itemLabel.leadingAnchor.constraint(equalTo: symbol.trailingAnchor, constant: 10),
            itemLabel.widthAnchor.constraint(equalToConstant: itemLabel.intrinsicContentSize.width),
            itemLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            textField.topAnchor.constraint(equalTo: itemLabel.topAnchor),
            textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }

    private func addSubviews() {
        self.addSubview(symbol)
        self.addSubview(itemLabel)
        self.addSubview(textField)
    }

    private func setupViewStyle() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGray3.cgColor
    }
}