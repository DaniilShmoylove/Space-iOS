//
//  PlanetaryLargeTableViewCell.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 21.08.2022.
//

import UIKit
import Kingfisher

//MARK: - Planetary large cell delegate

protocol PlanetaryLargeCellDelegate: AnyObject {
    func favButtonDidTap()
}

final class PlanetaryLargeTableViewCell: UITableViewCell {
    
    //MARK: - Identifier
    
    static let id: String   = "PlanetaryLargeTableViewCell.cell"
    
    //MARK: - Delegate
    
    weak var delegate: PlanetaryLargeCellDelegate?
    
    //MARK: - Views
    
    private lazy var favButton: UIButton = {
        let configuration = UIButton.Configuration.navigationBarMaterial()
        let button = UIButton(configuration: configuration)
        button.frame = AppConstants.UI.materialButton
        button.addTarget(self, action: #selector(self.favButtonAction), for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    private let title       = UILabel()
    private let explanation = UILabel()
    private let optionButton = UIButton()
    private var sourceImage = UIImageView()
    
    //MARK: - Init
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true 
        self.configureCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure cell view

extension PlanetaryLargeTableViewCell: PlanetaryTableViewCell {
    private func configureCellView() {
        
        //MARK: - Title label
        
        self.title.numberOfLines    = 3
        self.title.textColor        = .label
        self.title.font             = .systemFont(ofSize: 18, weight: .bold)
        self.title.textAlignment    = .left
        
        //MARK: - Explanation label
        
        self.explanation.textColor        = .systemGray
        self.explanation.font             = .systemFont(ofSize: 12, weight: .medium)
        self.explanation.textAlignment    = .left
        
        //MARK: - Option button
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        self.optionButton.setImage(UIImage(systemName: "ellipsis", withConfiguration: imageConfiguration), for: .normal)
        self.optionButton.imageView?.tintColor = .systemGray
        
        self.sourceImage.addSubview(self.favButton)
        self.favButton.translatesAutoresizingMaskIntoConstraints = false
        self.favButton
            .leadingAnchor
            .constraint(equalTo: self.sourceImage.leadingAnchor, constant: AppConstants.UI.lowPadding)
            .isActive = true
        self.favButton
            .bottomAnchor
            .constraint(equalTo: self.sourceImage.bottomAnchor, constant: -AppConstants.UI.lowPadding)
            .isActive = true
        self.favButton
            .heightAnchor
            .constraint(equalToConstant: 36)
            .isActive = true
        self.favButton
            .widthAnchor
            .constraint(equalTo: self.favButton.heightAnchor)
            .isActive = true
        
        //MARK: - Source image label
        
        self.addSubview(self.sourceImage)
        self.sourceImage.clipsToBounds                              = true
        self.sourceImage.layer.cornerRadius = AppConstants.UI.cornerRadius
        self.sourceImage.isUserInteractionEnabled = true
        self.sourceImage.backgroundColor                            = .systemGray4
        self.sourceImage.contentMode = .scaleAspectFill
        self.sourceImage.translatesAutoresizingMaskIntoConstraints  = false
        self.sourceImage
            .topAnchor
            .constraint(equalTo: self.topAnchor, constant: AppConstants.UI.lowPadding)
            .isActive = true
        self.sourceImage
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: AppConstants.UI.padding)
            .isActive = true
        self.sourceImage
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -AppConstants.UI.padding)
            .isActive = true
        self.sourceImage
            .heightAnchor
            .constraint(equalTo: self.sourceImage.widthAnchor, multiplier: 9/16)
            .isActive = true
        
        //MARK: - StackView
        
        let stackView = UIStackView(arrangedSubviews: [self.title, self.explanation])
        self.addSubview(stackView)
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView
            .topAnchor
            .constraint(equalTo: self.sourceImage.bottomAnchor, constant: AppConstants.UI.cellVertical)
            .isActive = true
        stackView
            .leadingAnchor
            .constraint(equalTo: self.sourceImage.leadingAnchor)
            .isActive = true
        stackView
            .trailingAnchor
            .constraint(equalTo: self.sourceImage.trailingAnchor)
            .isActive = true
        stackView
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor, constant: -AppConstants.UI.lowPadding)
            .isActive = true
    }
    
    //MARK: - Configuration cell view
    
    func configure(with data: PlanetaryModel) {
        self.title.text = data.explanation
        self.explanation.text = data.copyrightWithPointDate
        
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

//MARK: - Delegate action

extension PlanetaryLargeTableViewCell {
    @objc private func favButtonAction() {
        self.delegate?.favButtonDidTap()
    }
}
