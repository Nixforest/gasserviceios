//
//  G09F01S03.swift
//  project
//
//  Created by SPJ on 5/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G09F01S03: StepContent, UITextFieldDelegate {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: String = DomainConst.BLANK
    /** Textfield */
    private var _txtNew:                   UITextField = UITextField()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    /**
     * Default initializer.
     */
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        var offset: CGFloat = GlobalConst.MARGIN
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        // New phone number input
        _txtNew.frame = CGRect(x: (w - GlobalConst.BUTTON_W) / 2,
                               y: offset,
                               width: GlobalConst.BUTTON_W,
                               height: GlobalConst.EDITTEXT_H)
        _txtNew.font = UIFont.boldSystemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
        _txtNew.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        _txtNew.placeholder = DomainConst.CONTENT00394
        _txtNew.textAlignment = .center
        _txtNew.layer.borderWidth = 1
        _txtNew.layer.borderColor = GlobalConst.MAIN_COLOR.cgColor
        _txtNew.textColor = GlobalConst.MAIN_COLOR
        _txtNew.returnKeyType = .default
        _txtNew.keyboardType = .numberPad
        _txtNew.delegate       = self
        _txtNew.clearButtonMode = .whileEditing
        if !G09F01S03._selectedValue.isBlank {
            _txtNew.text = G09F01S03._selectedValue
        }
        contentView.addSubview(_txtNew)
        offset = offset + _txtNew.frame.height
        
        // Set parent
        self.setParentView(parent: parent)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00395,
                   contentHeight: offset,
                   width: w, height: h)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
     * Tells the delegate that editing stopped for the specified text field.
     */
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
            G09F01S03._selectedValue = textField.text!
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addDoneButtonOnKeyboard()
    }
    
    /**
     * Add a done button when keyboard show
     */
    func addDoneButtonOnKeyboard() {
        // Create toolbar
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(hideKeyboard(_:)))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        // Add toolbar to keyboard
        self._txtNew.inputAccessoryView = doneToolbar
        self.getParentView().keyboardTopY -= doneToolbar.frame.height
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard(_ sender: AnyObject) {
        // Hide keyboard
        self.getParentView().view.endEditing(true)
        self.stepDoneDelegate?.stepDone()
    }
}
