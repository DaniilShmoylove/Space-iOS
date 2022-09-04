//
//  DismissButtonView.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 20.08.2022.
//

import UIKit

protocol DismissButtonDelegate: AnyObject {
    func dismissButtonDidTap()
}

class DismissButtonView: UIBarButtonItem {

    //MARK: - Delegate
    
    weak var delegate: DismissButtonDelegate?
    
    //MARK: - Button
    
    private lazy var dismissButton = UIButton()
    
    //MARK: - init
    
    init(delegate: DismissButtonDelegate) {
        super.init()
        self.delegate = delegate
        self.configureDismissButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure dismiss button
    
    private func configureDismissButton() {
        let configuration = UIButton.Configuration.navigationBarMaterial()
        self.dismissButton = UIButton(configuration: configuration)
        self.dismissButton.frame = AppConstants.UI.materialButton
        self.dismissButton.addTarget(self, action: #selector(self.dismissButtonAction), for: .touchUpInside)
        self.dismissButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        self.customView = self.dismissButton
    }
    
    //MARK: - Dismiss button action
    
    @objc private func dismissButtonAction() {
        self.delegate?.dismissButtonDidTap()
    }
}
