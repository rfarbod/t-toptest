//
//  BoxViewModel.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/19/21.
//

import Foundation
import Arrow

class BoxViewModel: NSObject {
    
    weak var cell:BoxTableViewCell!
    
    init(_ cell: BoxTableViewCell) {
        self.cell = cell
    }
    
    func addNewRow() {
        var lastId = Int()
        
        if let lastItem = cell.box.boxItems.last {
            lastId = lastItem.id
        }
        
        let boxItem = JBoxItem(id: lastId + 1, title: StringConstants.generateDropDownTitle(id: lastId + 1), boxOptions: ["فیلد متنی ۱", "فیلد متنی ۲"])
        cell.box.boxItems.append(boxItem)
        cell.configure(box: cell.box, isEdit: cell.isEdit)
                
        cell.addDelegate?.didAddNewRow(box: cell.box)
    }
    
    
}
