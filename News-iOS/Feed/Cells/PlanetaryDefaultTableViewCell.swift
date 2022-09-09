//
//  PlanetaryDefaultTableViewCell.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 28.07.2022.
//

import UIKit
import SnapKit
import Kingfisher

class PlanetaryDefaultTableViewCell: UITableViewCell {
    
    //MARK: - Cell identifier
    
    static let id: String   = "PlanetaryDefaultTableViewCell.cell"
    
    //MARK: - Views
    
    private let title       = UILabel()
    private let subtitle    = UILabel()
    private var sourceImage = UIImageView()
    
    //MARK: - Init
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlanetaryDefaultTableViewCell: PlanetaryTableViewCell {
    func configure(with data: PlanetaryModel) {
        self.title.text = data.copyrightWithPointDate
        self.subtitle.text = data.explanation
        
        /* Download image */
        
        if let url = data.imageURL {
            let resource = ImageResource(downloadURL: url, cacheKey: url.cacheKey)
            self.sourceImage.kf.indicatorType = .activity
            self.sourceImage.kf
                .setImage(
                    with: resource,
                    options: [
                        .transition(.fade(AppConstants.Core.standartDuration))
                    ])
        }
    }
}

extension PlanetaryDefaultTableViewCell {
    private func configureCellView() {
        
        //MARK: - Info View
        
        let stackView = UIStackView(arrangedSubviews: [self.subtitle, self.title])
        self.addSubview(stackView)
        stackView.distribution  = .fill
        stackView.axis          = .vertical
        stackView.spacing = 4
        
        //MARK: - Subtitle label
        
        self.subtitle.font = .systemFont(ofSize: 16, weight: .bold)
        self.subtitle.numberOfLines = 3
        self.subtitle.textColor     = .label
        self.subtitle.textAlignment = .left
        
        //MARK: - Title label
        
        self.title.textColor        = .systemGray
        self.title.font             = .systemFont(ofSize: 12, weight: .medium)
        self.title.textAlignment    = .left
        
        //MARK: - Source image label
        
        self.addSubview(self.sourceImage)
        self.sourceImage.layer.cornerRadius                         = AppConstants.UI.cornerRadius
        self.sourceImage.clipsToBounds                              = true
        self.sourceImage.backgroundColor                            = .systemGray4
        self.sourceImage.contentMode = .scaleAspectFill
        self.sourceImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(AppConstants.UI.padding)
            make.size.equalTo(88)
            make.verticalEdges.equalToSuperview().inset(AppConstants.UI.lowPadding)
        }
        
        //MARK: - StackView
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.sourceImage)
            make.right.equalToSuperview().inset(AppConstants.UI.padding)
            make.left.equalTo(self.sourceImage.snp.right).inset(-AppConstants.UI.padding)
        }
    }
}
