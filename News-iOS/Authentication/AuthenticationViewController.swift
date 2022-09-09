//
//  AuthenticationViewController.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 23.08.2022.
//

import UIKit
import SnapKit

final class AuthenticationViewController: UIViewController {
    
    //MARK: - Interactor
    
    private var interactor: AuthenticationInteractorLogic?
    
    //MARK: - Sign in button
    
    private lazy var signInButtonView: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("auth_button_title".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(self.signInButtonAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    
    init() { super.init(nibName: nil, bundle: nil); self.setup() }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = AuthenticationInteractor()
        viewController.interactor = interactor
    }
    
    //MARK: - Privacy policy label
    
    private lazy var privacyPolicyLabel: UILabel = {
        let label = UILabel()
        let text = "auth_privacy_title".localized()
        label.text = text
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Title label
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "auth_welcome_title".localized()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 36, weight: .black)
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.signInButtonView)
        self.view.addSubview(self.privacyPolicyLabel)
        self.view.addSubview(self.titleLabel)
        
    }
    
    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /* Sign in button layout */
        
        self.signInButtonView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(AppConstants.UI.padding)
            make.left.right.equalToSuperview().inset(AppConstants.UI.horizontal)
            make.height.equalTo(64)
        }
        
        /* Privacy policy label layout */
        
        self.privacyPolicyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.signInButtonView.snp.top).inset(-AppConstants.UI.padding)
            make.horizontalEdges.equalTo(self.signInButtonView)
        }
        
        /* Title label layout */
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(AppConstants.UI.padding)
            make.horizontalEdges.equalTo(self.signInButtonView)
        }
    }
}

extension AuthenticationViewController {
    
    //MARK: - Button action
    
    @objc private func signInButtonAction() {
        Task {
            do {
                try await self.interactor?.signInWithGoogle()
            } catch {
                print(error)
            }
        }
    }
}
