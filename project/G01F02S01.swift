//
//  G01F02S01VC.swift
//  project
//
//  Created by Nixforest on 10/28/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F02S01: StepContent {
    /** Selected value */
    static var _selectedValue: ConfigBean = ConfigBean(id: "", name: "")
    // MARK: Properties
    var _listButton = [UIButton]()

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
        var offset: CGFloat = GlobalConst.MARGIN
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        //contentView.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        // Add button
        if Singleton.sharedInstance.listUpholdType.count > 0 {
            for i in 1..<Singleton.sharedInstance.listUpholdStatus.count {
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = true
                button.frame = CGRect(
                    x: (w - GlobalConst.BUTTON_W) / 2,
                    y: GlobalConst.MARGIN + (CGFloat)(i - 1) * (GlobalConst.BUTTON_H + GlobalConst.MARGIN),
                    width: GlobalConst.BUTTON_W,
                    height: GlobalConst.BUTTON_H)
                button.tag = i
                button.setTitle(Singleton.sharedInstance.listUpholdStatus[i].name, for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
                button.backgroundColor = GlobalConst.BUTTON_COLOR_RED
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                button.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                // Mark button
                if G01F02S01._selectedValue.id == Singleton.sharedInstance.listUpholdStatus[i].id {
                    CommonProcess.markButton(button: button)
                }
                _listButton.append(button)
                contentView.addSubview(button)
                offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
            }
        }
        // Set parent
        self._parent = parent
        
        self.setup(mainView: contentView, title: GlobalConst.CONTENT00181,
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
        // Un-mark selecting button
        if !G01F02S01._selectedValue.id.isEmpty {
            for button in self._listButton {
                if Singleton.sharedInstance.listUpholdStatus[button.tag].id == G01F02S01._selectedValue.id {
                    CommonProcess.unMarkButton(button: button)
                    break
                }
            }
        }
        
        // Set new selected value
        G01F02S01._selectedValue = Singleton.sharedInstance.listUpholdStatus[sender.tag]
        // Mark selecting button
        CommonProcess.markButton(button: sender as! UIButton)
        NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_G02F02), object: nil)
        self.stepDoneDelegate?.stepDone()
    }
    
    override func checkDone() -> Bool {
        if G01F02S01._selectedValue.id.isEmpty {
            self._parent?.showAlert(message: GlobalConst.CONTENT00181)
            return false
        } else {
            return true
        }
    }
}
