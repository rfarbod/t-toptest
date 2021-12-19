//
//  JBoxes.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/18/21.
//

import Foundation
import Arrow

struct JBoxes: ArrowParsable {
    var boxes = [JBox]()
    mutating func deserialize(_ json: JSON) {
        boxes <-- json["boxes"]
    }
    
}
