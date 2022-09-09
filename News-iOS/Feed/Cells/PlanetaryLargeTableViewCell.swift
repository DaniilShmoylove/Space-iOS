//
//  PlanetaryLargeTableViewCell.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 21.08.2022.
//

import UIKit
import Kingfisher
import SnapKit

final class PlanetaryLargeTableViewCell: UITableViewCell {
    
    //MARK: - Identifier
    
    static let id: String = "PlanetaryLargeTableViewCell.cell"
    
    //MARK: - Views
    
    private let title           = UILabel()
    private let explanation     = UILabel()
    private let optionButton    = UIButton()
    private var sourceImage     = UIImageView()
    
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
    
    //MARK: - Configuration cell view
    
    func configure(with data: PlanetaryModel) {
        self.title.text = data.explanation
        self.explanation.text = data.copyrightWithPointDate
        
        /* Saved image */
        
        guard data.image == nil else {
            if let image = data.image {
                self.sourceImage.image = UIImage(data: image)
            }
            return
        }
        
        /* Download image */
        
        if let url = data.imageURL {
            let resource = ImageResource(downloadURL: url, cacheKey: url.cacheKey)
            self.sourceImage.kf.indicatorType = .activity
            self.sourceImage.kf
                .setImage(
                    with: resource,
                    options: [
                        .fromMemoryCacheOrRefresh,
                        .transition(.fade(AppConstants.Core.standartDuration))
                    ])
        }
    }
    
    /* Configure */
    
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
        
        //MARK: - Source image label
        
        self.addSubview(self.sourceImage)
        self.sourceImage.clipsToBounds              = true
        self.sourceImage.layer.cornerRadius         = AppConstants.UI.cornerRadius
        self.sourceImage.backgroundColor            = .systemGray4
        self.sourceImage.contentMode                = .scaleAspectFill
        self.sourceImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(AppConstants.UI.padding)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.UI.padding)
            make.height.equalTo(self.sourceImage.snp.width).multipliedBy(AppConstants.UI.multipliedBy)
        }
        
        //MARK: - StackView
        
        let stackView = UIStackView(arrangedSubviews: [self.title, self.explanation])
        self.addSubview(stackView)
        stackView.distribution  = .fill
        stackView.axis          = .vertical
        stackView.spacing       = 6
        stackView.alignment     = .top
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.sourceImage.snp.bottom).inset(-AppConstants.UI.cellVertical)
            make.left.right.equalTo(self.sourceImage)
            make.bottom.equalToSuperview().inset(AppConstants.UI.lowPadding)
        }
    }
}
