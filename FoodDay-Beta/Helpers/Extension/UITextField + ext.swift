//
//  UITextField.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 29.12.2023.
//

import UIKit

extension UITextField {
     func leftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func setStyle() {
        font = R.Fonts.helveticaRegular(with: 18)
        layer.cornerRadius = CGFloat(12)
        layer.borderWidth = 1.0
        layer.masksToBounds = true
        layer.borderColor = R.Colors.backgroundSecond.cgColor
        backgroundColor = .brandBackgroundSecond
        
    }
}
