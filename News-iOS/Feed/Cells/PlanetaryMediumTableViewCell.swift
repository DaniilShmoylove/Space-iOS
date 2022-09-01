//
//  PlanetaryMediumTableViewCell.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 28.07.2022.
//

import UIKit
import Kingfisher

class PlanetaryMediumTableViewCell: UITableViewCell {
    
    //MARK: - Cell identifier
    
    static let id: String   = "PlanetaryMediumTableViewCell.cell"
    
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

extension PlanetaryMediumTableViewCell: PlanetaryTableViewCell {
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

extension PlanetaryMediumTableViewCell {
    private func configureCellView() {
        
        //MARK: - Info View
        
        let stackView = UIStackView(arrangedSubviews: [self.subtitle, self.title])
        self.addSubview(stackView)
        stackView.distribution = .fill
        stackView.spacing = 6
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - Subtitle label
        
        self.subtitle.font = .systemFont(ofSize: 16, weight: .bold)
        self.subtitle.numberOfLines = 3
        self.subtitle.textColor     = .label
        self.subtitle.textAlignment = .left
        
        //MARK: - Title label
        
        self.title.numberOfLines    = 0
        self.title.textColor        = .systemGray
        self.title.font             = .systemFont(ofSize: 12, weight: .medium)
        self.title.textAlignment    = .left
        
        //MARK: - Source image label
        
        self.addSubview(self.sourceImage)
        self.sourceImage.layer.cornerRadius                         = AppConstants.UI.cornerRadius
        self.sourceImage.clipsToBounds                              = true
        self.sourceImage.backgroundColor                            = .systemGray4
        self.sourceImage.contentMode = .scaleAspectFill
        self.sourceImage.translatesAutoresizingMaskIntoConstraints  = false
        self.sourceImage
            .centerYAnchor
            .constraint(equalTo: self.centerYAnchor)
            .isActive = true
        self.sourceImage
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: AppConstants.UI.padding)
            .isActive = true
        self.heightAnchor
            .constraint(equalToConstant: 104)
            .isActive = true
        self.sourceImage
            .widthAnchor
            .constraint(equalTo: self.sourceImage.heightAnchor)
            .isActive = true
        self.sourceImage
            .topAnchor
            .constraint(equalTo: self.topAnchor, constant: AppConstants.UI.lowPadding)
            .isActive = true
        self.sourceImage
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor, constant: -AppConstants.UI.lowPadding)
            .isActive = true
        
        stackView
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -AppConstants.UI.padding)
            .isActive = true
        stackView
            .leadingAnchor
            .constraint(equalTo: self.sourceImage.trailingAnchor, constant: AppConstants.UI.padding)
            .isActive = true
        stackView
            .topAnchor
            .constraint(equalTo: self.sourceImage.topAnchor)
            .isActive = true
        stackView
            .bottomAnchor
            .constraint(equalTo: self.sourceImage.bottomAnchor)
            .isActive = true
    }
}
