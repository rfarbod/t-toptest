//
//  JBoxItem.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/18/21.
//

import Foundation
import Arrow

struct JBox: ArrowParsable {
    
    var id:Int = 0
    var title = String()
    var boxItems = [JBoxItem]()
    
    mutating func deserialize(_ json: JSON) {
        id <-- json["id"]
        title <-- json["title"]
        boxItems <-- json["boxItems"]
    }

}
