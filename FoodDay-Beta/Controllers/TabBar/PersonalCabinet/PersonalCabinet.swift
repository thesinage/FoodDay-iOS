//
//  PersonalCabinet.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 23.12.2023.
//

import UIKit
import FirebaseAuth

final class PersonalCabinet: BaseController {
    
    private let logOutButton = UIButton()
    private let allbutton = UIButton()
    private let secondTitle = UILabel()
    
    private let settingsView = SettingsView()
    
    override func viewDidLoad() {
        setupViews()
        layoutView()
        configure()
    }
    
    @objc func goToLogin() {
        do {
            try Auth.auth().signOut()
            
            if Auth.auth().currentUser == nil {
                UserDefaults.standard.removeObject(forKey: R.UserDefaults.uid)
                UserDefaults.standard.synchronize()
                
                let tabBar = LoginController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootController(tabBar)
            }
        } catch {
            print("already logged out")
        }
    }
}

extension PersonalCabinet {
    override func setupViews() {
        view.setupView(settingsView)
        
    }
    override func layoutView() {
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            settingsView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    override func configure() {
        super.configure()
        title = R.Strings.PersonalCabinet.navTitle
        navigationController?.tabBarItem.title = R.Strings.TabBar.personalCabinet
        navigationController?.navigationBar.prefersLargeTitles = true
        
        logOutButton.setTitle(R.Strings.PersonalCabinet.logOutButton, for: .normal)
        logOutButton.setTitleColor(R.Colors.green, for: .normal)
        logOutButton.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logOutButton)
        
    }
}
