//
//  G01F01S04.swift
//  project
//
//  Created by SPJ on 12/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F01S04: StepContent {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: ConfigBean = ConfigBean()
    /** List of selection */
    var _listButton = [UIButton]()
    
    /**
     * Default initializer.
     */
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        var offset: CGFloat = GlobalConst.MARGIN
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        // Add button
        if BaseModel.shared.getListVipCustomerStores().count > 0 {
            for i in 0..<BaseModel.shared.getListVipCustomerStores().count {
                let button      = UIButton()
                button.frame    = CGRect(x: (w - GlobalConst.BUTTON_W) / 2,
                                         y: GlobalConst.MARGIN + (CGFloat)(i) * (GlobalConst.BUTTON_H + GlobalConst.MARGIN),
                                         width: GlobalConst.BUTTON_W,
                                         height: GlobalConst.BUTTON_H)
                button.tag      = i
                button.titleLabel?.font     = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
                button.backgroundColor      = GlobalConst.BUTTON_COLOR_RED
                button.layer.cornerRadius   = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                button.setTitle(BaseModel.shared.getListVipCustomerStores()[i].name, for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = true
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                // Mark button
                if G01F01S04._selectedValue.id == BaseModel.shared.getListVipCustomerStores()[i].id {
                    CommonProcess.markButton(button: button)
                }
                _listButton.append(button)
                contentView.addSubview(button)
                offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
            }
        }
        // Set parent
        self.setParentView(parent: parent)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00551,
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
        if !G01F01S04._selectedValue.isEmpty() {
            for button in self._listButton {
                if BaseModel.shared.getListVipCustomerStores()[button.tag].id == G01F01S04._selectedValue.id {
                    CommonProcess.unMarkButton(button: button)
                    break
                }
            }
        }
        
        // Set new selected value
//        G01F01S04._selectedValue = BaseModel.shared.getListVipCustomerStores()[sender.tag].id
        G01F01S04._selectedValue = BaseModel.shared.getListVipCustomerStores()[sender.tag]
        // Mark selecting button
        CommonProcess.markButton(button: sender as! UIButton)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F01), object: nil)
        self.stepDoneDelegate?.stepDone()
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        if G01F01S04._selectedValue.isEmpty() {
            self.showAlert(message: DomainConst.CONTENT00551)
            return false
        } else {
            return true
        }
    }
}
