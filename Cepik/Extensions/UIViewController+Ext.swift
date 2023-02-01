//
//  UIViewController+Ext.swift
//  Cepik
//
//  Created by Maksymilian Stan on 12/01/2023.
//

import UIKit

extension UIViewController {
    
    func presentCAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = CAlertVC(title: title, message: message, button: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
