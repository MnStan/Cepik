//
//  CDatePickerVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 24/10/2022.
//

import UIKit

protocol DatePickerVCDelegate: UITextField {
    func updateTextLabel(withText text: String)
}

class CDatePickerVC: CLoadingVC {
    
    private let viewModel = SearchViewModel()
    
    weak var delegate: DatePickerVCDelegate?

    var datePicker = UIDatePicker()
    var textField: UITextField!
    var doneButton = CButton(title: "Done", color: .systemRed)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        bindDates()
        configureDatePicker()
        addSubviews()
        setupConstraints()
        configureButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.getDates()
        showLoadingView(backgroundColor: false)
    }
    
    private func bindDates() {
        SearchViewModel.pickedDate.bind { [weak self] date in
            guard let self else { return }
            guard let date else { return }
            self.delegate?.updateTextLabel(withText: date.convertToDayMonthYearFormat())
        }
        
        SearchViewModel.pickedDateTo.bind { [weak self] date in
            guard let self else { return }
            guard let date else { return }
            self.delegate?.updateTextLabel(withText: date.convertToDayMonthYearFormat())
        }
        
        viewModel.datesNetworkRequest.bind { [weak self] dates in
            guard let self else { return }
            guard let dates else { return }
            guard let meta = dates.meta else { return }
            
            self.dismissLoadingView()
            
            DispatchQueue.main.async {
                self.datePicker.minimumDate = meta.datePublished.convertStringToDatePickerDate()
                self.datePicker.maximumDate = self.viewModel.substractOneDay(date: meta.dateModified.convertStringToDatePickerDate())
                self.dateChanged()
                
                UIView.animate(withDuration: 0.5, delay: 0) {
                    self.datePicker.alpha = 1.0
                }
            }
        }
        
        viewModel.networkError.bind { [weak self] errorBool in
            guard let self else { return }
            
            if errorBool {
                DispatchQueue.main.async {
                    let ac = UIAlertController(title: "Can't get modification dates from database", message: "Please try again", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                        self.dismissLoadingView()
                        self.dismissView()
                    }))
                    
                    self.present(ac, animated: true)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        datePicker.date = Date.now
        chooseDateToUpdate()
    }
    
    private func configureButton() {
        doneButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(datePicker)
        view.addSubview(doneButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -10),
            
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            doneButton.heightAnchor.constraint(equalTo: doneButton.widthAnchor, multiplier: 0.3),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    private func configureDatePicker() {
        datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en_PL_POSIX")
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.timeZone = TimeZone.current
        textField.inputView = datePicker
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.alpha = 0.0
    }
    
    private func chooseDateToUpdate() {
        switch textField.tag {
        case 1:
            SearchViewModel.pickedDate.value = datePicker.date
        case 2:
            SearchViewModel.pickedDateTo.value = datePicker.date
        default:
            break
        }
    }
    
    @objc func dateChanged() {
        chooseDateToUpdate()
    }
}
