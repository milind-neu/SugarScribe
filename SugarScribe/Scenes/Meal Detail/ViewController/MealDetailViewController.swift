//
//  MealDetailViewController.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import UIKit

final class MealDetailViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imgMealBackdrop: UIImageView!
    @IBOutlet weak var lblMealName: UILabel!
    @IBOutlet weak var btnPlay: CCButton!
    @IBOutlet weak var lblMealInstructions: UILabel!
    @IBOutlet weak var tblViewIngredients: UITableView!
    @IBOutlet weak var tblViewIngredientsHeight: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    
    // MARK: - Variables
    var viewModel: MealDetailViewModel!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        callAPIs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Helper Methods
    func setupUI() {
        
        tblViewIngredients.register(UINib(nibName: String(describing: IngredientTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: IngredientTableViewCell.self))

        lblMealInstructions.numberOfLines = 2
        lblMealInstructions.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        self.mainView.isHidden = true
        
    }
    
    func callAPIs() {
        self.showProgressActivity()
        self.viewModel.callGetMealDetailAPI()
    }
    
    func setupBinding() {
        
        self.viewModel.mealDetailAPIResponse.subscribe(onNext: { [weak self] result in
            guard let `self` = self else {
                return
            }
            if result {
                DispatchQueue.main.async {
                    self.fillData()
                    self.mainView.isHidden = false
                }
            } else {
                self.showAlert(withMessage: "API call error")
            }
            self.hideProgressActivity()
        }).disposed(by: disposeBag)
    }
    
    func fillData() {
        guard let meal = viewModel.meal else { return }
        
        self.imgMealBackdrop.downloadImageWithCaching(with: meal.thumbnail ?? "", placeholderImage: UIImage())
        
        self.lblMealName.text = meal.name
        
        btnPlay.isHidden = (meal.youtube == nil || meal.youtube == "")

        self.tblViewIngredientsHeight.constant = CGFloat(meal.ingredients.count) * 40.0
        self.tblViewIngredients.reloadData()
        
        self.viewModel.mealInstructions = formatBulletPoints()
        self.lblMealInstructions.text = self.viewModel.mealInstructions
        self.lblMealInstructions.appendReadmore(after: self.viewModel.mealInstructions, trailingContent: .readmore)
    }
    
    @objc func handleTap() {
        self.viewModel.isInstructionsExpanded.toggle()
        
        if self.viewModel.isInstructionsExpanded {
            self.lblMealInstructions.numberOfLines = 0
            self.lblMealInstructions.appendReadLess(after: self.viewModel.mealInstructions, trailingContent: .readless)
        } else {
            self.lblMealInstructions.numberOfLines = 2
            self.lblMealInstructions.appendReadmore(after: self.viewModel.mealInstructions, trailingContent: .readmore)
        }
    }
    
    func formatBulletPoints() -> String {
        guard let meal = viewModel.meal else { return "" }

        let steps = meal.instructions?.components(separatedBy: meal.instructions?.contains("\r\n\r\n") ?? false ? "\r\n\r\n" : "\r\n") ?? []
        return steps.enumerated().reduce("") { $0 + "\($1.offset + 1). \($1.element)\n\n" }
    }
    
    // MARK: - IBActions
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnOpenInYoutubeTapped(_ sender: UIButton) {
        
        guard let meal = viewModel.meal,
              let youtubeKey = getYoutubeId(youtubeUrl: meal.youtube ?? "") else { return }

        let vm = PlayVideoViewModel(youtubeKey: youtubeKey)
        let vc = UIStoryboard.main.playVideoViewController
        vc.viewModel = vm
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnShareTapped(_ sender: UIButton) {
        
        guard let meal = viewModel.meal,
              let text = meal.name,
              let youtubeURL = meal.youtube,
              let link = NSURL(string: youtubeURL) else { return }

        let objectsToShare: [Any] = [text, link]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource Methods
extension MealDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meal?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IngredientTableViewCell.self), for: indexPath) as? IngredientTableViewCell ?? IngredientTableViewCell()
        
        if let meal = viewModel.meal,
           let ingredient = meal.ingredients[indexPath.row],
           let measurement = meal.measurements[indexPath.row] {
            cell.configure(srNo: indexPath.row + 1, ingredient: ingredient, measurement: measurement)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
