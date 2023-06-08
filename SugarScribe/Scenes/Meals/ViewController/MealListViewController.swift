//
//  MealListViewController.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import UIKit

final class MealListViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var clcView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
        
    // MARK: - Variables
    var viewModel: MealListViewModel!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationAttributes(title: "Dessert", backButtonImage: UIImage())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.resetSearchBar()
    }
    
    // MARK: - Helper Methods
    func setupUI() {
        
        clcView.register(UINib(nibName: String(describing: MealListCollectionViewCell.self), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: MealListCollectionViewCell.self))
        
        searchBar.delegate = self
        self.definesPresentationContext = false
        clcView.collectionViewLayout = MealListCollectionViewFlowLayout()
        self.clcView.backgroundColor = .white

        self.showProgressActivity()
        self.viewModel.callGetMealListAPI()
    
    }
        
    func setupBinding() {
        self.viewModel.mealListAPIResponse.subscribe(onNext: { [weak self] result in
            guard let `self` = self else {
                return
            }
            if result {
                self.clcView.reloadData()
            } else {
                self.showAlert(withMessage: "API call error")
            }
            self.hideProgressActivity()
        }).disposed(by: disposeBag)
    }
    
    func resetSearchBar() {
        self.searchBar.showsCancelButton = false
        self.searchBar.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    func navigateToDetailScreen(mealId: String) {
        let vm = MealDetailViewModel(mealId: mealId)
        let vc = UIStoryboard.main.mealDetailViewController
        vc.viewModel = vm
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource Methods
extension MealListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredMeals.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MealListCollectionViewCell.self), for: indexPath) as? MealListCollectionViewCell ?? MealListCollectionViewCell()
        
            cell.configure(meal: self.viewModel.filteredMeals[indexPath.item])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let mealId = self.viewModel.filteredMeals[indexPath.item].id {
            self.navigateToDetailScreen(mealId: mealId)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.resetSearchBar()
    }
}

// MARK: - UISearchBarDelegate Methods
extension MealListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.viewModel.filteredMeals = self.viewModel.arrMeals
        self.resetSearchBar()
        self.clcView.backgroundView = nil
        self.clcView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.trimmed == ""  {
            self.viewModel.filteredMeals = self.viewModel.arrMeals
        } else {
            self.viewModel.filteredMeals = self.viewModel.arrMeals.filter({ (item) -> Bool in
                return (item.name?.localizedCaseInsensitiveContains(String(searchBar.text!)) ?? false)
            })
            
        }
        
        if self.viewModel.filteredMeals.count == 0 {
            let image = UIImageView(image: UIImage(named: "EmptyView.png"))
            image.contentMode = .center
            self.clcView.backgroundView = image
        } else {
            self.clcView.backgroundView = nil

        }
        
        clcView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.resetSearchBar()
        clcView.reloadData()
    }
    
}

final class MealListCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        self.scrollDirection = .vertical
        self.itemSize = CGSize(width: screenWidth/1.9 - 40, height: screenWidth/1.9 + 10)
        self.minimumInteritemSpacing = 5
        self.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
