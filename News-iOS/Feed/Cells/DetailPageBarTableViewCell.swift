//
//  DetailPageBarTableViewCell.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 10.08.2022.
//

import UIKit

class DetailPageBarTableViewCell: UITableViewCell {
    
    private lazy var detailPageBarLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        self.configurationDetailPageBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurationDetailPageBar() {
        self.addSubview(self.detailPageBarLabel)
        
        self.detailPageBarLabel.translatesAutoresizingMaskIntoConstraints = false
        self.detailPageBarLabel
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: AppConstants.UI.padding)
            .isActive = true
        self.detailPageBarLabel
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -AppConstants.UI.padding)
            .isActive = true
        self.detailPageBarLabel
            .topAnchor
            .constraint(equalTo: self.topAnchor, constant: AppConstants.UI.vertical)
            .isActive = true
        self.detailPageBarLabel
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor, constant: 0)
            .isActive = true
        
    }
    
    func configure(
        with title: String?
    ) {
        self.detailPageBarLabel.text = title
    }
}
