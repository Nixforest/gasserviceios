//
//  G05F03S04.swift
//  project
//
//  Created by SPJ on 5/19/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F03S04: StepContent, UITextFieldDelegate {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: String = DomainConst.BLANK
    /** List of button */
    var _listButton = [UIButton]()
    /** Textfield */
    private var _txtNew:                   UITextField = UITextField()
    var contentView = UIView()

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
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        // Add button
        if getPhoneList().count > 0 {
            for i in 0..<getPhoneList().count {
                let button      = UIButton()
                button.frame    = CGRect(x: (w - GlobalConst.BUTTON_W) / 2,
                                         y: GlobalConst.MARGIN + (CGFloat)(i) * (GlobalConst.BUTTON_H + GlobalConst.MARGIN),
                                         width: GlobalConst.BUTTON_W,
                                         height: GlobalConst.BUTTON_H)
                button.tag      = i
                button.titleLabel?.font     = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
                button.backgroundColor      = GlobalConst.BUTTON_COLOR_RED
                button.layer.cornerRadius   = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                button.setTitle(getPhoneList()[i], for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                button.translatesAutoresizingMaskIntoConstraints = true
                _listButton.append(button)
                contentView.addSubview(button)
                offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
            }
        }
        // New phone number input
        _txtNew.frame = CGRect(x: (w - GlobalConst.BUTTON_W) / 2,
                                y: offset,
                                width: GlobalConst.BUTTON_W,
                                height: GlobalConst.EDITTEXT_H)
        _txtNew.font = UIFont.boldSystemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
        _txtNew.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        _txtNew.placeholder = DomainConst.CONTENT00383
        _txtNew.textAlignment = .center
        _txtNew.layer.borderWidth = 1
        _txtNew.layer.borderColor = GlobalConst.MAIN_COLOR.cgColor
        _txtNew.textColor = GlobalConst.MAIN_COLOR
        _txtNew.returnKeyType = .default
        _txtNew.keyboardType = .numberPad
        _txtNew.delegate       = self
        contentView.addSubview(_txtNew)
        offset = offset + _txtNew.frame.height
        
        // Set parent
        self.setParentView(parent: parent)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00377,
                   contentHeight: offset,
                   width: w, height: h)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateData),
                                               name:NSNotification.Name(rawValue: G05Const.NOTIFY_NAME_UPDATE_DATA_G05_F03),
                                               object: nil)
        return
    }
    
    /**
     * Update data
     */
    func updateData() {
        var offset: CGFloat = GlobalConst.MARGIN
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        _listButton.removeAll()
        // Add button
        if getPhoneList().count > 0 {
            for i in 0..<getPhoneList().count {
                let button      = UIButton()
                button.frame    = CGRect(x: (self.frame.width - GlobalConst.BUTTON_W) / 2,
                                         y: GlobalConst.MARGIN + (CGFloat)(i) * (GlobalConst.BUTTON_H + GlobalConst.MARGIN),
                                         width: GlobalConst.BUTTON_W,
                                         height: GlobalConst.BUTTON_H)
                button.tag      = i
                button.titleLabel?.font     = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
                button.backgroundColor      = GlobalConst.BUTTON_COLOR_RED
                button.layer.cornerRadius   = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                button.setTitle(getPhoneList()[i], for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                button.translatesAutoresizingMaskIntoConstraints = true
                // Mark button
                //                if G05F03S03._selectedValue.agent_id == listAgent[i].info_agent.agent_id {
                //                    CommonProcess.markButton(button: button)
                //                }
                _listButton.append(button)
                contentView.addSubview(button)
                offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
            }
        }
        
        // New phone number input
        _txtNew.frame = CGRect(x: (self.frame.width - GlobalConst.BUTTON_W) / 2,
                               y: offset,
                               width: GlobalConst.BUTTON_W,
                               height: GlobalConst.EDITTEXT_H)
        _txtNew.font = GlobalConst.BASE_FONT
        _txtNew.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        _txtNew.placeholder = DomainConst.CONTENT00383
        _txtNew.textAlignment = .center
        _txtNew.layer.borderWidth = 1
        _txtNew.layer.borderColor = GlobalConst.MAIN_COLOR.cgColor
        _txtNew.textColor = GlobalConst.MAIN_COLOR
        _txtNew.returnKeyType = .done
        _txtNew.keyboardType = .numberPad
        contentView.addSubview(_txtNew)
        offset = offset + _txtNew.frame.height
        var flag = false
        // Select phone active
        if G05F03S01.keyword.isPhoneNumber() {
            for item in _listButton {
                CommonProcess.unMarkButton(button: item)
                if item.titleLabel?.text == G05F03S01.keyword {
                    CommonProcess.markButton(button: item)
                    flag = true
                    G05F03S04._selectedValue = (item.titleLabel?.text)!
                }
            }
            if !flag {
                _txtNew.text = G05F03S01.keyword
            }
        }
        
        // Update layout
        var mainViewHeight: CGFloat = 0
        if offset < (self.frame.height - self.getTitleHeight()) {
            mainViewHeight = self.frame.height - self.getTitleHeight()
        } else {
            mainViewHeight = offset
        }
        contentView.frame = CGRect(
            x: 0, y: 0,
            width: self.frame.width,
            height: mainViewHeight)
        self.getScrollView().contentSize = CGSize(
            width: contentView.frame.width,
            height: contentView.frame.height)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle save selected data.
     * Mark step done.
     */
    func btnTapped(_ sender: AnyObject) {
        // Un-mark selecting button
        if !G05F03S04._selectedValue.isEmpty {
            for button in self._listButton {
                if getPhoneList()[button.tag] == G05F03S04._selectedValue {
                    CommonProcess.unMarkButton(button: button)
                    break
                }
            }
        }
        
        // Set new selected value
        G05F03S04._selectedValue = getPhoneList()[sender.tag]
        // Mark selecting button
        CommonProcess.markButton(button: sender as! UIButton)
        self.stepDoneDelegate?.stepDone()
    }
    
    /**
     * Get phone list
     * - returns: List of phone string
     */
    private func getPhoneList() -> [String] {
        let array = G05F03S01._target.customer_phone.components(separatedBy: DomainConst.SPLITER_TYPE1)
        return array
    }
    
    /**
     * Tells the delegate that editing stopped for the specified text field.
     */
    public func textFieldDidEndEditing(_ textField: UITextField) {
        G05F03S04._selectedValue = _txtNew.text!
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
        
    }
}
