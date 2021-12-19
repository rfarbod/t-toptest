//
//  UITableViewCell.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/19/21.
//


import UIKit

extension UITableViewCell {
    static func register(for tableView: UITableView)  {
        let cellName = String(describing: self)
        let cellIdentifier = cellName + "Identifier"
        let cellNib = UINib(nibName: String(describing: self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
}
