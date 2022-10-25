//
//  SearchVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import UIKit

class SearchVC: UIViewController {
    
    private let viewModel = SearchViewModel()
    
    let searchButton = CButton(title: "Search", color: .systemRed)
    let searchSegmentedControl = UISegmentedControl(items: ["Vehicles", "ID", "Statistics"])
    let stackView = UIStackView()
    var inputViewsArray: [CItemSettingsView]!
    
    lazy var datePickerController = CDatePickerVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        
        addSubViews()
        
        setupButtonConstraints()
        setupSegmentedControlConstraints()
        
        setupButton()
        setupSegmentedControl()
        
        setupTestStackView()
        setTextFieldsDeletages()
    }
    
    private func configureCustomSheetPresentationController() {
        if let presentationController = datePickerController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.custom(resolver: { [weak self] _ in
                return (self?.view.frame.height ?? 200) / 2.5
            })]
            presentationController.prefersGrabberVisible = true
        }
    }
    
    private func setupTestStackView() {
        let citem1 = CItemSettingsView(title: "Province", symbol: SFSymbols.province)
        let citem2 = CItemSettingsView(title: "Date from", symbol: SFSymbols.province)
        let citem3 = CItemSettingsView(title: "Date to", symbol: SFSymbols.province)
        let citem4 = CItemSettingsView(title: "Data type", symbol: SFSymbols.province)
        let citem5 = CItemSettingsView(title: "Fields", symbol: SFSymbols.province)
        
        inputViewsArray = [citem1, citem2, citem3, citem4, citem5]
        
        var tagCounter = 0
        
        inputViewsArray.forEach {
            stackView.addArrangedSubview($0)
            $0.textField.tag = tagCounter
            tagCounter = tagCounter + 1
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        view.addSubview(stackView)

        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchSegmentedControl.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -30)
        ])
    }
    
    private func setupSegmentedControlConstraints() {
        NSLayoutConstraint.activate([
            searchSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            searchSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            searchSegmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupSegmentedControl() {
        searchSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        searchSegmentedControl.selectedSegmentIndex = 0
        searchSegmentedControl.selectedSegmentTintColor = UIColor.systemGray4
        
        searchSegmentedControl.addTarget(self, action: #selector(searchSegmentedControlChanged), for: .valueChanged)
    }
    
    @objc func searchSegmentedControlChanged(_ sender: UISegmentedControl) {
        viewModel.segmentedValueChanged(selectedIndex: sender.selectedSegmentIndex)
        stackView.removeFromSuperview()
    }
    
    private func setupButton() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func searchButtonTapped() {
        viewModel.fetchData()
    }
    
    private func configureNavigationController() {
        view.backgroundColor = .systemBackground
        
        title = "CEPiK"

        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addSubViews() {
        view.addSubview(searchButton)
        view.addSubview(searchSegmentedControl)
    }
    
    private func setupButtonConstraints() {
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            searchButton.heightAnchor.constraint(equalTo: searchButton.widthAnchor, multiplier: 0.3),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: DatePicker functions
    
    private func showDatePicker(textField: UITextField) {
        textField.resignFirstResponder()
        
        switch textField.tag {
        case 0:
            let provinceAlertController = UIAlertController(title: "Choose province", message: nil, preferredStyle: .actionSheet)
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "1 - wojewodztwo", style: .default))
            provinceAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(provinceAlertController, animated: true)
        case 1:
            presentDatePicker(textField: textField)
        case 2:
            presentDatePicker(textField: textField)
        case 3:
            print("tag 3")
        case 4:
            print("tag 4")
        default:
            break
        }
    }
    
    private func presentDatePicker(textField: UITextField) {
        configureCustomSheetPresentationController()
        datePickerController.textField = textField
        datePickerController.delegate = textField
        present(datePickerController, animated: true)
    }
}

// MARK: UITextFieldDelegate

extension SearchVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showDatePicker(textField: textField)
    }
    
    private func setTextFieldsDeletages() {
        inputViewsArray.forEach {
            $0.textField.delegate = self
        }
    }
}

// MARK: Date Picker VC delegate

extension UITextField: DatePickerVCDelegate {
    func updateTextLabel(withText text: String) {
        self.text = text
    }
}
