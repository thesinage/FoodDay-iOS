//
//  LoginViewModel.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 30.01.2024.
//

import UIKit
import FirebaseAuth

protocol LoginViewModelProtocol {
    func login(email: String, password: String)
}

class LoginViewModel: LoginViewModelProtocol {
    
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                let tabBar = TabBarController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootController(tabBar)
            }
        }
    }
    
    
}
