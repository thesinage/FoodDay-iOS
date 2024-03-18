//
//  TabBarController.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 23.12.2023.
//

import UIKit

enum Tabs: Int {
    case home
    case personalCabinet
    case favourite
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tabBar.tintColor = R.Colors.green
        tabBar.barTintColor = R.Colors.white
        tabBar.backgroundColor = R.Colors.backgroundSecond
        
        let homeController = HomeController()
        let personalCabinetController = PersonalCabinet()
        let favouriteController = Favourite()
        
        let homeNavigation = NavBarController(rootViewController: homeController)
        let personalCabinetNavigation = NavBarController(rootViewController: personalCabinetController)
        let favouriteNavigation = NavBarController(rootViewController: favouriteController)
        
        homeNavigation.tabBarItem = UITabBarItem(title: R.Strings.TabBar.home,
                                                 image: R.Images.TabBar.home,
                                                 tag: Tabs.home.rawValue)
        personalCabinetNavigation.tabBarItem = UITabBarItem(title: R.Strings.TabBar.personalCabinet,
                                                     image: R.Images.TabBar.personalCabinet,
                                                     tag: Tabs.personalCabinet.rawValue)
        favouriteNavigation.tabBarItem = UITabBarItem(title: R.Strings.TabBar.favourite,
                                                      image: R.Images.TabBar.favourite,
                                                      tag: Tabs.favourite.rawValue)
        setViewControllers([
            homeNavigation,
            personalCabinetNavigation,
            favouriteNavigation
        ], animated: false)
        
    }
}
