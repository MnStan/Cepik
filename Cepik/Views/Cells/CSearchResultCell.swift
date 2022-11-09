//
//  CSearchResultCell.swift
//  Cepik
//
//  Created by Maksymilian Stan on 09/11/2022.
//

import UIKit

class CSearchResultCell: UITableViewCell {
    
    static let reuseID = "SearchResultCell"
    let resultLabel = CTItleLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    private func configureCell() {
        addSubview(resultLabel)
        
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            resultLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            resultLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            resultLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            resultLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    func setTitle(title: String) {
        resultLabel.setTitle(title: title)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
