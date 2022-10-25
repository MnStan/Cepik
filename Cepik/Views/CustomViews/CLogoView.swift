//
//  CLogoView.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import UIKit

class CLogoView: UIView {

    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLogoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: String) {
        self.init(frame: .zero)
        
        logoImageView.image = UIImage(systemName: image)
    }
    
    private func configureLogoView() {
        addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(systemName: SFSymbols.placeholder)
        configureLayout()
    }
    
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
//            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor)
        ])
    }
}
