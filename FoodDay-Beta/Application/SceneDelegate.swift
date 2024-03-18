//
//  SceneDelegate.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 23.12.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let loginView = LoginController()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = loginView
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = UserDefaultsManager.shared.theme.getUserInterfaceStyle()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setTheme),
                                               name: Notification.Name("themeChanged"),
                                               object: nil)
    }
    
    func changeRootController( _ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        window.rootViewController = vc
        
        UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: nil )
    }
    
    @objc func setTheme() {
        window?.overrideUserInterfaceStyle = UserDefaultsManager.shared.theme.getUserInterfaceStyle()
    }
}
