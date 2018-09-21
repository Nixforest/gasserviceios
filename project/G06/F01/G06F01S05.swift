//
//  G06F01S05.swift
//  project
//
//  Created by SPJ on 4/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F01S05: StepContent {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: ConfigBean = ConfigBean(id: "", name: "")
    /** List of selection */
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
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        var offset: CGFloat = GlobalConst.MARGIN
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        // Add button
        if BaseModel.shared.getListFamilyTypes().count > 0 {
            for i in 0..<BaseModel.shared.getListFamilyTypes().count {
                let button      = UIButton()
                button.frame    = CGRect(x: (w - GlobalConst.BUTTON_W) / 2,
                                         y: GlobalConst.MARGIN + (CGFloat)(i) * (GlobalConst.BUTTON_H + GlobalConst.MARGIN),
                                         width: GlobalConst.BUTTON_W,
                                         height: GlobalConst.BUTTON_H)
                button.tag      = i
                button.titleLabel?.font     = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
                button.backgroundColor      = GlobalConst.BUTTON_COLOR_RED
                button.layer.cornerRadius   = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                button.setTitle(BaseModel.shared.getListFamilyTypes()[i].name, for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = true
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                // Mark button
//                if G06F01S05._selectedValue.id == BaseModel.shared.getListFamilyTypes()[i].id {
//                    CommonProcess.markButton(button: button)
//                }
                _listButton.append(button)
                contentView.addSubview(button)
                offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
            }
            if G06F01S01._selectedValue.phone.isEmpty {
                btnTapped(_listButton[0])
            } else {
                btnTapped(_listButton[1])
            }
        }
        // Set parent
        self.setParentView(parent: parent)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00305,
                   contentHeight: offset,
                   width: w, height: h)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateData),
                                               name: NSNotification.Name(rawValue: self.theClassName),
                                               object: nil)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Update data for this view
     */
    internal func updateData(_ notification: Notification) {
        if G06F01S01._selectedValue.phone.isEmpty {
            btnTapped(_listButton[0])
        } else {
            btnTapped(_listButton[1])
        }
    }
    
    /**
     * Handle save selected data.
     * Mark step done.
     */
    func btnTapped(_ sender: AnyObject) {
        // Un-mark selecting button
        if !G06F01S05._selectedValue.id.isEmpty {
            for button in self._listButton {
                if BaseModel.shared.getListFamilyTypes()[button.tag].id == G06F01S05._selectedValue.id {
                    CommonProcess.unMarkButton(button: button)
                    break
                }
            }
        }
        
        // Set new selected value
        G06F01S05._selectedValue = BaseModel.shared.getListFamilyTypes()[sender.tag]
        // Mark selecting button
        CommonProcess.markButton(button: sender as! UIButton)
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        if G06F01S05._selectedValue.id.isEmpty {
            self.showAlert(message: DomainConst.CONTENT00201)
            return false
        } else {
            return true
        }
    }
}
