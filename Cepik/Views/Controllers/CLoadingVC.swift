//
//  CLoadingVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 24/11/2022.
//

import UIKit

class CLoadingVC: UIViewController {
    
    var containerView: UIView!
    var loadingIndicator: UIActivityIndicatorView!
    
    func showLoadingView(backgroundColor: Bool) {
        containerView = UIView()
        
        if backgroundColor {
            containerView.backgroundColor = .lightGray
        } else {
            containerView.backgroundColor = .systemBackground
        }
        
        self.containerView.alpha = 0
        
        UIView.animate(withDuration: 1.0, delay: 0.5) {
            self.containerView.alpha = 0.8
        }
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2.5),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
        
        addActivityIndicator()
        addLabel()
    }
    
    private func addLabel() {
        let label = CBodyLabel(text: "Ładowanie")
        label.textAlignment = .center
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 50),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
    
    private func addActivityIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(loadingIndicator)
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loadingIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyState(with message: String, in view: UIView) {
        let emptyStateView = CEmptyState(title: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}
