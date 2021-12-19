//
//  DropDownView.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/18/21.
//

import UIKit
import Spring

protocol DropDownDelegate {
    func didSelectItem(boxOption: String)
}

@IBDesignable
class DropDownView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet var dropDownView: UIView!
    
    @IBInspectable var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    override var canBecomeFirstResponder: Bool{return true}
    override var canResignFirstResponder: Bool{return true}
    
    var _inputView: UIView?
    var picker = UIPickerView()
    var boxOptions = [String]()
    
    var dropDownDelegate: DropDownDelegate? = nil
    
    //MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        nibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nibSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        nibSetup()
        dropDownView?.prepareForInterfaceBuilder()
    }
    
    //MARK:- Lifecycle methods
    private func nibSetup() {
        
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        dropDownView = view
    }

    func loadViewFromNib() -> UIView? {
        
        let nibName = String(describing: DropDownView.self)
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        titleLabel.text = title
    }
    
    private func setupViews() {
        picker.delegate = self
        picker.dataSource = self
        inputView = picker
        
        let dropDownTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDropDown))
        self.isUserInteractionEnabled = true
        self.dropDownView.isUserInteractionEnabled = true
        self.dropDownView.addGestureRecognizer(dropDownTapGesture)
    }
    
    func configure(with boxItem: JBoxItem, delegate: DropDownDelegate) {
        self.dropDownDelegate = delegate
        self.boxOptions = boxItem.boxOptions
        self.title = boxItem.title
        picker.reloadAllComponents()
    }
    
    @objc func didTapDropDown() {
        becomeFirstResponder()
    }
    
    override var inputView: UIView? {
          set { _inputView = newValue }
          get { return _inputView }
    }
    
}

extension DropDownView: UIKeyInput {
    var hasText: Bool {
        false
    }
    
    func insertText(_ text: String) {
        
    }
    
    func deleteBackward() {
        
    }
}

extension DropDownView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return boxOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return boxOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        dropDownDelegate?.didSelectItem(boxOption: boxOptions[row])
        resignFirstResponder()
    }
    
    
}

