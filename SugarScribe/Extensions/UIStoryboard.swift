//
//  UIStoryboard.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import UIKit

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIStoryboard {
    
    var mealListViewController: MealListViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: MealListViewController.self)) as? MealListViewController else {
            fatalError(String(describing: MealListViewController.self) + " couldn't be found in Storyboard file")
        }
        return viewController
    }
    
    var mealDetailViewController: MealDetailViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: MealDetailViewController.self)) as? MealDetailViewController else {
            fatalError(String(describing: MealDetailViewController.self) + " couldn't be found in Storyboard file")
        }
        return viewController
    }
    
    var playVideoViewController: PlayVideoViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: PlayVideoViewController.self)) as? PlayVideoViewController else {
            fatalError(String(describing: PlayVideoViewController.self) + " couldn't be found in Storyboard file")
        }
        return viewController
    }
}
