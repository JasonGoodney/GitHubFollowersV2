//
//  AppDelegate.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/18/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        
        configureAppearance()
        
        return true
    }
    
    
    private func configureAppearance() {
        UINavigationBar.appearance().tintColor  = .systemGreen
        UITabBar.appearance().tintColor         = .systemGreen
        UISearchBar.appearance().tintColor      = .systemGreen
    }
    

    private func createTabBar() -> UITabBarController {
        let tabbar = UITabBarController()
        tabbar.viewControllers = [createSearchVC(), createFavoritesVC()]
        
        return tabbar
    }
    
    
    private func createSearchVC() -> UINavigationController {
        let searchVC        = GFSearchVC()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let navVC           = UINavigationController(rootViewController: searchVC)
        
        return navVC
    }
    
    
    private func createFavoritesVC() -> UINavigationController {
        let favoritesVC         = GFFavoriteListVC()
        favoritesVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let navVC               = UINavigationController(rootViewController: favoritesVC)
        
        return navVC
    }
}

