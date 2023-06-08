//
//  UIViewController.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import UIKit

extension UIViewController {
    
    func showAlert(withMessage message: String?, title: String = "SugarScribe", preferredStyle: UIAlertController.Style = .alert, withActions actions: UIAlertAction...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if actions.count == 0 {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
