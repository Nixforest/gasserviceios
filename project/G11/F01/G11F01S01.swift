//
//  G11F01S01.swift
//  project
//
//  Created by Nix Nixforest on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G11F01S01: StepContent, UITextViewDelegate, UITextFieldDelegate {
    /** Selected value */
    static var _selectedValue: (title: String, content: String) = (DomainConst.BLANK, DomainConst.BLANK)
    /** Title textfield */
    var _tbxTitle = UITextField()
    /** Note textfield */
    var _tbxNote = UITextView()
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
        _tbxTitle.frame = CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                y: GlobalConst.MARGIN,
                                width: GlobalConst.EDITTEXT_W,
                                height: GlobalConst.EDITTEXT_H)
        _tbxTitle.font               = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxTitle.borderStyle        = .roundedRect
        _tbxTitle.autocorrectionType = .no
        _tbxTitle.clearButtonMode    = .whileEditing
        _tbxTitle.placeholder        = DomainConst.CONTENT00062
        _tbxTitle.translatesAutoresizingMaskIntoConstraints = true
        _tbxTitle.addTarget(self, action: #selector(textFieldTitleDidChange(_:)), for: .editingChanged)
        _tbxTitle.returnKeyType      = .next
        _tbxTitle.tag = 0
        _tbxTitle.autocapitalizationType = .sentences
        //_tbxName.becomeFirstResponder()
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN * 2
        contentView.addSubview(_tbxTitle)
        
        // Name textfield
        _tbxNote.frame = CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                y: offset,
                                width: GlobalConst.EDITTEXT_W,
                                height: GlobalConst.EDITTEXT_H * 5)
        _tbxNote.font               = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxNote.backgroundColor    = UIColor.white
        _tbxNote.autocorrectionType = .no
        _tbxNote.translatesAutoresizingMaskIntoConstraints = true
        _tbxNote.returnKeyType      = .done
        _tbxNote.tag                = 0
        CommonProcess.setBorder(view: _tbxNote, radius: 5.0, borderColor: GlobalConst.TEXTVIEW_BORDER_COLOR)
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_tbxNote)
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00431,
                   contentHeight: offset,
                   width: w, height: h)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.addGestureRecognizer(gesture)
        _tbxTitle.delegate   = self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle text field name did change event
     * - parameter textField: Textfield
     */
    func textFieldTitleDidChange(_ textField: UITextField) {
        G11F01S01._selectedValue.title = _tbxTitle.text!
        NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F02), object: nil)
    }
    
    /**
     * Handle when leave focus edittext
     * - parameter textField: Textfield is focusing
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //_tbxNote.becomeFirstResponder()
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
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        G11F01S01._selectedValue.title = _tbxTitle.text!
        G11F01S01._selectedValue.content = _tbxNote.text
        if G11F01S01._selectedValue.title.isEmpty || G11F01S01._selectedValue.content.isEmpty {
            self.getParentView().showAlert(message: DomainConst.CONTENT00431)
            return false
        } else {
            return true
        }
    }
    
    /**
     * Handle when finish change textview value
     */
    func textViewDidChange(_ textView: UITextView) {
        G11F01S01._selectedValue.content = textView.text
        NotificationCenter.default.post(name: Notification.Name(rawValue: G08Const.NOTIFY_NAME_SET_DATA_G08_F01), object: nil)
    }
    
    /**
     * Handle when focus edittext
     * - parameter textField: Textfield will be focusing
     */
    internal func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        if _isKeyboardShow == false {
            _isKeyboardShow = true
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
