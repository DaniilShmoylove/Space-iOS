//
//  AuthenticationInteractor.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 26.08.2022.
//

import Resolver

//MARK: - Authentication interactor protocol

protocol AuthenticationInteractorLogic {
    func signInWithGoogle() async throws
}

//MARK: - AuthenticationInteractor class

final class AuthenticationInteractor {
    init() { }
    
    //MARK: - AuthenticationService
    
    @Injected private var authenticationService: AuthenticationService
}

import UIKit

//MARK: - AuthenticationInteractor logic

extension AuthenticationInteractor: AuthenticationInteractorLogic {
    
    //MARK: - Sign in with Google
    
    @MainActor
    func signInWithGoogle() async throws {
        do {
            try await self.authenticationService.signInWithGoogle()
            guard
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let delegate = windowScene.delegate as? SceneDelegate
            else { return }
            delegate.openRecipientsController()
        } catch {
            print(error.localizedDescription)
        }
    }
}
