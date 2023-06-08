//
//  Environment.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import Foundation

final class Environment {

    class func APIBasePath() -> String {
        return "https://themealdb.com/api/json/"
    }
    
    class func APIVersionPath() -> String {
        return "v1/"
    }
    
    class func APIKey() -> String {
        return "1"
    }
}
