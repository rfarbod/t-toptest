//
//  MainViewModel.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/18/21.
//

import Foundation
import Arrow

class MainViewModel: NSObject {

    weak var vc:MainViewController!
    
    init(_ vc:MainViewController) {
        self.vc = vc
    }
    
    func addNewBox(){
        let id = vc.allItems.boxes.count
        let newBox = JBox(id: id,
             title: StringConstants.generateBoxTitle(id: id),
             boxItems: [JBoxItem(id: 0,
                                 title: StringConstants.generateDropDownTitle(id: 0),
                                 boxOptions: ["فیلد متنی ۱","فیلد متنی ۲"])])
        vc.allItems.boxes.append(newBox)
        updateBoxes(allItems: vc.allItems)
        vc.updateViews(with: vc.allItems)
    }
    
    func fetchBoxes() {
        
        let json = StringConstants.boxJSON
        if  let jsonObj = JSON(json) {
            var allItems = JBoxes()
            allItems.deserialize(jsonObj)
            print(allItems)
            vc.updateViews(with: allItems)
        }
        
    }
    
    func updateBoxes(allItems: JBoxes){
        //json ro update
        if let json = JSON(allItems) {
        StringConstants.boxJSON = "\(json)"
        }
    }
    
    func removeSelectedThings() {
        for box in vc.boxesToRemove{
            vc.allItems.boxes.removeAll(where: {$0.id == box.id})
        }
        
        
        for id in vc.boxItemsToRemove.keys{
            for boxIndex in 0..<vc.allItems.boxes.count{
                let box = vc.allItems.boxes[boxIndex]
                if box.id == id {
                    let itemsToBeDeleted = vc.boxItemsToRemove[id]!
                    for itemToBeDeleted in itemsToBeDeleted{
                        if let json = JSON(vc.allItems){
                            StringConstants.boxJSON = "\(json)"
                        }
                        vc.allItems.boxes[boxIndex].boxItems.removeAll(where: {$0.id == itemToBeDeleted.id})
                    }
                }
            }
        }
        
        
        
    }

}
