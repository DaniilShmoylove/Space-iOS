//
//  ExploreCollectionViewCell.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 30.07.2022.
//

import UIKit
import Kingfisher

class ExploreTableViewCell: UITableViewCell {
    
    //MARK: - Identifier
    
    static let id: String = "exploreTableCell.cell"
    
    //MARK: - Explore data
    
    private var exploreData = [PlanetaryModel]()
    
    //MARK: - Explore collection view
    
    private var exploreCollectionView: UICollectionView
    
    //MARK: - Init
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: AppConstants.UI.exploreHeight, height: AppConstants.UI.exploreHeight)
        layout.sectionInset = UIEdgeInsets(
            top: .zero,
            left: AppConstants.UI.horizontal,
            bottom: .zero,
            right: AppConstants.UI.horizontal
        )
        self.exploreCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureExploreCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure explore collection view
    
    private func configureExploreCollectionView() {
        self.exploreCollectionView.backgroundColor = .systemGray6
        self.exploreCollectionView.showsHorizontalScrollIndicator = false
        self.exploreCollectionView.showsVerticalScrollIndicator = false
        self.exploreCollectionView.register(ExploreCollectionViewCell.self, forCellWithReuseIdentifier: ExploreCollectionViewCell.id)
        self.exploreCollectionView.delegate = self
        self.exploreCollectionView.dataSource = self
        self.contentView.addSubview(self.exploreCollectionView)
        self.exploreCollectionView.frame = self.frame
        
        self.exploreCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.exploreCollectionView
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor)
            .isActive = true
        self.exploreCollectionView
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor)
            .isActive = true
        self.exploreCollectionView
            .topAnchor
            .constraint(equalTo: self.topAnchor)
            .isActive = true
        self.exploreCollectionView
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor)
            .isActive = true
    }
    
    func configure(with model: [PlanetaryModel]) {
        self.exploreData = model
        self.exploreCollectionView.reloadData()
    }
}

extension ExploreTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //    //MARK: - Number of sections
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //MARK: - Number of items in section
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.exploreData.count
    }
    
    //MARK: - Cell for item at
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = self.exploreCollectionView.dequeueReusableCell(
            withReuseIdentifier: ExploreCollectionViewCell.id,
            for: indexPath
        ) as! ExploreCollectionViewCell
        let model = self.exploreData[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        self.exploreCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ExploreTableViewCell: UICollectionViewDelegateFlowLayout { }

class ExploreCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Identifier
    
    static let id: String = "exploreCollectionCell.cell"
    
    //MARK: - Configure
    
    public func configure(with model: PlanetaryModel) {
        self.exploreView.setTitle(model.title, for: .normal)
        if let url = model.imageURL {
            let resource = ImageResource(downloadURL: url, cacheKey: url.cacheKey)
            self.exploreView.imageView?.kf.indicatorType = .activity
            self.exploreView.imageView?.kf
                .setImage(
                    with: resource,
                    options: [
                        .transition(.fade(AppConstants.Core.standartDuration))
                    ])
        }
    }
    
    //MARK: - ExploreView
    
    private let exploreView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray4
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.frame = CGRect(
            x: .zero,
            y: .zero,
            width: AppConstants.UI.exploreHeight,
            height: AppConstants.UI.exploreHeight
        )
        button.layer.cornerRadius = button.frame.width / 2
        return button
    }()
    
    @objc private func exploreAction() {
        print("Hello")
    }
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(exploreView)
        self.exploreView.addTarget(self, action: #selector(self.exploreAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
