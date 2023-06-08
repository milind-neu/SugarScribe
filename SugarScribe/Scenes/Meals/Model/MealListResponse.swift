//
//  MealListResponse.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import UIKit

class MealListResponse: BaseResponse {
    
    var meals: [Meal] = []
    
    override init(response: [String: Any]?) {
        super.init(response: response)
        
        guard let response = response else {
            return
        }
        
        // Extract meal array from response
        if let mealArray = response["meals"] as? [[String: Any]] {
            for mealDict in mealArray {
                // Transform dictionary keys to camel case and serialize it to data
                if let mealData = try? JSONSerialization.data(withJSONObject: mealDict.keysToCamelCase, options: [.prettyPrinted]) {
                    do {
                        // Decode meal object from the data
                        if let objMeal = try? JSONDecoder().decode(Meal.self, from: mealData) {
                            // Append the decoded meal object to the array when both name and thumbnail contains a value
                            meals.append(objMeal)
                        }
                    }
                }
            }
        }
    }
}
