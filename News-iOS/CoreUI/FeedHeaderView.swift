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
    
    //MARK: - Header action
    
    let headerAction = UIButton()
    
    //MARK: - init
    
    override init(
        frame: CGRect
    ) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(
        title: String,
        topPadding: CGFloat = .zero,
        isShowingHeaderAction: Bool = false
    ) {
        
        //MARK: - Title label
        
        self.title.text = title
        self.title.font = .systemFont(ofSize: 22, weight: .black)
        self.title.textAlignment = .left
        
        //MARK: - Header action
        
        if isShowingHeaderAction {
            self.headerAction.setTitle("See more", for: .normal)
            self.headerAction.titleLabel?.font = .systemFont(ofSize: 12)
            self.headerAction.setTitleColor(.systemGray, for: .normal)
        }
        
        //MARK: - StackView
        
        let stackView = UIStackView(arrangedSubviews: [self.title, self.headerAction])
        self.addSubview(stackView)
        stackView.alignment = .firstBaseline
        stackView.axis = .horizontal
 
        stackView.frame = CGRect(
            x: AppConstants.UI.summaryHorizontal,
            y: topPadding,
            width: UIScreen.main.bounds.width - AppConstants.UI.summaryHorizontal * 2,
            height: 32
        )
        
    }
}
