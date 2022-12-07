//
//  CItemSettingsView.swift
//  Cepik
//
//  Created by Maksymilian Stan on 20/10/2022.
//

import UIKit

class CItemSettingsView: UIView {

    var itemLabel = CTItleLabel()
//    var symbol = CImageView(frame: .zero)
    var textField = CTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewStyle()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, symbol: String, tag: Int) {
        self.init(frame: .zero)
//        self.symbol.setImage(imageName: symbol)
        itemLabel.setTitle(title: title)
        textField.tag = tag
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
//            symbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            symbol.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
//            symbol.widthAnchor.constraint(equalToConstant: 20),
//            symbol.heightAnchor.constraint(equalTo: symbol.widthAnchor),
            
            itemLabel.topAnchor.constraint(equalTo: self.topAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            itemLabel.heightAnchor.constraint(equalToConstant: 30),
            itemLabel.widthAnchor.constraint(equalToConstant: 200),
            
            textField.topAnchor.constraint(equalTo: itemLabel.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }

    private func addSubviews() {
//        self.addSubview(symbol)
        self.addSubview(itemLabel)
        self.addSubview(textField)
    }

    private func setupViewStyle() {
//        self.layer.cornerRadius = 10
    }
}
