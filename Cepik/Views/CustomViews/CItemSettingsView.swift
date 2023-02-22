//
//  CItemSettingsView.swift
//  Cepik
//
//  Created by Maksymilian Stan on 20/10/2022.
//

import UIKit

class CItemSettingsView: UIView {

    var itemLabel = CTitleLabel()
    var textField = CTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, tag: Int) {
        self.init(frame: .zero)
        itemLabel.setTitle(title: title)
        textField.tag = tag
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: self.topAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            itemLabel.heightAnchor.constraint(equalToConstant: 45),
            itemLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            textField.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func addSubviews() {
        self.addSubview(itemLabel)
        self.addSubview(textField)
    }
}
