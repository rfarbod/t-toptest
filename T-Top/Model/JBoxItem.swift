//
//  JBoxItem.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/18/21.
//

import Foundation
import Arrow

struct JBoxItem: ArrowParsable {
    var id = Int()
    var title = String()
    var boxOptions = [String]()
    
    mutating func deserialize(_ json: JSON) {
        id <-- json["id"]
        title <-- json["title"]
        boxOptions <-- json["boxOptions"]
    }
}
