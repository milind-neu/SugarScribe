//
//  APIError.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import UIKit

class APICallError {
    
    var code: Int = -1
    var reason: String = String()
    var message: String = String()
    var callStatus: APICallStatus = .unknown
    
    init() {
        
    }
    
    init(code: Int, reason: String, message: String, callStatus: APICallStatus = .unknown) {
        self.code = code
        self.reason = reason
        self.message = message
        self.callStatus = callStatus
    }
    
    convenience init(status: APICallStatus) {
        switch status {
        case .success:
            self.init()
        case .failed, .unknown:
            self.init(code: 1111, reason: "Failure", message: "Something went wrong")
        }
    }
}

enum APICallStatus: Error {
    
    case success
    case failed
    case unknown
}
