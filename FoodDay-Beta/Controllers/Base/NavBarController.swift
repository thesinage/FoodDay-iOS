//
//  NavBarController.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 23.12.2023.
//

import UIKit

class NavBarController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBar.backgroundColor = .none
        navigationBar.isTranslucent = true
    }
 
    private func configure() {
        view.backgroundColor = R.Colors.white
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: R.Colors.text,
            .font: R.Fonts.helveticaRegular(with: 17)
        ]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
//        navigationBar.addBottomBorder(with: R.Colors.separator, height: 1)
    }
    
//    func setApperance() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        appearance.backgroundColor = .red
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
//    }
}
