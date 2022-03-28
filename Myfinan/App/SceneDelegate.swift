//
//  SceneDelegate.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 21.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        let categoriesVC = ModuleBuilder.createCategoriesModule()
        let navBar = UINavigationController(rootViewController: categoriesVC)
        navBar.navigationBar.barStyle = .default
//        navBar.navigationBar.barStyle = .black
        navBar.navigationBar.backgroundColor = .systemOrange
        window?.rootViewController = navBar
        window?.rootViewController?.view.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
