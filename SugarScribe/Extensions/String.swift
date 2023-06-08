//
//  String.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import Foundation

extension String {
    
    var underscoreToCamelCase: String {
        
        let underscore = CharacterSet(charactersIn: "_")
        var items: [String] = self.components(separatedBy: underscore)
        
        var start: String = (items.first ?? "")
        let first = String(start.prefix(1)).lowercased()
        let other = String(start.dropFirst())
        start = first + other
        
        items.remove(at: 0)
        
        let camelCased: String = items.reduce(start) { (result, identi) -> String in
            result + identi.capitalized
        }
        
        return camelCased
    }

}

extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var removeWhiteSpaces: String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
