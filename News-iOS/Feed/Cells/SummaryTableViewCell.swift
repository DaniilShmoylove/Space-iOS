//
//  SummaryTableViewCell.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 08.08.2022.
//

import UIKit
import SnapKit

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
        
        self.summaryView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(AppConstants.UI.padding)
            make.verticalEdges.equalToSuperview().inset(AppConstants.UI.verticalDefault)
        }
    }
    
    func configure(
        with summary: String?
    ) {
        self.summaryView.text = summary
    }
}
