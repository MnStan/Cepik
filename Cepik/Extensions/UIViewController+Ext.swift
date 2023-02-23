//
//  UIViewController+Ext.swift
//  Cepik
//
//  Created by Maksymilian Stan on 12/01/2023.
//

import UIKit

extension UIViewController: CAlertDelegate {
    func okButtonPressed() {
        dismiss(animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    func presentCAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = AlertVC(title: title, message: message, button: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.delegate = self
            self.present(alertVC, animated: true)
        }
    }
    
    
}
