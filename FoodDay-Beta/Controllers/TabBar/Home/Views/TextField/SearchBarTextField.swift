//
//  SearchBarTextField.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 25.12.2023.
//

import UIKit
import IQKeyboardManagerSwift

protocol SearchBarTextFieldEndInput: AnyObject {
    func getRequsteWithParameter(_ parametr: String)
}

class SearchBarTextField: UITextField {
    var searchBarDelegate: SearchBarTextFieldEndInput?
    
    let searchImage = UIImageView()
    let button = UIButton(type: .custom)
    let padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 30)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchBarTextField {
    
    func configure() {
//        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        placeholder = R.Strings.Home.placeholderTF
        backgroundColor = R.Colors.backgroundSecond
        textColor = R.Colors.text
        layer.cornerRadius = 10
        layer.masksToBounds = true
        returnKeyType = .search
        
//        layer.shadowOpacity = 1
//        layer.shadowRadius = 1.0
//        layer.shadowOffset = .zero
//        layer.shadowColor = UIColor.black.cgColor
        
        leftViewMode = .always
        searchImage.image = R.Images.Home.searchIcon
        searchImage.tintColor = R.Colors.text
        searchImage.contentMode = .center
        leftView = searchImage
        
        
        rightView = button
        rightViewMode = .unlessEditing
        button.setImage(R.Images.Home.editeButton, for: .normal)
        button.tintColor = R.Colors.text
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        delegate = self
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        print("Button pressed")
    }
  
}

extension SearchBarTextField {
    
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - 30, y: 0, width: 20, height: bounds.height)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 10, y: 0, width: 20, height: bounds.height)
    }
}

extension SearchBarTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if self.text != "" {
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = self.text {
            self.searchBarDelegate?.getRequsteWithParameter(text)
        }
    }
}
