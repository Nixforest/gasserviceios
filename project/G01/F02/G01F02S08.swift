//
//  G01F02S08.swift
//  project
//
//  Created by SPJ on 12/28/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F02S08: StepContent {
    /** Selected value */
    static var _selectedValue: String = DomainConst.BLANK
    /** Code textfield */
    var _codeName = UITextField()
    /**
     * Default initializer.
     */
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        var offset: CGFloat = 0
        let contentView     = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        // Name textfield
        _codeName.frame = CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                y: GlobalConst.MARGIN,
                                width: GlobalConst.EDITTEXT_W,
                                height: GlobalConst.EDITTEXT_H)
        _codeName.font               = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _codeName.borderStyle        = .roundedRect
        _codeName.autocorrectionType = .no
        _codeName.clearButtonMode    = .whileEditing
        _codeName.placeholder        = DomainConst.CONTENT00554
        _codeName.translatesAutoresizingMaskIntoConstraints = true
        _codeName.addTarget(self, action: #selector(textFieldNameDidChange(_:)), for: .editingChanged)
        _codeName.returnKeyType      = .next
        _codeName.tag = 0
        _codeName.autocapitalizationType = .words
        if !G01F02S08._selectedValue.isEmpty {
            _codeName.text = G01F02S08._selectedValue
        }
        //_tbxName.becomeFirstResponder()
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_codeName)
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00553,
                   contentHeight: offset,
                   width: w, height: h)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.addGestureRecognizer(gesture)
        _codeName.delegate   = self
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        self.endEditing(true)
    }
    
    /**
     * Hide keyboard
     * - parameter sender: Gesture
     */
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        hideKeyboard()
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        //        if G01F02S04._selectedValue.name.isEmpty || G01F02S04._selectedValue.phone.isEmpty {
        //            self._parent?.showAlert(message: DomainConst.CONTENT00187)
        //            return false
        //        } else {
        //            return true
        //        }
        return true
    }
    
    /**
     * Handle text field name did change event
     * - parameter textField: Textfield
     */
    func textFieldNameDidChange(_ textField: UITextField) {
        G01F02S08._selectedValue = textField.text!
        NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F02), object: nil)
    }

}
extension G01F02S08: UITextFieldDelegate {
    
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
            self.stepDoneDelegate?.stepDone()
        }
        return true
    }    
}
