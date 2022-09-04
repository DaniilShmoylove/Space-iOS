//
//  FeedHeaderView.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 29.07.2022.
//

import UIKit

final class FeedHeaderView: UIView {
    
    //MARK: - Title
    
    private let title = UILabel()
    
    //MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(
        title: String,
        isShowingHeaderAction: Bool = false
    ) {
        
        //MARK: - Title label
        
        self.title.text = title
        self.title.font = .systemFont(ofSize: 22, weight: .black)
        self.title.textAlignment = .left
        
        
        //MARK: - StackView
        
        self.addSubview(self.title)
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.title
            .topAnchor
            .constraint(equalTo: self.topAnchor)
            .isActive = true
        self.title
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor)
            .isActive = true
        self.title
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: AppConstants.UI.padding)
            .isActive = true
        self.title
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -AppConstants.UI.padding)
            .isActive = true
        self.title
            .heightAnchor
            .constraint(equalToConstant: AppConstants.UI.headerHeight)
            .isActive = true
    }
}
