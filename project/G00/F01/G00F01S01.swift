//
//  G00AccountS01.swift
//  project
//
//  Created by SPJ on 6/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00F01S01: StepContent, UITextFieldDelegate {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: (name: String, email: String) = ("", "")
    /** Name textfield */
    var _tbxName = UITextField()
    /** Email textfield */
    var _tbxEmail = UITextField()
    /** Flag show keyboard */
    var _isKeyboardShow: Bool = false

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
        var offset: CGFloat = 0
        let contentView     = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        // Name textfield
        _tbxName.frame = CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                y: GlobalConst.MARGIN,
                                width: GlobalConst.EDITTEXT_W,
                                height: GlobalConst.EDITTEXT_H)
        _tbxName.font               = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxName.borderStyle        = .roundedRect
        _tbxName.autocorrectionType = .no
        _tbxName.clearButtonMode    = .whileEditing
        _tbxName.placeholder        = DomainConst.CONTENT00055
        _tbxName.translatesAutoresizingMaskIntoConstraints = true
        _tbxName.addTarget(self, action: #selector(textFieldNameDidChange(_:)), for: .editingChanged)
        _tbxName.returnKeyType      = .next
        _tbxName.tag = 0
        _tbxName.autocapitalizationType = .words
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_tbxName)
        
        // Email textfield
        _tbxEmail.frame = CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                 y: GlobalConst.MARGIN + offset,
                                 width: GlobalConst.EDITTEXT_W,
                                 height: GlobalConst.EDITTEXT_H)
        _tbxEmail.font                  = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxEmail.borderStyle           = .roundedRect
        _tbxEmail.keyboardType          = .emailAddress
        _tbxEmail.autocorrectionType    = .no
        _tbxEmail.clearButtonMode       = .whileEditing
        _tbxEmail.placeholder           = DomainConst.CONTENT00443
        _tbxEmail.translatesAutoresizingMaskIntoConstraints = true
        _tbxEmail.addTarget(self, action: #selector(textFieldEmailDidChange(_:)), for: .editingChanged)
        _tbxEmail.returnKeyType         = .done
        _tbxEmail.tag = 1
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_tbxEmail)
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00100,
                   contentHeight: offset,
                   width: w, height: h)
        // Set data
        if !G00F01S01._selectedValue.name.isBlank {
            _tbxName.text = G00F01S01._selectedValue.name
        }
        if !G00F01S01._selectedValue.email.isBlank {
            _tbxEmail.text = G00F01S01._selectedValue.email
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.addGestureRecognizer(gesture)
        _tbxName.delegate   = self
        _tbxEmail.delegate  = self
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle text field name did change event
     * - parameter textField: Textfield
     */
    func textFieldNameDidChange(_ textField: UITextField) {
        G00F01S01._selectedValue.name = _tbxName.text!
    }
    
    /**
     * Handle text field email did change event
     * - parameter textField: Textfield
     */
    func textFieldEmailDidChange(_ textField: UITextField) {
        G00F01S01._selectedValue.email = _tbxEmail.text!
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        self.endEditing(true)
        _isKeyboardShow = false
    }
    
    /**
     * Hide keyboard
     * - parameter sender: Gesture
     */
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        hideKeyboard()
    }
    
    /**
     * Handle when leave focus edittext
     * - parameter textField: Textfield is focusing
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder!
        
        if (nextResponder != nil){
            // Found next responder, so set it.
            nextResponder?.becomeFirstResponder()
        }
        else
        {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
            hideKeyboard()
        }
        return true
    }
    
    /**
     * Handle when focus edittext
     * - parameter textField: Textfield will be focusing
     */
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        if _isKeyboardShow == false {
            _isKeyboardShow = true
        }
        return true
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        return true
    }
}
