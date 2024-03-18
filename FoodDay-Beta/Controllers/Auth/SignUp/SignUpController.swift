//
//  SignUpController.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 30.12.2023.
//

import UIKit
import FirebaseAuth

final class SignUpController: UIViewController {
    
    private let imageView = UIImageView()
    
    private let titleLabel = UILabel()
    private let subTitle = UILabel()
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let checkPassTextField = UITextField()
    
    private let nextButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
        layoutViews()
        configure()
    }
}

extension SignUpController {
    func setupViews() {
        view.setupView(imageView)
        view.setupView(titleLabel)
        view.setupView(subTitle)
        view.setupView(emailTextField)
        view.setupView(passwordTextField)
        view.setupView(checkPassTextField)
        view.setupView(nextButton)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            subTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitle.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitle.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            checkPassTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            checkPassTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            checkPassTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            checkPassTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            nextButton.topAnchor.constraint(equalTo: checkPassTextField.bottomAnchor, constant: 60),
            nextButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            nextButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor)
        ])
    }
    
    func configure() {
        view.backgroundColor = R.Colors.background
        
        imageView.image = R.Images.SignUp.signUpLogo
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.textColor = R.Colors.text
        titleLabel.font = R.Fonts.helveticaRegular(with: 30)
        titleLabel.text = R.Strings.SignUp.title
        titleLabel.textAlignment = .center
        
        subTitle.textColor = R.Colors.text
        subTitle.font = R.Fonts.helveticaRegular(with: 20)
        subTitle.text = R.Strings.SignUp.subTitle
        subTitle.textAlignment = .center
        
        emailTextField.setStyle()
        emailTextField.leftPaddingPoints(10)
        emailTextField.placeholder = R.Strings.SignUp.emailPlaceholder
        
        passwordTextField.setStyle()
        passwordTextField.leftPaddingPoints(10)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = R.Strings.SignUp.passwordPlaceholder

        checkPassTextField.setStyle()
        checkPassTextField.leftPaddingPoints(10)
        checkPassTextField.isSecureTextEntry = true
        checkPassTextField.placeholder = R.Strings.SignUp.chechkPassPlaceholder
        
        nextButton.setTitle(R.Strings.SignUp.nextButton, for: .normal)
        nextButton.tintColor = R.Colors.white
        nextButton.backgroundColor = R.Colors.green
        nextButton.layer.cornerRadius = 14
        nextButton.layer.masksToBounds = true
        nextButton.addTarget(self, action: #selector(goToTabBar), for: .touchUpInside)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.Images.Navigation.backArrow,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = R.Colors.text
    }
}


@objc extension SignUpController {
    func dismissSelf() {
        dismiss(animated: true)
    }
    
    func goToTabBar() {
        
        if let email = emailTextField.text, let pass = passwordTextField.text, let checkPass = checkPassTextField.text {
            if pass == checkPass {
                Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
                    if let e = error {
                        print(e.localizedDescription)
                    } else {
                        UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: R.UserDefaults.uid)
                        UserDefaults.standard.synchronize()
                        
                        let tabBar = TabBarController()
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootController(tabBar)
                    }
                }
            } else {
                subTitle.text = "passwords don't match"
                subTitle.textColor = UIColor.red
                
                passwordTextField.layer.borderColor = UIColor.red.cgColor
                checkPassTextField.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
}
