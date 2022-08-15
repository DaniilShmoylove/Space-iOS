//
//  PlanetaryFeedTableViewCell.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 28.07.2022.
//

import UIKit
import Kingfisher

protocol PlanetaryFeedTableViewCellDelegate: AnyObject {
    func didAddButtonTap(index: Int)
}

class PlanetaryFeedTableViewCell: UITableViewCell {
    
    //MARK: - Cell identifier
    
    static let id: String   = "movieCell.cell"
    
    //MARK: - Delegate
    
    weak var delegate: PlanetaryFeedTableViewCellDelegate?
    
    //MARK: - Index
    
    private var index: Int?
    
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

extension PlanetaryFeedTableViewCell {
    func configure(with data: PlanetaryModel) {
        self.title.text = data.explanation
        self.subtitle.text = data.title
        //TODO: - AddButton by index 
        
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
    
    @objc func addButtonTap() {
        guard let index = self.index else { return }
        self.delegate?.didAddButtonTap(index: index)
    }
}

extension PlanetaryFeedTableViewCell {
    private func configureCellView() {
        
        //MARK: - Info View
        
        let stackView = UIStackView(arrangedSubviews: [self.subtitle, self.title])
        self.addSubview(stackView)
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView
            .centerYAnchor
            .constraint(equalTo: self.centerYAnchor)
            .isActive = true
        stackView
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: AppConstants.UI.summaryHorizontal)
            .isActive = true
        
        //MARK: - Subtitle label
        
        let textFont: UIFont = .systemFont(ofSize: 14, weight: .semibold)
        
        self.subtitle.font = textFont
        self.subtitle.numberOfLines = 0
        self.subtitle.textColor     = .label
        self.subtitle.textAlignment = .left
        
        //MARK: - Title label
        
        self.title.numberOfLines    = 0
        self.title.textColor        = .systemGray
        self.title.font             = textFont
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
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -AppConstants.UI.summaryHorizontal)
            .isActive = true
        self.sourceImage
            .heightAnchor
            .constraint(equalToConstant: 112)
            .isActive = true
        self.sourceImage
            .widthAnchor
            .constraint(equalTo: self.sourceImage.heightAnchor)
            .isActive = true
        self.sourceImage
            .topAnchor
            .constraint(equalTo: self.topAnchor, constant: 6)
            .isActive = true
        self.sourceImage
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor, constant: -18)
            .isActive = true
        stackView
            .trailingAnchor
            .constraint(equalTo: self.sourceImage.leadingAnchor, constant: -16)
            .isActive = true
        stackView
            .heightAnchor
            .constraint(equalTo: self.sourceImage.heightAnchor)
            .isActive = true
    }
}






final class PictureDayTableViewCell: UITableViewCell {
    
    //MARK: - Identifier
    
    static let id: String   = "PictureDayTableViewCell.cell"
    
    //MARK: - Views
    
    private let title       = UILabel()
    private var sourceImage = UIImageView()
    
    //MARK: - Init
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        self.configureCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure cell view

extension PictureDayTableViewCell {
    private func configureCellView() {
        
        //MARK: - Title label
        
        self.title.numberOfLines    = 0
        self.title.textColor        = .label
        self.title.font             = .systemFont(ofSize: 24, weight: .black)
        self.title.textAlignment    = .left
        self.title.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - Source image label
        
        self.addSubview(self.sourceImage)
        self.sourceImage.layer.cornerRadius                         = AppConstants.UI.cornerRadius
        self.sourceImage.clipsToBounds                              = true
        self.sourceImage.backgroundColor                            = .systemGray4
        self.sourceImage.contentMode = .scaleAspectFill
        self.sourceImage.translatesAutoresizingMaskIntoConstraints  = false
        self.sourceImage
            .topAnchor
            .constraint(equalTo: self.topAnchor, constant: 10)
            .isActive = true
        self.sourceImage
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor, constant: -10)
            .isActive = true
        self.sourceImage
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: AppConstants.UI.summaryHorizontal)
            .isActive = true
        self.sourceImage
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -AppConstants.UI.summaryHorizontal)
            .isActive = true
        self.sourceImage
            .heightAnchor
            .constraint(equalToConstant: UIScreen.main.bounds.width - 96)
            .isActive = true
        
        self.sourceImage.addSubview(self.title)
        self.title
            .leadingAnchor
            .constraint(equalTo: self.sourceImage.leadingAnchor, constant: AppConstants.UI.summaryHorizontal)
            .isActive = true
        self.title
            .trailingAnchor
            .constraint(equalTo: self.sourceImage.trailingAnchor, constant: -AppConstants.UI.summaryHorizontal)
            .isActive = true
        self.title
            .bottomAnchor
            .constraint(equalTo: self.sourceImage.bottomAnchor, constant: -16)
            .isActive = true
    }
    
    //MARK: - Configuration cell view
    
    func configure(with data: PlanetaryModel) {
        self.title.text = data.title
        
        if let url = data.imageURL {
            let resource = ImageResource(downloadURL: url, cacheKey: url.cacheKey)
            self.sourceImage.kf.indicatorType = .activity
            self.sourceImage.kf
                .setImage(
                    with: resource,
                    options: [
                        .loadDiskFileSynchronously,
                        .cacheOriginalImage,
                        .transition(.fade(AppConstants.Core.standartDuration))
                    ])
        }
    }
}
