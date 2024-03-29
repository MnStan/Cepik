//
//  VehicleInfoVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 16/11/2022.
//

import UIKit

class VehicleInfoVC: LoadingVC {

    let scrollView = UIScrollView()
    let stackView = CItemsStackView()
    let contentView = UIView()
    
    let viewModel = VehicleInfoViewModel()
    var vehicleId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .systemBackground
        title = "Szczegóły"

        setBindings()
        showLoadingView(backgroundColor: true)
        viewModel.fetchData(vehicleId: vehicleId)
    }
    
    // MARK: Bindings
    
    private func setBindings() {
        viewModel.vehicleDetailNetworkRequest.bind { [weak self] vehicle in
            guard let self else { return }
            guard let vehicleInfo = vehicle?.data.attributes else { return }
            let info = self.viewModel.getInformation(vehicleInfo: vehicleInfo)
            
            self.dismissLoadingView()
            DispatchQueue.main.async {
                self.configureScrollView()
                self.configureContentView()
                self.configureStackView()
                info.forEach {
                    self.stackView.addArrangedSubview(VehicleDetailInfoItem(titleText: $0.key, bodyText: $0.value, logo: CSFSymbols.number))
                }
            }
        }
        
        viewModel.networkAlert.bind { [weak self] boolean in
            guard let self else { return }
            if (boolean != nil) {
                self.dismissLoadingView()
                self.presentCAlert(title: CError.defaultCase.rawValue, message: boolean?.rawValue ?? "", buttonTitle: "Ok")
            }
        }
    }
    
    // MARK: Content view configuration
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    // MARK: Stack view configuration
    
    private func configureStackView() {
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: Scroll view configuration
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.frame = view.bounds
    }

}
