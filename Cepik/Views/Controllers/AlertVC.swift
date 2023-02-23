//
//  CAlertVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 12/01/2023.
//

import UIKit

protocol CAlertDelegate {
    func okButtonPressed()
}

class AlertVC: UIViewController {
    
    var delegate: CAlertDelegate?
    let containerView = CAlertContainer()
    let titleLabel = CTitleLabel()
    let messageLabel = CBodyLabel()
    let button = CButton()
    
    let padding: CGFloat = 20

    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        addSubviews()
        
        configureContainerView()
        configureTitleLabel()
        configureButton()
        configureMessageLabel()
        configurePresentationStyle()
    }
    
    init(title: String, message: String, button: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePresentationStyle() {
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    private func addSubviews() {
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(button)
    }
    
    // MARK: Elements of Alert configurationa
    
    private func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.text = alertTitle ?? CError.defaultCase.rawValue
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        ])
    }
    
    private func configureButton() {
        button.set(title: title ?? "Ok", color: .red)
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureMessageLabel() {
        messageLabel.text = message ?? ""
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -12)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
        delegate?.okButtonPressed()
    }
    
}
