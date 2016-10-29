//
//  G01F02S05.swift
//  project
//
//  Created by Nixforest on 10/29/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F02S05: StepContent, UITextViewDelegate {
    /** Selected value */
    static var _selectedValue: String = ""
    /** Name textfield */
    var _tbxName = UITextView()
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
    init(w: CGFloat, h: CGFloat) {
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
            height: GlobalConst.EDITTEXT_H * 5)
        _tbxName.font = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxName.backgroundColor = UIColor.lightGray
        _tbxName.autocorrectionType = .no
        _tbxName.translatesAutoresizingMaskIntoConstraints = true
        _tbxName.returnKeyType = .done
        _tbxName.tag = 0
        _tbxName.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        //_tbxName.mul
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_tbxName)
        
        self.setup(mainView: contentView, title: GlobalConst.CONTENT00188,
                   contentHeight: offset,
                   width: w, height: h)
        // Set data
        if !G01F02S05._selectedValue.isEmpty {
            _tbxName.text = G01F02S04._selectedValue.name
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.addGestureRecognizer(gesture)
        _tbxName.delegate = self
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        G01F02S05._selectedValue = textView.text
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
}
