//
//  String.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/19/21.
//

import Foundation
extension String {
    /// Convert English number string to persian
    func convertNumberToPersian() -> String {
        
        let numbersDictionary: Dictionary = ["0": "۰", "1": "۱", "2": "۲", "3": "۳", "4": "۴", "5": "۵", "6": "۶", "7": "۷", "8": "۸", "9": "۹"]
        var str: String = self
        
        for (key, value) in numbersDictionary {
            str = str.replacingOccurrences(of: key, with: value)
        }
        
        return str
    }
    
    /// Convert English number string to persian
    func convertNumberToEnglish() -> String {
        
        let numbersDictionary: Dictionary = ["۰": "0", "۱": "1", "۲": "2", "۳": "3", "۴": "4", "۵": "5", "۶": "6", "۷": "7", "۸": "8", "۹": "9"]
        var str: String = self
        
        for (key, value) in numbersDictionary {
            str = str.replacingOccurrences(of: key, with: value)
        }
        
        return str
    }
    
}
