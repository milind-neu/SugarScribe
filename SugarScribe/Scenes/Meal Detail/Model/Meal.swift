//
//  Meal.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import Foundation

struct Meal: Decodable {
    
    let id: String?
    let name: String?
    let drinkAlternate: String?
    let category: String?
    let area: String?
    let instructions: String?
    let thumbnail: String?
    let tags: String?
    let youtube: String?
    let source: String?
    let imageSource: String?
    let creativeCommonsConfirmed: String?

    let ingredients: [String?]
    let measurements: [String?]
    
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String

        init(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "idMeal"))
        name = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strMeal"))
        drinkAlternate = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strDrinkAlternate"))
        category = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strCategory"))
        area = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strArea"))
        instructions = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strInstructions"))
        thumbnail = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strMealThumb"))
        tags = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strTags"))
        youtube = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strYoutube"))
        source = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strSource"))
        imageSource = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strImageSource"))
        creativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strCreativeCommonsConfirmed"))
        
        // Extracting ingredients and measurements from the coding keys dynamically
        var decodedIngredients: [String?] = []
        var decodedMeasurements: [String?] = []

        for index in 1...20 {
            
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(index)")
            let measurementKey = DynamicCodingKeys(stringValue: "strMeasure\(index)")
            
            if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
               let measurement = try container.decodeIfPresent(String.self, forKey: measurementKey),
               ingredient.count > 0, measurement.count > 0 {
                
                // Addind ingredient to decodedIngredients and measurement to decodedMeasurements when the count of characters in ingredient and measurement are greater than 0
                decodedIngredients.append(ingredient)
                decodedMeasurements.append(measurement)
            }
        }

        ingredients = decodedIngredients
        measurements = decodedMeasurements

    }
}
