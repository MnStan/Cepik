//
//  VehiclesVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 09/11/2022.
//

import UIKit

class VehiclesVC: CLoadingVC {

    private let tableView = UITableView()
    var viewModel = VehicleViewModel()
    var vehicles = Vehicles()
    private var page: Int = 1
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        title = "Vehicles"
        view.backgroundColor = .systemBackground
        
        getVehicles(page: 1)
        configureTableView()
        showLoadingIndicator()
        showLoadingView(backgroundColor: true)
        setBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
        tableView.reloadData()
    }
    
    // MARK: Bindings
    
    private func setBindings() {
        viewModel.areThereMoreVehicles.bind { [weak self] noMoreData in
            guard let self else { return }
            
            if !noMoreData {
                self.dismissLoadingView()
                DispatchQueue.main.async {
                    self.tableView.isUserInteractionEnabled = true
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
                self.viewModel.saveVehicles()
                
                self.checkIfThereAreVehicles()
            }
        }
    }
    
    private func checkIfThereAreVehicles() {
        if viewModel.countVehicles() == 0 {
            DispatchQueue.main.async {
                self.tableView.removeFromSuperview()
                self.showEmptyState(with: "No vehicles", in: self.view)
            }
        } else {
            DispatchQueue.main.async {
                self.showSortingButton()
                self.configureSearchController()
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
        
        tableView.isUserInteractionEnabled = false
    }
    
    private func getVehicles(page: Int) {
        viewModel.fetchData()
    }
}

// MARK: Table View delegate and data source extension

extension VehiclesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countVehicles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CSearchResultCell.reuseID) as! CSearchResultCell
        cell.setTitle(title: viewModel.getVehicle(at: indexPath.row))
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vehicleInfoVC = VehicleInfoVC()
        vehicleInfoVC.vehicleId = viewModel.getVehicleId(at: indexPath.row)
        
        navigationController?.pushViewController(vehicleInfoVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
        }
    }
}

// MARK: Search extension

extension VehiclesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            viewModel.notSearching()
            self.tableView.reloadData()
            return
        }
        
        viewModel.searchVehicles(filter: filter)
        self.tableView.reloadData()
    }
}
