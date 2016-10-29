//
//  G01F02S03.swift
//  project
//
//  Created by Nixforest on 10/28/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F02S03: StepContent {
    /** Selected value */
    static var _selectedValue: Bool = true
    /** Right button */
    var _rightButton = UIButton()
    /** Wrong button */
    var _wrongButton = UIButton()
    
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
        
        // Right button
        _rightButton.translatesAutoresizingMaskIntoConstraints = true
        _rightButton.frame = CGRect(
            x: (w - GlobalConst.BUTTON_W) / 2,
            y: GlobalConst.MARGIN,
            width: GlobalConst.BUTTON_W,
            height: GlobalConst.BUTTON_H)
        _rightButton.setTitle(GlobalConst.CONTENT00184, for: .normal)
        _rightButton.setTitleColor(UIColor.white , for: .normal)
        _rightButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        _rightButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        _rightButton.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        _rightButton.tag = 1
        offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        contentView.addSubview(_rightButton)
        
        // Wrong button
        _wrongButton.translatesAutoresizingMaskIntoConstraints = true
        _wrongButton.frame = CGRect(
            x: (w - GlobalConst.BUTTON_W) / 2,
            y: GlobalConst.MARGIN + offset,
            width: GlobalConst.BUTTON_W,
            height: GlobalConst.BUTTON_H)
        _wrongButton.setTitle(GlobalConst.CONTENT00185, for: .normal)
        _wrongButton.setTitleColor(UIColor.white , for: .normal)
        _wrongButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        _wrongButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        _wrongButton.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        _wrongButton.tag = 0
        contentView.addSubview(_wrongButton)
        
        self.setup(mainView: contentView, title: GlobalConst.CONTENT00183,
                   contentHeight: offset,
                   width: w, height: h)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle save selected data.
     * Mark step done.
     */
    func btnTapped(_ sender: AnyObject) {
        G01F02S03._selectedValue = sender.tag == 1 ? true : false
        self.stepDoneDelegate?.stepDone()
    }
}
