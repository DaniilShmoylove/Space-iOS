//
//  ExploreCollectionViewCell.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 30.07.2022.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
    
    //MARK: - Identifier
    
    static let id: String = "exploreTableCell.cell"
    
    //MARK: - Explore data
    
    private var exploreData = [ExploreModel]()
    
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
        self.contentView.backgroundColor = .systemRed
        self.configureExploreCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure explore collection view
    
    private func configureExploreCollectionView() {
        
        //MARK: - Cell background
        
        self.exploreCollectionView.backgroundColor = UIColor(named: "listBackground")
        self.exploreCollectionView.showsHorizontalScrollIndicator = false
        self.exploreCollectionView.showsVerticalScrollIndicator = false
        self.exploreCollectionView.register(ExploreCollectionViewCell.self, forCellWithReuseIdentifier: ExploreCollectionViewCell.id)
        self.exploreCollectionView.delegate = self
        self.exploreCollectionView.dataSource = self
        self.contentView.addSubview(self.exploreCollectionView)
    }
    
    func configure(with model: [ExploreModel]) {
        self.exploreData = model
        print(self.exploreData.count)
        self.exploreCollectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.exploreCollectionView.frame = self.contentView.bounds
    }
}

extension ExploreTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: - Number of sections
    
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

//extension ExploreTableViewCell: UICollectionViewDelegateFlowLayout { }

class ExploreCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Identifier
    
    static let id: String = "exploreCollectionCell.cell"
    
    //MARK: - Configure
    
    public func configure(with model: ExploreModel) {
        self.exploreView.setTitle(model.name, for: .normal)
//        self.exploreView.text = model.name
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
