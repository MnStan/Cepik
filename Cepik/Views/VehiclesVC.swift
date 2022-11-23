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
    private let viewModel = VehicleViewModel()
    var vehicles = Vehicles()
    private var page: Int = 1
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vehicles"
        view.backgroundColor = .systemBackground
        
        getVehicles(page: 1)
        configureTableView()
        showLoadingIndicator()
        setBindings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        vehicles.data.removeAll()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        vehicles.data.removeAll()
//        viewModel.notSearching()
//
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: Search Controller
    private func configureSearchController() {
        searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a Vehicle"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: Activity indicator when loading vehicles data
    
    private func showLoadingIndicator() {
        let barItem = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem = barItem
        activityIndicator.startAnimating()
    }
    
    // MARK: Sorting vehicles
    
    private func showSortingButton() {
        let sortingBarButton = UIBarButtonItem(image: UIImage(systemName: SFSymbols.sort), style: .done, target: self, action: #selector(sortVehicles))
        navigationItem.rightBarButtonItem = sortingBarButton
    }
    
    @objc private func sortVehicles() {
        viewModel.sortVehicles(vehicles: vehicles)
    }
    
    // MARK: Bindings
    
    private func setBindings() {
        viewModel.filteredVehicles.bind { [weak self] vehicles in
            guard let self else { return }
            guard let vehicles else { return }
            
            self.vehicles.data = vehicles.data
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
//            self.viewModel.saveVehicles(vehicles: self.vehicles)
        }
        
        viewModel.vehicleNetworkRequest.bind { [weak self] vehicles in
            guard let self else { return }
            guard let vehicles else { return }
            
            self.vehicles.data.append(contentsOf: vehicles.data)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            print("                 ",vehicles.meta?.datePublished, vehicles.meta?.dateModified)
        }
        
        viewModel.sortedVehicles.bind { [weak self] vehicles in
            guard let self else { return }
            self.vehicles.data = vehicles?.data ?? self.vehicles.data
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            self.viewModel.saveVehicles(vehicles: self.vehicles)
        }
        
        viewModel.areThereMoreVehicles.bind { [weak self] noMoreData in
            guard let self else { return }
            
            if !noMoreData {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.showSortingButton()
                    self.configureSearchController()
                }
                self.viewModel.saveVehicles(vehicles: self.vehicles)
            }
        }
    }
    
    // MARK: TableView configuration
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        
        tableView.register(CSearchResultCell.self, forCellReuseIdentifier: CSearchResultCell.reuseID)
    }
    
    private func getVehicles(page: Int) {
        viewModel.fetchData(vehicleInfo: vehiclesSearchInfo)
    }
}

// MARK: Table View delegate and data source extension

extension VehiclesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(vehicles.data.count)
        return vehicles.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CSearchResultCell.reuseID) as! CSearchResultCell
        let vehicle = vehicles.data[indexPath.row]
        
        cell.setTitle(title: viewModel.getNameToDisplay(vehicle: vehicle))
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(vehicles.data[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vehicleInfoVC = VehicleInfoVC()
        vehicleInfoVC.vehicleId = vehicles.data[indexPath.row].id
        navigationController?.pushViewController(vehicleInfoVC, animated: true)
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

// MARK: Search extension

extension VehiclesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            viewModel.notSearching()
            return
        }
        viewModel.searchVehicles(filter: filter)
    }
}
