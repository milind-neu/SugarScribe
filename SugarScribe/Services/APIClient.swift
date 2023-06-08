//
//  APIClient.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import Alamofire
import Foundation
import CoreServices

class APIClient {
    
    static let shared: APIClient = {
        let instance = APIClient()
        return instance
    }()
    
    init() {
        
    }
}

extension APIClient {
    
    internal static func callAPI(urlRequest: URLRequestConvertible, completionHandler:@escaping ( _ success: Bool, _ resultVal: [String: Any]) -> Void) {
        AF.request(urlRequest)
            .responseJSON { response in
                switch response.result {
                case .success(let value):

                    guard let json = value as? [String: Any] else { return }
                    completionHandler(true, json.keysToCamelCase)
                case .failure(let error):
                    let errorDict: [String: Any] = [
                        "code": error.responseCode ?? -1,
                        "description": error.localizedDescription
                    ]
                    completionHandler(false, errorDict)
                }
            }
    }
}

extension APIClient {
    
    func getMealList(category: String, completionHandler:@escaping (APIResult<MealListResponse>) -> Void) {

        APIClient.callAPI(urlRequest: APIRouter.getMeals(category: category)) { isSuccess, response in
            let apiResponse = MealListResponse(response: response)

            if isSuccess {
                completionHandler(APIResult.success(value: apiResponse))
            } else {
                completionHandler(APIResult.failure(error: APICallError(status: .unknown)))
            }
        }
    }

    func getMealDetail(mealId: String, completionHandler:@escaping (APIResult<MealDetailResponse>) -> Void) {

        APIClient.callAPI(urlRequest: APIRouter.getMealDetails(mealId: mealId)) { isSuccess, response in
            let apiResponse = MealDetailResponse(response: response)

            if isSuccess {
                completionHandler(APIResult.success(value: apiResponse))
            } else {
                completionHandler(APIResult.failure(error: APICallError(status: .unknown)))
            }
        }
    }
}
