//
//  SearchVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/10/2022.
//

import UIKit

class SearchVC: UIViewController {
    
    private let viewModel = SearchViewModel()
    private var vehicleSearchInfo = VehicleSearchInfo()
    
    let searchButton = CButton(title: "Search", color: .systemRed)
    let searchSegmentedControl = UISegmentedControl(items: ["Vehicles", "ID", "Statistics"])
    var stackView: CItemsStackView!
    var inputViewsArray: [CItemSettingsView] = []
    var emptyTextField: Bool = false
    
    lazy var datePickerController = CDatePickerVC()
    
    var ageTextField: UITextField!
    
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
        
        setupButtonConstraints()
        setupSegmentedControlConstraints()
        
        setupButton()
        setupSegmentedControl()
        
        setupTestStackView()
        createDismissKeyboardTapGesture()
        
        setDatesBindings()
        addObserversForKeyboard()
    }
    
    private func addObserversForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setDatesBindings() {
        SearchViewModel.pickedDate.bind { [weak self] date in
            guard let self else { return }
            guard let date else { return }
            self.vehicleSearchInfo.dateFrom = date
        }
        SearchViewModel.pickedDateTo.bind { [weak self] date in
            guard let self else { return }
            guard let date else { return }
            self.vehicleSearchInfo.dateTo = date
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ageTextField.isFirstResponder {
            navigationItem.title = ""
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                UIView.animate(withDuration: 1, delay: 0) {
                    self.view.frame.origin.y = -keyboardSize.height
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 1, delay: 0) {
            self.view.frame.origin.y = 0
        } completion: { _ in
            self.navigationItem.title = "CEPiK"
        }

    }
    
    @objc func doneButtonClicked() {
        view.endEditing(true)
    }
    
    private func addSubViews() {
        view.addSubview(searchButton)
        view.addSubview(searchSegmentedControl)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: Navigation Controller configuration
    
    private func configureNavigationController() {
        view.backgroundColor = .systemBackground
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
    
    // MARK: Button configuration
    
    private func setupButton() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func searchButtonTapped() {
        checkTextFields()
        
        if emptyTextField != true {
            viewModel.checkDates(firstDate: inputViewsArray[1].textField.text!, secondDate: inputViewsArray[2].textField.text!) { [weak self] validation in
                guard let self else { return }
                
                if validation {
                    guard let province = self.inputViewsArray[0].textField.text?.removeDiacritics().replacingOccurrences(of: "-", with: "_") else { return }
                    guard let dataType = self.inputViewsArray[3].textField.text else { return }
                    guard let provinceEnum = Provinces(rawValue: province) else { return }
                    
                    self.vehicleSearchInfo.provinceNumber = provinceEnum.info.number
                    self.vehicleSearchInfo.dataType = dataType
                
                    self.viewModel.fetchData(vehicleInfo: self.vehicleSearchInfo )
                    
                } else {
                    #warning("First date bigger than second alert")
                    let ac = UIAlertController(title: "Wrong dates!", message: "Date to can't be sooner than date from", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                    self.present(ac, animated: true)
                }
            }
        } else {
            #warning("Show alert")
            let ac = UIAlertController(title: "All fields need to be filled", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(ac, animated: true)
        }
    }
    
    // MARK: TextFields check
    
    private func checkTextFields() {
        emptyTextField = false
        
        inputViewsArray.forEach {
            guard let input = $0.textField.text else { return }
            if (input.isEmpty) {
                $0.textField.placeholder = "Can't be empty"
                emptyTextField = true
            }
        }
    }
    
    // MARK: Segment Controller configuration
    
    private func setupSegmentedControl() {
        searchSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        searchSegmentedControl.selectedSegmentIndex = 0
        searchSegmentedControl.selectedSegmentTintColor = UIColor.systemGray4
        
        searchSegmentedControl.addTarget(self, action: #selector(searchSegmentedControlChanged), for: .valueChanged)
    }
    
    @objc func searchSegmentedControlChanged(_ sender: UISegmentedControl) {
        viewModel.segmentedValueChanged(selectedIndex: sender.selectedSegmentIndex)
        
        switch sender.selectedSegmentIndex {
        case 0:
            stackView.removeFromSuperview()
            setupTestStackView()
        case 1:
            stackView.removeFromSuperview()
            setupSecondStackView()
        case 2:
            stackView.removeFromSuperview()
            testVC()
        default:
            break
        }
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
    
    // MARK: View showing functions
    
    private func testVC() {
        
    }
    
    private func setupTestStackView() {
        let citem1 = CItemSettingsView(title: "Province", symbol: SFSymbols.province, tag: 0)
        let citem2 = CItemSettingsView(title: "Date from", symbol: SFSymbols.calendar, tag: 1)
        let citem3 = CItemSettingsView(title: "Date to", symbol: SFSymbols.calendar, tag: 2)
        let citem4 = CItemSettingsView(title: "Data type", symbol: SFSymbols.checkmark, tag: 3)
        
        inputViewsArray.removeAll()
        inputViewsArray = [citem1, citem2, citem3, citem4]

        stackView = CItemsStackView(viewsArray: inputViewsArray)
        
        setTextFieldsDelegates(viewsArray: inputViewsArray)

        setupStackViewConstraints()
        
    }
    
    private func setupSecondStackView() {
        let citem1 = CItemSettingsView(title: "Province", symbol: SFSymbols.province, tag: 0)
        let citem2 = CItemSettingsView(title: "Date", symbol: SFSymbols.calendar, tag: 1)
        let citem3 = CItemSettingsView(title: "Sex", symbol: SFSymbols.checkList, tag: 5)
        let citem4 = CItemSettingsView(title: "Age", symbol: SFSymbols.calendar, tag: 6)
        
        inputViewsArray.removeAll()
        inputViewsArray = [citem1, citem2, citem3, citem4]

        setTextFieldsDelegates(viewsArray: inputViewsArray)
        
        stackView = CItemsStackView(viewsArray: inputViewsArray)
        
        setupStackViewConstraints()
    }
    
    // MARK: DatePicker functions
    #warning("Może tutaj zrobić completion? i tam dodawać do modelu?")
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
        case 5:
            textField.resignFirstResponder()
            presentSexAlertController(textfield: textField)
        case 6:
            ageTextField = textField
            textField.inputAccessoryView = toolBar
            textField.returnKeyType = .done
            textField.keyboardType = .numberPad
            textField.keyboardAppearance = .default
            
            print("Test")
        default:
            print("Default")
            break
        }
    }
    
    private func presentDataTypeAlertController(textField: UITextField) {
        let dataTypeAlertController = UIAlertController(title: "Choose data type for vehicles", message: nil, preferredStyle: .actionSheet)
        
        dataTypeAlertController.addAction(UIAlertAction(title: "registered", style: .default, handler: { alert in
            textField.text = alert.title
        }))
        
        dataTypeAlertController.addAction(UIAlertAction(title: "all", style: .default, handler: { alert in
            textField.text = alert.title
        }))
        
        dataTypeAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(dataTypeAlertController, animated: true)
    }
    
    private func presentSexAlertController(textfield: UITextField) {
        let sexAlertController = UIAlertController(title: "Choose sex you want to search", message: nil, preferredStyle: .actionSheet)
        
        sexAlertController.addAction(UIAlertAction(title: "Female", style: .default, handler: { alert in
            textfield.text = alert.title
        }))
        
        sexAlertController.addAction(UIAlertAction(title: "Male", style: .default, handler: { alert in
            textfield.text = alert.title
        }))
        
        sexAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(sexAlertController, animated: true)
    }
    
    private func presentProvinceAlertController(textField: UITextField) {
        let provinceAlertController = UIAlertController(title: "Choose province you want to search", message: nil, preferredStyle: .actionSheet)

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
        self.text = text
    }
}
