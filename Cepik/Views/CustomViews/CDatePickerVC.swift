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

class CDatePickerVC: UIViewController {
    
    private let viewModel = SearchViewModel()
    
    weak var delegate: DatePickerVCDelegate?

    var datePicker = UIDatePicker()
    var textField: UITextField!
    var doneButton = CButton(title: "Done", color: .systemRed)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDatePicker()
        addSubviews()
        setupConstraints()
        configureButton()
        view.backgroundColor = .systemBackground
        
        viewModel.formattedDate.bind { date in
            self.delegate?.updateTextLabel(withText: date ?? "")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.formatDate(date: datePicker.date)
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
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = .now
        textField.inputView = datePicker
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func dateChanged() {
        viewModel.formatDate(date: datePicker.date)
    }
}
