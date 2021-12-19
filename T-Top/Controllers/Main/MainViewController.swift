//
//  ViewController.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/18/21.
//

import UIKit
enum MainModes{
    case editing
    case notEditing
}

class MainViewController: UIViewController {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var allItems = JBoxes()
    
    var boxItemsToRemove: [Int:[JBoxItem]] = [:]
    var boxesToRemove: [JBox] = []
    
    var currentMainMode = MainModes.notEditing
    
    lazy var  mainVM = MainViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mainVM.fetchBoxes()
    }
    
    private func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        BoxTableViewCell.register(for: tableView)
        NewBoxTableViewCell.register(for: tableView)
        
    }

    func updateViews(with boxes: JBoxes) {
        self.allItems = boxes
        tableView.reloadData()
    }
    
    
    @IBAction func didPressEdit(_ sender: UIButton) {
        if currentMainMode == .notEditing {
            currentMainMode = .editing
            sender.setTitle("تمام", for: .normal)
        }else{
            mainVM.removeSelectedThings()
            currentMainMode = .notEditing
            sender.setTitle("ویرایش", for: .normal)
        }
        tableView.reloadData()
    }
    
    func configureForMode(mode: MainModes) {
        switch mode {
        case .editing:
            editButton.setTitle("تمام", for: .normal)
        case .notEditing:
            editButton.setTitle("ویرایش", for: .normal)
        }
    }
    

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.boxes.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == allItems.boxes.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewBoxTableViewCellIdentifier", for: indexPath) as! NewBoxTableViewCell
            cell.selectionStyle = .none
            if currentMainMode == .editing{
                cell.backView.backgroundColor = .white
            } else {
                cell.backView.backgroundColor = .gray
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoxTableViewCellIdentifier", for: indexPath) as! BoxTableViewCell
        cell.configure(box: allItems.boxes[indexPath.row], isEdit: currentMainMode == .editing)
        cell.deleteDelegate = self
        cell.addDelegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == allItems.boxes.count{
            return SizeConstants.itemSize
        }
        let cellHeight = (allItems.boxes[indexPath.row].boxItems.count * Int(SizeConstants.itemSize)) + 125
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == allItems.boxes.count && currentMainMode != .editing {
            mainVM.addNewBox()
        }
    }
    
}

extension MainViewController: DeleteBoxDelegate{
    
    func didSelectBox(shouldRemove: Bool, box: JBox) {
        if shouldRemove{
            boxesToRemove.append(box)
        } else {
            boxesToRemove.removeAll(where: {$0.id == box.id})
        }
    }
    
    func didSelectItem(shouldRemove: Bool, box: JBox, items: [JBoxItem]) {
        if shouldRemove{
            boxItemsToRemove[box.id] = items
        } else {
            for itemToBeDeleted in items{
                boxItemsToRemove[box.id]?.removeAll(where: {$0.id == itemToBeDeleted.id})
            }
        }
    }
}

extension MainViewController: AddBoxDelegate{
    func didAddNewRow(box: JBox) {
        
        for index in 0..<allItems.boxes.count{
            if allItems.boxes[index].id == box.id{
                allItems.boxes[index] = box
            }
        }

        mainVM.updateBoxes(allItems: allItems)

        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
