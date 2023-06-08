//
//  MealListViewModel.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import Foundation
import RxSwift

final class MealListViewModel: BaseViewModel {
        
    // MARK: - Variables
    var arrMeals: [Meal] = []    
    var mealListAPIResponse = PublishSubject<Bool>()
    var isSearching: Bool = false
    var filteredMeals: [Meal] = []   

    // MARK: - Initialization
    override init() {
        super.init()
    }
    
    // MARK: - API Call
    func callGetMealListAPI() {
        APIClient.shared.getMealList(category: "Dessert") { result in
            switch result {
            case .success(let response):
                self.arrMeals = response.meals
                self.filteredMeals = response.meals
                self.mealListAPIResponse.onNext(true)
            case .failure(let error):
                print(error)
                self.mealListAPIResponse.onNext(false)
            }
        }
    }
}
