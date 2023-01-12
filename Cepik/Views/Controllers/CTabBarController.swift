//
//  CTabBarController.swift
//  Cepik
//
//  Created by Maksymilian Stan on 06/12/2022.
//

import UIKit
import SwiftUI

class CTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewControllers = [createSearchVC(), createCharVC()]
    }
    
    private func createSearchVC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Szukaj"
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createCharVC() -> UINavigationController {
        let swiftUIChartVC = UIHostingController(rootView: CIDChartView())
        swiftUIChartVC.title = "Wykres"
        
        return UINavigationController(rootViewController: swiftUIChartVC)
    }

}
