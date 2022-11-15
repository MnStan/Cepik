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
    private var page: Int = 1
    private var areThereMoreVehicles: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Vehicles"
        
        configureTableView()
        setBindings()
        getVehicles(page: 1)
    }
    
    private func setBindings() {
        SearchViewModel.vehicleNetworkRequest.bind { [weak self] vehicles in
            guard let self else { return }
            guard let vehicles else { return }
            
            self.vehicles.data.append(contentsOf: vehicles.data)
            
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
    
    private func getVehicles(page: Int) {
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
        
        if vehicleName.contains("---") {
            cell.setTitle(title: vehicleCompany)
        } else {
            if vehicleName.contains(vehicleCompany) {
                cell.setTitle(title: vehicleName)
            } else {
                cell.setTitle(title: vehicleCompany + " " + vehicleName)
            }
        }
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            print("end")
        }
    }
}
