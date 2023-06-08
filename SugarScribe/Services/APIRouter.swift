//
//  APIRouter.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import Alamofire
import Foundation
import CoreServices

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
}

enum APIRouter: URLRequestConvertible {
    
    case getMeals(category: String)
    case getMealDetails(mealId: String)
    
    // MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
            
        case .getMeals, .getMealDetails:
            return .get
            
        }
    }
    
    // MARK: Path
    var path: String {
        switch self {
        case .getMeals(let mealCategory):
            return "/filter.php?c=\(mealCategory)"
            
        case .getMealDetails(let mealId):
            return "/lookup.php?i=\(mealId)"
            
        }
    }
    
    // MARK: Parameters
    var parameters: Parameters? {
        
        switch self {
        case .getMeals, .getMealDetails:
            return [:]
        }
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let url: String = {
            return Environment.APIBasePath()
        }()
        
        let apiVersion: String? = {
            return Environment.APIVersionPath()
        }()
        
        let apiKey: String? = {
            return Environment.APIKey()
        }()
        
        var urlWithAPIVersion = url
        
        if let apiVersion = apiVersion {
            urlWithAPIVersion += apiVersion
        }
        
        if let apiKey = apiKey {
            urlWithAPIVersion += apiKey
        }
        
        let urlWithVersion = URL(string: urlWithAPIVersion)!
        var urlRequest = URLRequest(url: urlWithVersion.appendingPathComponent(path))
        
        urlRequest.url = try urlRequest.url?.absoluteString.removingPercentEncoding?.asURL()
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
                
        if (method != .get) {
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
        } else {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
