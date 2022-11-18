//
//  VehicleInfoVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 16/11/2022.
//

import UIKit

class VehicleInfoVC: UIViewController {

    let scrollView = UIScrollView()
    let stackView = CItemsStackView()
    let contentView = UIView()
    
    let viewModel = VehicleInfoViewModel()
    var vehicleId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
//        configureScrollView()
//        configureContentView()
//        configureStackView()
        title = "Details"
        addItems()
        setBindings()
        viewModel.fetchData(vehicleId: vehicleId)
    }
    
    private func setBindings() {
        viewModel.vehicleDetailNetworkRequest.bind { [weak self] vehicle in
            guard let self else { return }
            guard let vehicleInfo = vehicle?.data.attributes else { return }
            let info = self.viewModel.getInformation(vehicleInfo: vehicleInfo)
            
            DispatchQueue.main.async {
                self.configureScrollView()
                self.configureContentView()
                self.configureStackView()
                info.forEach {
                    self.stackView.addArrangedSubview(CVehicleDetailInfoItem(titleText: $0.key, bodyText: $0.value, logo: "number"))
                    print($0.key, $0.value)
                }
            }
        }
    }
    
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
    
    func addItems() {
        
    }
    
    private func configureStackView() {
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
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

#if DEBUG
import SwiftUI

@available(iOS 13, *)
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func toPreview() -> some View {
        // inject self (the current view controller) for the preview
        Preview(viewController: self)
    }
}
#endif

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct InfoVCPreview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        VehicleInfoVC().toPreview().previewInterfaceOrientation(.portrait)
    }
}
#endif
