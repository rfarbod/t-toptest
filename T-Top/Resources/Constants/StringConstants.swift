//
//  StringConstants.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/19/21.
//

import Foundation
import Arrow

struct StringConstants {
    
    static var boxJSON = """
    {
        "boxes": [
            {
                "id": 0,
                "title": "عنوان باکس اول",
                "boxItems": [
                    {
                        "id": 0,
                        "title": "دراپ داون ۱",
                        "boxOptions": [
                            "فیلد متنی ۱",
                            "فیلد متنی ۲"
                        ]
                    },
                    {
                        "id": 1,
                        "title": "دراپ داون ۲",
                        "boxOptions": [
                            "فیلد متنی ۱",
                            "فیلد متنی ۲"
                        ]
                    }
                ]
            }
        ]
    }

    """
    
    static func generateDropDownTitle(id: Int) -> String {
        return "دراپ داون \(id + 1)".convertNumberToPersian()
    }
    
    static func generateBoxTitle(id: Int) -> String{
        return "عنوان باکس \(id + 1)".convertNumberToPersian()
    }
}
