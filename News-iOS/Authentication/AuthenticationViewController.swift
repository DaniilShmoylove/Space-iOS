//
//  AuthenticationViewController.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 23.08.2022.
//

import UIKit

final class AuthenticationViewController: UIViewController {
    
    //MARK: - Interactor
    
    private var interactor: AuthenticationInteractorLogic?
    
    //MARK: - Sign in button
    
    private lazy var signInButtonView: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with Google", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.titleLabel?.textColor = .white
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
        let text = "You agree to Privacy and Terms."
        label.text = text
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Title label
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "let's sign you in. Welcome back. You've been missed!"
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
        
        self.signInButtonView.translatesAutoresizingMaskIntoConstraints = false
        self.signInButtonView
            .bottomAnchor
            .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            .isActive = true
        self.signInButtonView
            .leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor, constant: AppConstants.UI.horizontal)
            .isActive = true
        self.signInButtonView
            .trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor, constant: -AppConstants.UI.horizontal)
            .isActive = true
        self.signInButtonView
            .heightAnchor
            .constraint(equalToConstant: 64)
            .isActive = true
        
        /* Privacy policy label layout */
        
        self.privacyPolicyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.privacyPolicyLabel
            .bottomAnchor
            .constraint(equalTo: self.signInButtonView.topAnchor, constant: -24)
            .isActive = true
        self.privacyPolicyLabel
            .leadingAnchor
            .constraint(equalTo: self.signInButtonView.leadingAnchor)
            .isActive = true
        self.privacyPolicyLabel
            .trailingAnchor
            .constraint(equalTo: self.signInButtonView.trailingAnchor)
            .isActive = true
        
        /* Title label layout */
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel
            .topAnchor
            .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
            .isActive = true
        self.titleLabel
            .leadingAnchor
            .constraint(equalTo: self.signInButtonView.leadingAnchor)
            .isActive = true
        self.titleLabel
            .trailingAnchor
            .constraint(equalTo: self.signInButtonView.trailingAnchor)
            .isActive = true
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
