//
//  CVehicleDetailInfoItem.swift
//  Cepik
//
//  Created by Maksymilian Stan on 16/11/2022.
//

import UIKit

class VehicleDetailInfoItem: UIView {

    var logo: CLogoView!
    var title: CTitleLabel!
    var body: CBodyLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(titleText: String, bodyText: String, logo: String) {
        self.init(frame: .zero)
        self.title = CTitleLabel(title: titleText)
        self.title.numberOfLines = 0
        self.body = CBodyLabel(text: bodyText)
        self.logo = CLogoView(image: logo)
        configureLayout()
    }
    
    private func configureLayout() {
        self.addSubview(logo)
        self.addSubview(title)
        self.addSubview(body)
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: padding),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            title.heightAnchor.constraint(equalToConstant: title.font.lineHeight + 20),
            
            logo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            logo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logo.topAnchor.constraint(equalTo: logo.topAnchor),
            logo.widthAnchor.constraint(equalToConstant: 40),
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor),
            
            body.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: padding),
            body.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            body.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
    }
}
