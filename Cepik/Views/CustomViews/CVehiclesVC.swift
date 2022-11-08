//
//  CVehiclesVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 29/10/2022.
//

import UIKit

class CVehiclesVC: UIViewController {

    let citem1 = CItemSettingsView(title: "Province", symbol: SFSymbols.province)
    let citem2 = CItemSettingsView(title: "Date from", symbol: SFSymbols.province)
    let citem3 = CItemSettingsView(title: "Date to", symbol: SFSymbols.province)
    let citem4 = CItemSettingsView(title: "Data type", symbol: SFSymbols.province)
    let citem5 = CItemSettingsView(title: "Fields", symbol: SFSymbols.province)
    
    var inputViewsArray: [CItemSettingsView]!
    var stackView: CItemsStackView!
    
    var datePickerController: CDatePickerVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputViewsArray = [citem1, citem2, citem3, citem4, citem5]
        stackView = CItemsStackView(viewsArray: inputViewsArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupStackViewConstraits()
        setTextFieldDelegates(viewsArray: inputViewsArray)
    }
    
    private func setupStackViewConstraits() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: CGFloat(inputViewsArray.count * 75))
        ])
    }
    
    private func showDatePicker(textField: UITextField) {
        textField.resignFirstResponder()
        
        switch textField.tag {
        case 0:
            presentProvinceAlertController(textField: textField)
        case 1:
            presentDatePicker(textField: textField)
        case 2:
            presentDatePicker(textField: textField)
        case 3:
            textField.text = "s"
            print("tag 3")
        case 4:
            textField.text = "s"
            print("tag 4")
        default:
            print("Default")
            break
        }
    }
    
    private func presentProvinceAlertController(textField: UITextField) {
        let provinceAlertController = UIAlertController(title: "Choose province", message: nil, preferredStyle: .actionSheet)

        Provinces.allCases.forEach {
            provinceAlertController.addAction(UIAlertAction(title: $0.info.name, style: .default, handler: { alert in
                textField.text = alert.title
            }))
        }
        
        provinceAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(provinceAlertController, animated: true)
    }
    
    private func presentDatePicker(textField: UITextField) {
        configureCustomSheetPresentationController()
        datePickerController.textField = textField
        datePickerController.delegate = textField
        present(datePickerController, animated: true)
    }
    
    private func configureCustomSheetPresentationController() {
        if let presentationController = datePickerController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.custom(resolver: { [weak self] _ in
                return (self?.view.frame.height ?? 200) / 2.5
            })]
            presentationController.prefersGrabberVisible = true
        }
    }
}

extension CVehiclesVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showDatePicker(textField: textField)
    }
    
    private func setTextFieldDelegates(viewsArray: [CItemSettingsView]) {
        viewsArray.forEach {
            $0.textField.delegate = self
        }
    }
}
