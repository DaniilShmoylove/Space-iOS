//
//  DetailPageBarTableViewCell.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 10.08.2022.
//

import UIKit
import SnapKit

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
        
        self.detailPageBarLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(AppConstants.UI.padding)
            make.verticalEdges.equalToSuperview().inset(AppConstants.UI.verticalDefault)
        }
    }
    
    func configure(
        with title: String?
    ) {
        self.detailPageBarLabel.text = title
    }
}
