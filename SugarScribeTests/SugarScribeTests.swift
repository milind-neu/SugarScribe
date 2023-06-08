//
//  SugarScribeTests.swift
//  SugarScribeTests
//
//  Created by Milind Sharma on 06/06/23.
//

import XCTest
@testable import SugarScribe

final class SugarScribeTests: XCTestCase {
    
    var apiClient: APIClient!
    
    override func setUp() {
        super.setUp()
        apiClient = APIClient.shared
        // Setup any additional dependencies or configurations
    }
    
    override func tearDown() {
        apiClient = nil
        super.tearDown()
    }
    
    func testJSONDecoding() {
        
        let json: [String: Any] =
        [
            "idMeal": "53049",
            "strMeal": "Apam balik",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
        ]
        
        // Provie any Codable struct
        if let mealData = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]) {
            
            let objMeal = try! JSONDecoder().decode(Meal.self, from: mealData)
            XCTAssertEqual(objMeal.name, "Apam balik")
        }
        

    }
    
    // Test fetching the list of meals in the Dessert category
    func testFetchDessertMeals() {
        let expectation = XCTestExpectation(description: "Fetch Dessert meals")
        
        apiClient.getMealList(category: "Dessert") { result in
            switch result {
            case .success(let response):
                let meals = response.meals
                XCTAssertFalse(meals.isEmpty, "Fetched dessert meals should not be empty")
                
            case .failure(let error):
                XCTFail("Fetching Dessert meals failed with error: \(error)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    // Test fetching meal details by ID
    func testFetchMealDetails() {
        let expectation = XCTestExpectation(description: "Fetch meal details")
        let mealID = "52917"
        
        apiClient.getMealDetail(mealId: mealID) { result in
            switch result {
            case .success(let mealDetails):
                XCTAssertNotNil(mealDetails.meal?.name, "Meal name should not be nil")
                XCTAssertNotNil(mealDetails.meal?.instructions, "Meal instructions should not be nil")
                XCTAssertFalse(mealDetails.meal?.ingredients.count == 0, "Meal ingredients should not be empty")
                XCTAssertFalse(mealDetails.meal?.measurements.count == 0, "Meal measurements should not be empty")
                XCTAssertFalse(mealDetails.meal?.ingredients.count != mealDetails.meal?.measurements.count, "Meal ingredients and measurements count should be equal")
            case .failure(let error):
                XCTFail("Fetching meal details failed with error: \(error)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetYoutubeId() {
        let youtubeUrl = "https://www.youtube.com/watch?v=abcdefghijk"
        let expectedId = "abcdefghijk"
        
        let result = getYoutubeId(youtubeUrl: youtubeUrl)
        
        XCTAssertEqual(result, expectedId, "YouTube ID should match the expected value")
    }
    
    func testGetYoutubeId_InvalidUrl() {
        let youtubeUrl = "https://www.example.com"
        
        let result = getYoutubeId(youtubeUrl: youtubeUrl)
        
        XCTAssertNil(result, "Invalid YouTube URL should return nil")
    }
    
    func testGetYoutubeId_EmptyUrl() {
        let youtubeUrl = ""
        
        let result = getYoutubeId(youtubeUrl: youtubeUrl)
        
        XCTAssertNil(result, "Empty YouTube URL should return nil")
    }

}
