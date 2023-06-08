//
//  BaseViewController.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import UIKit
import RxSwift
import ProgressHUD

class BaseViewController: UIViewController {
    
    // MARK: - Variables
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("Deinit \(type(of: self))")
    }

    // MARK: - Helper Methods
    func showProgressActivity() {
        DispatchQueue.main.async {
            ProgressHUD.show()
        }
    }
    
    func hideProgressActivity() {
        DispatchQueue.main.async {
            ProgressHUD.dismiss()
        }
    }
}

// MARK: - Navigation Bar and Action
extension BaseViewController {
    
    func setNavigationAttributes(title: String, backButtonImage: UIImage = #imageLiteral(resourceName: "backButton"), backButtonSelector: Selector = #selector(onClickBackButton)) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height
        let backButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 30.0))
        backButton.contentHorizontalAlignment = .left
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .lightGray

        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: backButtonSelector, for: .touchUpInside)
        
        let backButtonContainerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 44, height: navigationBarHeight ?? 44.0))
        backButtonContainerView.addSubview(backButton)
        let leftBarButtonItem = UIBarButtonItem(customView: backButtonContainerView)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25.0)]
            
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = title

        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

    }
    
    @objc func onClickBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
