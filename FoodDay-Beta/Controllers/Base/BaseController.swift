//
//  BaseController.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 23.12.2023.
//

import UIKit

enum NavBarPositions {
    case left
    case right
}

class BaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        layoutView()
        configure()
    }
}

@objc extension BaseController {
    func setupViews() {
        
    }
    func layoutView() {
        
    }
    func configure() {
//        view.backgroundColor = R.Colors.background.withAlphaComponent(0.1)
        view.backgroundColor = R.Colors.background
    }
    
    func navBarLeftButtonHandler() {
        print("left")
    }
    
    func navBarRightButtonHandler() {
        print("right")
    }
    
}


//extension BaseController {
//    func addNavBarButton(at position: NavBarPositions, with title: String) {
//        let button = UIButton(type: .system)
//        button.setTitle(title, for: .normal)
//        button.setTitleColor(R.Colors.green, for: .normal)
//        button.setTitleColor(R.Colors.graphite, for: .disabled)
//        
//        button.addTarget(self, action: #selector(target), for: .touchUpInside)
//        
//        switch position {
//        case .left:
//            button.addTarget(self, action: #selector(navBarLeftButtonHandler), for: .touchUpInside)
//            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
//        case .right:
//            button.addTarget(self, action: #selector(navBarRightButtonHandler), for: .touchUpInside)
//            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
//        }
//    }
//}
