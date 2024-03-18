//
//  ResetPassController.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 30.12.2023.
//

import UIKit
import FirebaseAuth

final class ResetPassController: UIViewController {
    
    private let imageView = UIImageView()
    
    private let titleLabel = UILabel()
    private let subTitle = UILabel()
    
    private let emailTextField = UITextField()
    private let resetButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        setupViews()
        layoutViews()
        configure()
    }
}

extension ResetPassController {
    func setupViews() {
        view.setupView(imageView)
        view.setupView(titleLabel)
        view.setupView(subTitle)
        view.setupView(emailTextField)
        view.setupView(resetButton)
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
            
            resetButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            resetButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            resetButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            resetButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor)
        ])
    }
    
    func configure() {
        view.backgroundColor = R.Colors.background
        
        imageView.image = R.Images.ResetPass.resetPassLogo
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.textColor = R.Colors.text
        titleLabel.font = R.Fonts.helveticaRegular(with: 30)
        titleLabel.text = R.Strings.ResetPass.title
        titleLabel.textAlignment = .center
        
        subTitle.textColor = R.Colors.text
        subTitle.font = R.Fonts.helveticaRegular(with: 20)
        subTitle.text = R.Strings.ResetPass.subTitle
        subTitle.textAlignment = .center
        
        emailTextField.setStyle()
        emailTextField.leftPaddingPoints(10)
        emailTextField.placeholder = R.Strings.SignUp.emailPlaceholder
        
        resetButton.setTitle(R.Strings.ResetPass.resetButton, for: .normal)
        resetButton.tintColor = R.Colors.white
        resetButton.backgroundColor = R.Colors.green
        resetButton.layer.cornerRadius = 14
        resetButton.layer.masksToBounds = true
        resetButton.addTarget(self, action: #selector(sendPasswordReset), for: .touchUpInside)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.Images.Navigation.backArrow,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = R.Colors.text
    }
}


@objc extension ResetPassController {
    func dismissSelf() {
        dismiss(animated: true)
    }
    
    func sendPasswordReset() {
        if let email = emailTextField.text {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let e = error {
                    print(e)
                    self.emailTextField.layer.borderColor = UIColor.red.cgColor
                } else {
                    self.dismiss(animated: true)
                }
            }
        }
    }
}
