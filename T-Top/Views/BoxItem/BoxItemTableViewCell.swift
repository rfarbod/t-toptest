//
//  BoxItemTableViewCell.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/18/21.
//

import UIKit

class BoxItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dropDownView: DropDownView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
