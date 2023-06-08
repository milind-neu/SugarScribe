//
//  MealDetailViewModel.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import Foundation
import RxSwift

final class MealDetailViewModel: BaseViewModel {
        
    // MARK: - Variables
    var meal: Meal?
    var mealId: String = ""
    var mealInstructions: String = ""
    var isInstructionsExpanded = false
    var mealDetailAPIResponse = PublishSubject<Bool>()

    // MARK: - Initialization
    init(mealId: String) {
        super.init()
        self.mealId = mealId
    }
    
    // MARK: - API Call
    func callGetMealDetailAPI() {
        APIClient.shared.getMealDetail(mealId: self.mealId) { result in
            switch result {
            case .success(let response):
                self.meal = response.meal
                self.mealDetailAPIResponse.onNext(true)
            case .failure(let error):
                print(error)
                self.mealDetailAPIResponse.onNext(false)
            }
        }
    }
}
