//
//  SearchVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import UIKit
import SwiftUI

class SearchVC: UIViewController {
    
    private let viewModel = SearchViewModel()
    
    let searchButton = CButton(title: "Szukaj", color: UIColor(red: 0.698, green: 0.2314, blue: 0.1294, alpha: 1.0))
    var stackView: CItemsStackView!
    var inputViewsArray: [CItemSettingsView] = []
    
    lazy var datePickerController = CDatePickerVC()
    
    lazy var toolBar: UIToolbar = {
        let toolbarDone = UIToolbar.init(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 44)))
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked))
        toolbarDone.items = [doneButton]
        toolbarDone.sizeToFit()
        
        return toolbarDone
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        addSubViews()
        setupStackView()
        setupButtonConstraints()
        setupButton()
        setBinders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Bindings for network error
    
    private func setBinders() {
        viewModel.networkAlert.bind { [weak self] error in
            guard let self else { return }
            if error != nil {
                self.presentCAlert(title: CError.defaultCase.rawValue, message: error?.rawValue ?? "", buttonTitle: "Ok")
            }
        }
    }
    
    // MARK: Navigation Controller configuration
    
    private func configureNavigationController() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor(red: 0.7882, green: 0.7608, blue: 0.7412, alpha: 1.0).cgColor, UIColor(hue: 0.125, saturation: 0, brightness: 0.85, alpha: 1.0).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        navigationItem.title = "CEPiK"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: Sheet Presentation Controller configuration
    
    private func configureCustomSheetPresentationController() {
        if let presentationController = datePickerController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.custom(resolver: { [weak self] _ in
                return (self?.view.frame.height ?? 200) / 2.5
            })]
            presentationController.prefersGrabberVisible = true
        }
    }
    
    // MARK: TextFields check
    
    private func checkTextFields(checkCompletion: (Bool) -> ()) {
        viewModel.checkTextFields(viewsArray: inputViewsArray) { placeholder, settingViewItem in
            if placeholder != nil {
                settingViewItem?.textField.placeholder = placeholder
            }
        } completion: { empty in
            checkCompletion(empty)
        }
    }
    
    // MARK: Button configuration
    
    private func setupButton() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func searchButtonTapped() {
        checkTextFields { isEmpty in
            if !isEmpty {
                viewModel.checkDates(firstDate: inputViewsArray[1].textField.text!, secondDate: inputViewsArray[2].textField.text!) { [weak self] validation in
                    guard let self else { return }
                    
                    if validation {
                        guard let province = self.inputViewsArray[0].textField.text else { return }
                        guard let dataType = self.inputViewsArray[3].textField.text else { return }
                        
                        var dataTypeToPass: String!
                        CVehicleOrigin.allCases.forEach {
                            if $0.info.name == dataType {
                                dataTypeToPass = $0.rawValue
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(self.viewModel.createVC(province: province, dataType: dataTypeToPass), animated: true)
                        }
                        
                    } else {
                        self.presentCAlert(title: CError.dates.rawValue, message: CError.datesError.rawValue, buttonTitle: "Ok")
                    }
                }
            } else {
                self.presentCAlert(title: CError.empty.rawValue, message: CError.emptyError.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    @objc func doneButtonClicked() {
        view.endEditing(true)
    }
    
    // MARK: Constraints
    
    private func setupButtonConstraints() {
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            searchButton.heightAnchor.constraint(equalTo: searchButton.widthAnchor, multiplier: 0.3),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupStackViewConstraints() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -30)
        ])
    }
    

    
    // MARK: View showing functions
    
    private func addSubViews() {
        view.addSubview(searchButton)
    }
    
    private func setupStackView() {
        let citem1 = CItemSettingsView(title: "Województwo", tag: 0)
        let citem2 = CItemSettingsView(title: "Data od", tag: 1)
        let citem3 = CItemSettingsView(title: "Data do", tag: 2)
        let citem4 = CItemSettingsView(title: "Pochodzenie", tag: 3)
        
        inputViewsArray.removeAll()
        inputViewsArray = [citem1, citem2, citem3, citem4]

        stackView = CItemsStackView(viewsArray: inputViewsArray)
        stackView.alpha = 0.0
        
        self.setupStackViewConstraints()
        self.stackView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.stackView.alpha = 1.0
        }
        
        setTextFieldsDelegates(viewsArray: inputViewsArray)
    }
    
    // MARK: DatePicker functions
    
    private func textFieldEdit(textField: UITextField) {
        switch textField.tag {
        case 0:
            textField.resignFirstResponder()
            presentProvinceAlertController(textField: textField)
        case 1:
            textField.resignFirstResponder()
            presentDatePicker(textField: textField)
        case 2:
            textField.resignFirstResponder()
            presentDatePicker(textField: textField)
        case 3:
            textField.resignFirstResponder()
            presentDataTypeAlertController(textField: textField)
        default:
            break
        }
    }
    
    private func presentDatePicker(textField: UITextField) {
        configureCustomSheetPresentationController()
        datePickerController.textField = textField
        datePickerController.delegate = textField
        datePickerController.viewModel = viewModel
        DispatchQueue.main.async {
            self.present(self.datePickerController, animated: true)
        }
    }
    
    // MARK: Text Fields related functions
    
    @objc func textFieldDidEnd() {
        inputViewsArray.forEach {
            $0.textField.isUserInteractionEnabled = true
        }
    }
    
    private func presentDataTypeAlertController(textField: UITextField) {
        let dataTypeAlertController = UIAlertController(title: "Wybierz pochodzenie", message: nil, preferredStyle: .actionSheet)
        
        CVehicleOrigin.allCases.forEach {
            dataTypeAlertController.addAction(UIAlertAction(title: $0.info.name, style: .default, handler: { alert in
                textField.text = alert.title
            }))
        }
        
        dataTypeAlertController.addAction(UIAlertAction(title: "Anuluj", style: .cancel))
        
        DispatchQueue.main.async {
            self.present(dataTypeAlertController, animated: true)
        }
    }
    
    private func presentProvinceAlertController(textField: UITextField) {
        let provinceAlertController = UIAlertController(title: "Wybierz województwo", message: nil, preferredStyle: .actionSheet)

        CProvinces.allCases.forEach {
            provinceAlertController.addAction(UIAlertAction(title: $0.info.name, style: .default, handler: { alert in
                textField.text = alert.title
            }))
        }
        
        provinceAlertController.addAction(UIAlertAction(title: "Anuluj", style: .cancel))
        
        DispatchQueue.main.async {
            self.present(provinceAlertController, animated: true)
        }
    }
}

// MARK: UITextFieldDelegate

extension SearchVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldEdit(textField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setTextFieldsDelegates(viewsArray: [CItemSettingsView]) {
        viewsArray.forEach {
            $0.textField.delegate = self
        }
    }
}

// MARK: Date Picker VC delegate

extension UITextField: DatePickerVCDelegate {
    func updateTextLabel(withText text: String) {
        DispatchQueue.main.async {
            self.text = text
        }
    }
}
