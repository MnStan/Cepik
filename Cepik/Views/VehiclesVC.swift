//
//  VehiclesVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 09/11/2022.
//

import UIKit

class VehiclesVC: UIViewController {

    private let tableView = UITableView()
    var vehiclesSearchInfo: VehicleSearchInfo!
    private let searchViewModel = SearchViewModel()
    var vehicles = Vehicles()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Vehicles"
        
        configureTableView()
        setBindings()
        getVehicles()
    }
    
    private func setBindings() {
        SearchViewModel.vehicleNetworkRequest.bind { [weak self] vehicles in
            guard let self else { return }
            guard let vehicles else { return }
            self.vehicles = vehicles
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: TableView configuration
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CSearchResultCell.self, forCellReuseIdentifier: CSearchResultCell.reuseID)
    }
    
    private func getVehicles() {
        searchViewModel.fetchData(vehicleInfo: vehiclesSearchInfo)
    }
}

extension VehiclesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(vehicles.data.count)
        return vehicles.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CSearchResultCell.reuseID) as! CSearchResultCell
        let vehicle = vehicles.data[indexPath.row]

        guard let vehicleCompany = vehicle.attributes?.marka else { return cell}
        guard let vehicleName = vehicle.attributes?.model else { return cell }
        cell.setTitle(title: vehicleCompany + " " + vehicleName)
        return cell
    }
    
    
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: VehiclesVC

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func toPreview() -> some View {
        // inject self (the current view controller) for the preview
        Preview(viewController: self as! VehiclesVC)
    }
}


@available(iOS 13, *)
struct InfoVCPreview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        VehiclesVC().toPreview().previewInterfaceOrientation(.portrait)
        VehiclesVC().toPreview().previewInterfaceOrientation(.landscapeLeft)
    }
}
#endif
