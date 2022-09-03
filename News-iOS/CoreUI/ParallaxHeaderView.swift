//
//  ParallaxHeaderView.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 04.08.2022.
//

import UIKit

class ParallaxHeaderView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.backgroundColor = .black
        overlay.alpha = 0.225
        imageView.addSubview(overlay)
        return imageView
    }()
    
    let titleLabelView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 36, weight: .black)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private var imageHeight = NSLayoutConstraint()
    private var imageBottom = NSLayoutConstraint()
    private var containerViewHeight = NSLayoutConstraint()
    private var containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createView()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(imageView)
        self.addSubview(titleLabelView)
        self.frame = CGRect(
            x: .zero,
            y: .zero,
            width: UIScreen.main.bounds.width,
            height:  UIScreen.main.bounds.width + 128
        )
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                widthAnchor.constraint(equalTo: self.containerView.widthAnchor),
                centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
                heightAnchor.constraint(equalTo: self.containerView.heightAnchor)
            ]
        )
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.widthAnchor.constraint(equalTo: self.imageView.widthAnchor).isActive = true
        self.containerViewHeight = self.containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        self.containerViewHeight.isActive = true
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageBottom = self.imageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
        self.imageBottom.isActive = true
        self.imageHeight = self.imageView.heightAnchor.constraint(equalTo: self.containerView.heightAnchor)
        self.imageHeight.isActive = true
        
        self.titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabelView
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: AppConstants.UI.padding)
            .isActive = true
        self.titleLabelView
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -AppConstants.UI.padding)
            .isActive = true
        self.titleLabelView
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor, constant: -24)
            .isActive = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.containerViewHeight.constant = scrollView.contentInset.top
        let offestY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        self.containerView.clipsToBounds = offestY <= 0
        self.imageBottom.constant = offestY >= 0 ? 0 : -offestY / 2
        self.imageHeight.constant = max(offestY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
