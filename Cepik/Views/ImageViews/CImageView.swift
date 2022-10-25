//
//  CImageView.swift
//  Cepik
//
//  Created by Maksymilian Stan on 21/10/2022.
//

import UIKit

class CImageView: UIImageView {

    let placeholderImage = UIImage(systemName: SFSymbols.placeholder)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setImage(imageName: String) {
        image = UIImage(systemName: imageName)
    }
}
