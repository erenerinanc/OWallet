//
//  AppDelegate.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController()
        window.rootViewController = UINavigationController(rootViewController: vc)
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

}

