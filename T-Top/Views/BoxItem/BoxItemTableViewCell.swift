//
//  BoxItemTableViewCell.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/18/21.
//

import UIKit
protocol BoxItemDelegate {
    func didSelectItem(shouldRemove: Bool, item: JBoxItem)
    func isPossibleToSelect() -> Bool
}
class BoxItemTableViewCell: UITableViewCell {

    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dropDownView: DropDownView!
    @IBOutlet weak var checkBoxWidthConstraint: NSLayoutConstraint!
    
    var delegate: BoxItemDelegate? = nil
    var boxItem: JBoxItem = JBoxItem()
//    var boxId: Int = 0
    var box: JBox = JBox()
    var isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    
    func configure(boxItem: JBoxItem, box: JBox, isEdit: Bool) {
        
        
        checkmarkButton.setImage(UIImage(named: "squareCheck"), for: .normal)
        isChecked = false
        delegate?.didSelectItem(shouldRemove: isChecked, item: boxItem)

        if isEdit{
            checkBoxWidthConstraint.constant = 25
        } else {
            checkBoxWidthConstraint.constant = 0
        }
        self.boxItem = boxItem
        self.box = box
        dropDownView.configure(with: boxItem, delegate: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func didPressCheckMark(_ sender: UIButton) {
        
        if delegate?.isPossibleToSelect() ?? true{
            if isChecked{
                checkmarkButton.setImage(UIImage(named: "squareCheck"), for: .normal)
                isChecked = false
            } else {
                checkmarkButton.setImage(UIImage(named: "squareCheckFill"), for: .normal)
                isChecked = true
            }
            delegate?.didSelectItem(shouldRemove: isChecked, item: boxItem)
        }
    }
}

extension BoxItemTableViewCell: DropDownDelegate {
    
    func didSelectItem(boxOption: String) {
        titleLabel.text = boxOption
    }
    
    
}
