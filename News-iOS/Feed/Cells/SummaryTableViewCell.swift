//
//  SummaryTableViewCell.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 08.08.2022.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    //MARK: - Identifier
    
    static let id: String = "summary.cell"
    
    private lazy var summaryView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .justified
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        self.configurationSummaryViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurationSummaryViewCell() {
        self.addSubview(self.summaryView)
        
        self.summaryView.translatesAutoresizingMaskIntoConstraints = false
        self.summaryView
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: AppConstants.UI.summaryHorizontal)
            .isActive = true
        self.summaryView
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -AppConstants.UI.summaryHorizontal)
            .isActive = true
        self.summaryView
            .topAnchor
            .constraint(equalTo: self.topAnchor, constant: 6)
            .isActive = true
        self.summaryView
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor)
            .isActive = true
    }
    
    func configure(
        with summary: String?
    ) {
        self.summaryView.text = summary
    }
}
