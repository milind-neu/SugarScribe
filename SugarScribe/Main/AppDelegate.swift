//
//  AppDelegate.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = true
        
        let vc = UIStoryboard.main.mealListViewController
        let vm = MealListViewModel()
        vc.viewModel = vm
        
        // Insert MealListViewController at the root of the navigation stack
        navigationController.viewControllers.insert(vc, at: 0)
        return navigationController
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create the app's main UIWindow
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        
        // Check if the window is not nil and make it visible
        guard window != nil else {
            return true
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

