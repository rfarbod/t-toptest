//
//  BoxTableViewCell.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/18/21.
//

import UIKit
import Spring

protocol AddBoxDelegate {
    func didAddNewRow(box: JBox)
}
protocol DeleteBoxDelegate{
    func didSelectBox(shouldRemove: Bool, box:JBox)
    func didSelectItem(shouldRemove: Bool, box:JBox, items: [JBoxItem])
}

class BoxTableViewCell: UITableViewCell {

    @IBOutlet weak var addNewButton: DesignableButton!
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var boxTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkBoxWidthConstraint: NSLayoutConstraint!
    
    var box = JBox()
    lazy var boxCellVM = BoxViewModel(self)
    var addDelegate:AddBoxDelegate? = nil
    var deleteDelegate:DeleteBoxDelegate? = nil

    var isEdit = false
    var isChecked = false
    var checkedItems = [JBoxItem]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
        let checkBoxTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))
        checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(checkBoxTapGesture)
        BoxItemTableViewCell.register(for: tableView)
        // Initialization code
    }

    func configure(box: JBox, isEdit: Bool) {
        isChecked = false
        checkBox.image = UIImage(named: "squareCheck")
        deleteDelegate?.didSelectBox(shouldRemove: false, box: box)
        
        if isEdit{
            checkBoxWidthConstraint.constant = 25
            addNewButton.backgroundColor = .systemGray6
            addNewButton.isEnabled = false
        } else {
            checkBoxWidthConstraint.constant = 0
            addNewButton.backgroundColor = .systemBlue
            addNewButton.isEnabled = true
        }
        self.isEdit = isEdit
        self.box = box
        boxTitleLabel.text = box.title
        tableView.reloadData()
        tableViewHeightConstraint.constant = CGFloat(box.boxItems.count) * SizeConstants.itemSize
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   
        // Configure the view for the selected state
    }
    
    @IBAction func didPressNewRow(_ sender: UIButton) {
        boxCellVM.addNewRow()
    }
    
    @objc func didTapCheckBox() {
        
        if isChecked{
            checkBox.image = UIImage(named: "squareCheck")
            isChecked = false
            deleteDelegate?.didSelectBox(shouldRemove: false, box: box)
        } else {
            deleteDelegate?.didSelectItem(shouldRemove: false, box: box, items: checkedItems)
            checkedItems = []
            checkBox.image = UIImage(named: "squareCheckFill")
            isChecked = true
            deleteDelegate?.didSelectBox(shouldRemove: true, box: box)
        }
    }
    
}

extension BoxTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SizeConstants.itemSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoxItemTableViewCellIdentifier", for: indexPath) as! BoxItemTableViewCell
        cell.configure(boxItem: box.boxItems[indexPath.row], box: box, isEdit: isEdit)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return box.boxItems.count
    }    
    
}

extension BoxTableViewCell: BoxItemDelegate {
    
    func didSelectItem(shouldRemove: Bool, item: JBoxItem) {
        
        if shouldRemove{
            checkedItems.append(item)
        } else {
            checkedItems.removeAll(where: {$0.id == item.id})
        }
        deleteDelegate?.didSelectItem(shouldRemove: true, box: box, items: checkedItems)
    }
    
    func isPossibleToSelect() -> Bool {
        return !isChecked
    }
}
