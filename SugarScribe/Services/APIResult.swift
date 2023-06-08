//
//  APIResult.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import Foundation

enum APIResult <Value> {
    case success(value: Value)
    case failure(error: APICallError)
    
}
