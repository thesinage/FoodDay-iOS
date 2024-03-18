//
//  Resources.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 23.12.2023.
//

import UIKit

enum R {
    enum Colors {
//        static let backgroundTemprorary = UIColor.init(hexString: "#e1fae8")
//        static let greenTemprorary = UIColor.init(hexString: "1DCA69")
//        static let graphiteTemporary = UIColor.init(hexString: "253238")
//        static let whiteTemporary = UIColor.init(hexString: "FBFBFB")
//        static let brownGraphiteTemporary = UIColor.init(hexString: "1DCA69")
//        static let separatorTemporary = UIColor.init(hexString: "E8ECEF")
//        static let warningTemprorary = UIColor.init(hexString: "FF0000")
        
        static let background = UIColor.brandBackground
        static let backgroundSecond = UIColor.brandBackgroundSecond
        static let text = UIColor.brandText
        static let green = UIColor.brandGreen
        static let warning = UIColor.brandWarning
        static let controlButton = UIColor.brandGreen
        static let white = UIColor.brandWhite
        static let controlBackground = UIColor.brandControlBack
        static let separator = UIColor.brandSeparator
        static let black = UIColor.brandBlack
        
        
    }
    
    enum Strings {
        enum TabBar {
            static let home = "Home"
            static let personalCabinet = "Personal cabinet"
            static let favourite = "Favourite"
        }
        
        enum Home {
            static let navTitle = "Food Day"
            static let placeholderTF = "Search for foods"
            static let typesOfRecipes = ["All recipes", "Breakfast", "Brunch", "Dinner", "Snack", "Teatime"]
        }
        
        enum PersonalCabinet {
            static let navTitle = "Personal cabinet"
            static let logOutButton = "Log out"
        }
        
        enum Favourite {
            static let navTitle = "Favourite foods"
        }
        
        
        // Auth
        enum Login {
            static let title = "Login"
            static let subTitle = "Enter your login and password"
            static let emailPlaceholder = "Email"
            static let passwordPlaceholder = "Password"
            static let forgotButton = "Forgot password?"
            static let loginButton = "Login"
            static let registerlabel = "Don`t hane an account"
            static let signUpButton = "Sign Up"
        }
        
        enum SignUp {
            static let title = "Sign up"
            static let subTitle = "Enter your informations"
            static let emailPlaceholder = "Email"
            static let passwordPlaceholder = "Password"
            static let chechkPassPlaceholder = "Confirm password"
            static let nextButton = "Next"
        }
        
        enum ResetPass {
            static let title = "Reset password"
            static let subTitle = "Enter your informations"
            static let emailPlaceholder = "Email"
            static let resetButton = "Reset"
        }
    }
    
    enum Images {
        enum TabBar {
            static let home = UIImage(systemName: "house")
            static let personalCabinet = UIImage(systemName: "person")
            static let favourite = UIImage(systemName: "heart")
        }
        
        enum Navigation {
            static let backArrow = UIImage(systemName: "chevron.backward")
        }
        
        enum Home {
            static let searchIcon = UIImage(systemName: "magnifyingglass")
            static let editeButton = UIImage(systemName: "slider.vertical.3")
        }
        
        enum Login {
            static let enterLogo = UIImage(named: "dish")
        }
        
        enum SignUp {
            static let signUpLogo = UIImage(named: "dinner")
        }
        
        enum ResetPass {
            static let resetPassLogo = UIImage(named: "passwordReset")
        }
        
    }
    
    enum Fonts {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
    
    enum UserDefaults {
        static let uid = "user_uid_key"
    }
    
    
    
    enum TestCell {
        static let title = "These is a test cell"
        static let subTtiitle = "X/Y - test value"
        static let image = UIImage(named: "test_image")
        static let isFavourite = UIImage(systemName: "heart.fill")
        static let isNotFovourite = UIImage(systemName: "heart")
    }
    
    enum TestAuth {
//        static let email = "testuser@gmail.com"
//        static let pass = "1q2w3e4r5t"
        
        static let email = "testseconduser@gmail.com"
        static let pass = "1q2w3e4r5t"
    }
}
