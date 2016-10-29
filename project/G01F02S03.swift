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
    var rightButton = UIButton()
    /** Wrong button */
    var wrongButton = UIButton()
    
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
        rightButton.translatesAutoresizingMaskIntoConstraints = true
        rightButton.frame = CGRect(
            x: (w - GlobalConst.BUTTON_W) / 2,
            y: GlobalConst.MARGIN,
            width: GlobalConst.BUTTON_W,
            height: GlobalConst.BUTTON_H)
        rightButton.setTitle(GlobalConst.CONTENT00184, for: .normal)
        rightButton.setTitleColor(UIColor.white , for: .normal)
        rightButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        rightButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        rightButton.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        contentView.addSubview(rightButton)
        
        // Wrong button
        wrongButton.translatesAutoresizingMaskIntoConstraints = true
        wrongButton.frame = CGRect(
            x: (w - GlobalConst.BUTTON_W) / 2,
            y: GlobalConst.MARGIN + offset,
            width: GlobalConst.BUTTON_W,
            height: GlobalConst.BUTTON_H)
        wrongButton.setTitle(GlobalConst.CONTENT00185, for: .normal)
        wrongButton.setTitleColor(UIColor.white , for: .normal)
        wrongButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        wrongButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        wrongButton.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        contentView.addSubview(wrongButton)
        
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
        G01F02S01._selectedValue = Singleton.sharedInstance.listUpholdStatus[sender.tag]
        self.stepDoneDelegate?.stepDone()
    }
}
