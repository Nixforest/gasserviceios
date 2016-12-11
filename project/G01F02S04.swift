//
//  G01F02S04.swift
//  project
//
//  Created by Nixforest on 10/29/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F02S04: StepContent, UITextFieldDelegate {
    /** Selected value */
    static var _selectedValue: (name: String, phone: String) = ("", "")
    /** Name textfield */
    var _tbxName = UITextField()
    /** Phone textfield */
    var _tbxPhone = UITextField()
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
    init(w: CGFloat, h: CGFloat, parent: CommonViewController) {
        super.init()
        var offset: CGFloat = 0
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        //contentView.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        // Name textfield
        _tbxName.frame = CGRect(
            x: (w - GlobalConst.EDITTEXT_W) / 2,
            y: GlobalConst.MARGIN,
            width: GlobalConst.EDITTEXT_W,
            height: GlobalConst.EDITTEXT_H)
        _tbxName.font = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxName.borderStyle = .roundedRect
        _tbxName.autocorrectionType = .no
        _tbxName.clearButtonMode = .whileEditing
        
        _tbxName.placeholder = GlobalConst.CONTENT00055
        _tbxName.translatesAutoresizingMaskIntoConstraints = true
        _tbxName.addTarget(self, action: #selector(textFieldNameDidChange(_:)), for: .editingChanged)
        _tbxName.returnKeyType = .next
        _tbxName.tag = 0
        _tbxName.autocapitalizationType = .words
        if !G01F02S04._selectedValue.name.isEmpty {
            _tbxName.text = G01F02S04._selectedValue.name
        }
        //_tbxName.becomeFirstResponder()
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_tbxName)
        
        // Phone textfield
        _tbxPhone.frame = CGRect(
            x: (w - GlobalConst.EDITTEXT_W) / 2,
            y: GlobalConst.MARGIN + offset,
            width: GlobalConst.EDITTEXT_W,
            height: GlobalConst.EDITTEXT_H)
        _tbxPhone.font = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxPhone.borderStyle = .roundedRect
        _tbxPhone.keyboardType = .phonePad
        _tbxPhone.autocorrectionType = .no
        _tbxPhone.clearButtonMode = .whileEditing
        _tbxPhone.placeholder = GlobalConst.CONTENT00054
        _tbxPhone.translatesAutoresizingMaskIntoConstraints = true
        _tbxPhone.addTarget(self, action: #selector(textFieldPhoneDidChange(_:)), for: .editingChanged)
        _tbxPhone.returnKeyType = .done
        _tbxPhone.tag = 1
        if !G01F02S04._selectedValue.phone.isEmpty {
            _tbxPhone.text = G01F02S04._selectedValue.phone
        }
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_tbxPhone)
        
        // Set parent
        self._parent = parent
        self.setup(mainView: contentView, title: GlobalConst.CONTENT00187,
                   contentHeight: offset,
                   width: w, height: h)
        // Set data
        if !G01F02S04._selectedValue.name.isEmpty {
            _tbxName.text = G01F02S04._selectedValue.name
        }
        if !G01F02S04._selectedValue.phone.isEmpty {
            _tbxPhone.text = G01F02S04._selectedValue.phone
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.addGestureRecognizer(gesture)
        _tbxName.delegate = self
        _tbxPhone.delegate = self
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
        G01F02S04._selectedValue.name = _tbxName.text!
        NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_G01F02), object: nil)
    }
    /**
     * Handle text field phone did change event
     * - parameter textField: Textfield
     */
    func textFieldPhoneDidChange(_ textField: UITextField) {
        G01F02S04._selectedValue.phone = _tbxPhone.text!
        NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_G01F02), object: nil)
    }
    
    /**
     * Handle when leave focus edittext
     * - parameter textField: Textfield is focusing
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide keyboard
        //textField.resignFirstResponder()
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
     * Hide keyboard
     */
    func hideKeyboard() {
        self.endEditing(true)
        _isKeyboardShow = false
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
     * Hide keyboard
     * - parameter sender: Gesture
     */
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        hideKeyboard()
    }
    
    override func checkDone() -> Bool {
//        if G01F02S04._selectedValue.name.isEmpty || G01F02S04._selectedValue.phone.isEmpty {
//            self._parent?.showAlert(message: GlobalConst.CONTENT00187)
//            return false
//        } else {
//            return true
//        }
        return true
    }
}
