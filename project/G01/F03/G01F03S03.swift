//
//  G01F03S03.swift
//  project
//
//  Created by Nixforest on 11/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

class G01F03S03: StepContent, UITextViewDelegate {
    /** Selected value */
    static var _selectedValue: String = ""
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
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        //contentView.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        // Name textfield
        _tbxNote.frame = CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                y: GlobalConst.MARGIN,
                                width: GlobalConst.EDITTEXT_W,
                                height: GlobalConst.EDITTEXT_H * 5)
        _tbxNote.font               = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxNote.backgroundColor    = UIColor.white
        _tbxNote.autocorrectionType = .no
        _tbxNote.translatesAutoresizingMaskIntoConstraints = true
        _tbxNote.returnKeyType      = .done
        _tbxNote.tag                = 0
        _tbxNote.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        CommonProcess.setBorder(view: _tbxNote)
        //_tbxNote.becomeFirstResponder()
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_tbxNote)
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00208,
                   contentHeight: offset,
                   width: w, height: h)
        // Set data
        if !G01F03S03._selectedValue.isEmpty {
            _tbxNote.text = G01F03S03._selectedValue
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.addGestureRecognizer(gesture)
        _tbxNote.delegate = self
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle did change text view
     * - parameter textView: Text view to handle event
     */
    func textViewDidChange(_ textView: UITextView) {
        G01F03S03._selectedValue = textView.text
        NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F03), object: nil)
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
    internal func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        if _isKeyboardShow == false {
            _isKeyboardShow = true
        }
        return true
    }
    
    /**
     * Handle should end editing text view
     * - parameter textView: Text view to handle event
     */
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
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
        return true
    }
}
