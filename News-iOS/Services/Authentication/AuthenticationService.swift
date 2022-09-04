//
//  AuthenticationService.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 26.08.2022.
//

import Firebase
import GoogleSignIn

//MARK: - AuthenticationService protocol

public protocol AuthenticationService {
    func signInWithGoogle() async throws
    func signOut() throws
    func getCurrentUser() throws -> User?
}

final class AuthenticationServiceImpl {
    init() { }
    
    //MARK: - Sign in
    
    private func signIn(with credential: AuthCredential) async throws {
        try await Auth.auth().signIn(with: credential)
    }
}

//MARK: - Sign in with Google

extension AuthenticationServiceImpl: AuthenticationService {
    
    //MARK: - Get current user
    
    func getCurrentUser() throws -> User? {
        guard let user = Auth.auth().currentUser else { return nil }
        return user
    }
    
    func signInWithGoogle() async throws {
        let scenes = await UIApplication.shared.connectedScenes
        guard
            let windowScene = scenes.first as? UIWindowScene,
            let vc = await windowScene.windows.first?.rootViewController
        else { return }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        let user = try await GIDSignIn.sharedInstance.signIn(
            with: config,
            presenting: vc
        )
        
        guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
        else { return }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: authentication.accessToken
        )
        
        try await self.signIn(with: credential)
    }
    
    //MARK: - Sign out
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension GIDSignIn {
    @MainActor
    func signIn(with: GIDConfiguration, presenting: UIViewController) async throws -> GIDGoogleUser? {
        try await withCheckedThrowingContinuation({ continuation in
            self.signIn(with: with, presenting: presenting, callback: { user, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: user)
                }
            })
        })
    }
}
