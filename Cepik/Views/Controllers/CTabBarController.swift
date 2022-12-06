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
        searchVC.title = "Search"
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createCharVC() -> UINavigationController {
        let swiftUIChartVC = UIHostingController(rootView: CIDChartView())
        swiftUIChartVC.title = "Chart"
        
        return UINavigationController(rootViewController: swiftUIChartVC)
    }

}
