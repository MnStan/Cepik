//
//  CEmptyState.swift
//  Cepik
//
//  Created by Maksymilian Stan on 24/11/2022.
//

import UIKit

class CEmptyState: UIView {

    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        configureLabel(title: title)
    }
    
    private func layoutView() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        imageView.image = UIImage(named: "sadMiata")
        imageView.contentMode = .scaleAspectFit
    }
    
    private func configureLabel(title: String) {
        let label = CTItleLabel(title: title)
        label.textAlignment = .center
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 100),
            label.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
