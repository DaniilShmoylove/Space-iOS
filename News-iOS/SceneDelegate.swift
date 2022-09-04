//
//  SceneDelegate.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 28.07.2022.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        if let _ = Auth.auth().currentUser {
            
            //MARK: - FeedViewController
            
            let feedViewController = FeedViewController()
            feedViewController.title = "Your feed"
            let feedNavigationController = UINavigationController(rootViewController: feedViewController)
            feedNavigationController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
            feedNavigationController.tabBarItem.image = UIImage(systemName: "house")
            
            //MARK: - SavedDataViewController
            
            let savedDataViewController = SavedDataViewController()
            savedDataViewController.title = "Favorite"
            let savedDataNavigationController = UINavigationController(rootViewController: savedDataViewController)
            savedDataNavigationController.tabBarItem.image = UIImage(systemName: "diamond")
            savedDataNavigationController.tabBarItem.selectedImage = UIImage(systemName: "diamond.fill")
            
            //MARK: -
            
            let otherVC = UIViewController()
            otherVC.title = "Options"
            let navVC = UINavigationController(rootViewController: otherVC)
            navVC.tabBarItem.image = UIImage(systemName: "person")
            navVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
            
            //MARK: - UITabBarController
            
            let tabBarController = UITabBarController()
            tabBarController.setViewControllers([feedNavigationController, savedDataNavigationController, navVC], animated: false)
            self.window?.rootViewController = tabBarController
        } else {
            let viewController = AuthenticationViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            self.window?.rootViewController = navigationController
        }
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        AppDelegate.saveContext()
    }
}

//MARK: - Change root vc

extension SceneDelegate {
    func openRecipientsController() {
        let viewController = FeedViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        guard let window = self.window else { return }
        window.rootViewController = navigationController
        UIView.transition(
            with: window,
            duration: AppConstants.Core.standartDuration,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}
