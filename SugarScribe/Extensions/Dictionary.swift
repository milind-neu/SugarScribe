//
//  Dictionary.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import Foundation

extension Dictionary {
    
    var keysToCamelCase: Dictionary {
        
        let keys = Array(self.keys)
        let values = Array(self.values)
        var dict: Dictionary = [:]
        
        keys.enumerated().forEach { (index, key) in
            
            var value = values[index]
            var keyCamelCased: Key = key
            
            if let val = value as? Dictionary, let val1 = val.keysToCamelCase as? Value {
                value = val1
            }
            
            if let keyTemp = key as? String, let key1 = keyTemp.underscoreToCamelCase as? Key {
                keyCamelCased = key1
            }
            
            dict[keyCamelCased] = value
        }
        
        return dict
    }
}
