//
//  G08F01S02.swift
//  project
//
//  Created by SPJ on 5/6/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G08F01S02: StepContent {
    // MARK: Properties
    /** Date picker */
    private var _datePicker:            DatePickerView  = DatePickerView()
    /** Selected value */
    public static var _selectedValue:   String          = CommonProcess.getCurrentDate()

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
        contentView.isUserInteractionEnabled = true
        self.isUserInteractionEnabled = true
        // --- Create content view ---
        _datePicker = DatePickerView(frame: CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                                   y: offset,
                                                   width: GlobalConst.EDITTEXT_W,
                                                   height: GlobalConst.SCREEN_HEIGHT - getTitleHeight()))
        _datePicker.setTitle(title: DomainConst.CONTENT00364)
        contentView.addSubview(_datePicker)
        offset += DatePickerView.STATIC_HEIGHT
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00363,
                   contentHeight: offset,
                   width: w, height: h)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        G08F01S02._selectedValue = _datePicker.getValue().replacingOccurrences(
            of: DomainConst.SPLITER_TYPE1,
            with: DomainConst.SPLITER_TYPE3)
        return true
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        self.endEditing(true)
    }
    
    /**
     * Tells the responder when one or more fingers touch down in a view or window.
     */
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
}
