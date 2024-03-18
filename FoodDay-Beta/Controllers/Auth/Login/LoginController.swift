//
//  LoginController.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 29.12.2023.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseAuth

final class LoginController: UIViewController {
    
    private let imageView = UIImageView()
    
    private let titleLabel = UILabel()
    private let subTitle = UILabel()
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let forgotButton = UIButton()
    
    private let loginButton = UIButton()
    
    private let horizontalStack = UIStackView()
    private let registerLabel = UILabel()
    private let signUpButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        layoutViews()
        configure()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.object(forKey: R.UserDefaults.uid) != nil {
            let tabBar = TabBarController()
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootController(tabBar)
        }
    }
}

extension LoginController {
    func setupViews() {
        view.setupView(imageView)
        view.setupView(titleLabel)
        view.setupView(subTitle)
        view.setupView(emailTextField)
        view.setupView(passwordTextField)
        view.setupView(forgotButton)
        view.setupView(loginButton)
        
        view.setupView(horizontalStack)
        horizontalStack.addArrangedSubview(registerLabel)
        horizontalStack.addArrangedSubview(signUpButton)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            subTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -50),
            
            emailTextField.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            forgotButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            forgotButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -5),
            forgotButton.heightAnchor.constraint(equalToConstant: 30),
            forgotButton.widthAnchor.constraint(equalToConstant: 100),
        
            horizontalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            horizontalStack.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            horizontalStack.heightAnchor.constraint(equalToConstant: 30),
            
            loginButton.bottomAnchor.constraint(equalTo: horizontalStack.topAnchor, constant: -10),
            loginButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor)
            
            
        ])
    }
    
    func configure() {
        view.backgroundColor = R.Colors.background
//        view.addBlure(self.view, style: .systemUltraThinMaterialLight)
        
        imageView.image = R.Images.Login.enterLogo
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.textColor = R.Colors.text
        titleLabel.font = R.Fonts.helveticaRegular(with: 30)
        titleLabel.text = R.Strings.Login.title
        titleLabel.textAlignment = .center
        
        subTitle.textColor = R.Colors.text
        subTitle.font = R.Fonts.helveticaRegular(with: 20)
        subTitle.text = R.Strings.Login.subTitle
        subTitle.textAlignment = .center
        
        emailTextField.setStyle()
        emailTextField.leftPaddingPoints(10)
        emailTextField.placeholder = R.Strings.Login.emailPlaceholder
        
        //MARK: - auto login
        emailTextField.text = R.TestAuth.email
        passwordTextField.text = R.TestAuth.pass
        
        passwordTextField.setStyle()
        passwordTextField.leftPaddingPoints(10)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = R.Strings.Login.passwordPlaceholder
        
        forgotButton.setTitleColor(R.Colors.text, for: .normal)
        forgotButton.setTitle(R.Strings.Login.forgotButton, for: .normal)
        forgotButton.titleLabel?.font = R.Fonts.helveticaRegular(with: 10)
        forgotButton.addTarget(self, action: #selector(goToResetPass), for: .touchUpInside)
        
        loginButton.setTitle(R.Strings.Login.loginButton, for: .normal)
        loginButton.tintColor = R.Colors.white
        loginButton.backgroundColor = R.Colors.controlButton
        loginButton.layer.cornerRadius = 14
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(goToTabbar), for: .touchUpInside)
        
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 5
        
        registerLabel.textColor = R.Colors.text
        registerLabel.font = R.Fonts.helveticaRegular(with: 14)
        registerLabel.text = R.Strings.Login.registerlabel
        
        signUpButton.setTitle(R.Strings.Login.signUpButton, for: .normal)
        signUpButton.setTitleColor(R.Colors.green, for: .normal)
        signUpButton.titleLabel?.font = R.Fonts.helveticaRegular(with: 14)
        signUpButton.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        
    }
}

//MARK: - Segues

@objc extension LoginController {
    
    func goToTabbar() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    self.emailTextField.layer.borderColor = UIColor.red.cgColor
                    self.passwordTextField.layer.borderColor = UIColor.red.cgColor
                } else {
                    UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: R.UserDefaults.uid)
                    UserDefaults.standard.synchronize()
                    
                    let tabBar = TabBarController()
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootController(tabBar)
                }
            }
        }
    }
    
    func goToSignUp() {
        let signUp = SignUpController()
        
        let navVC = UINavigationController(rootViewController: signUp)
        
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc func goToResetPass() {
        let resetPass = ResetPassController()
        
        let navVC = UINavigationController(rootViewController: resetPass)
        
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }

}
