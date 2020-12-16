//
//  SceneDelegate.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import UIKit
import AppsFlyerLib

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Обработка универсальной ссылки из убитого состояния
        if let userActivity = connectionOptions.userActivities.first {
            self.scene(scene, continue: userActivity)
        }
        // Обработка URI-схемы из убитого состояния
        self.scene(scene, openURLContexts: connectionOptions.urlContexts)

        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            AppsFlyerLib.shared().handleOpen(url, options: nil)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
