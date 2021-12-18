//
//  DropDownView.swift
//  T-Top
//
//  Created by Farbod Rahiminik on 12/18/21.
//

import UIKit
import Spring

@IBDesignable
class DropDownView: UIView {

    @IBOutlet var dropDownView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBInspectable var dropDownTitle: String? = nil {
        didSet {
            titleLabel.text = dropDownTitle
        }
    }
    
    override var canBecomeFirstResponder: Bool{return true}
    override var canResignFirstResponder: Bool{return true}
    
    var _inputView: UIView?
    
    
     //MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var inputView: UIView? {
          set { _inputView = newValue }
          get { return _inputView }
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
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

