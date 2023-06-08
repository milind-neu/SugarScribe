//
//  BaseResponse.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import Foundation

class BaseResponse {
    
    var status: Int = 0
    var success: Bool = false
    var message: String?
    
    init(response: [String: Any]?) {
        
        guard let response = response else {
            return
        }
                
        if let status = response["status"] as? Int {
            self.status = status
        }
        
        if let success = response["success"] as? Bool {
            self.success = success
        }

        if let message = response["message"] as? String {
            self.message = message
        }
    }
}
