//
//  G11F01S02.swift
//  project
//
//  Created by Nix Nixforest on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G11F01S02: StepContent {
    /** Selected value */
    public static var _selectedValue:   ConfigBean          = ConfigBean()
    /** List of button */
    var _listButton = [UIButton]()
    /** List of PIC */
    private var listPICes: [ConfigBean] = [ConfigBean]()

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
        if listPICes.count > 0 {
            for i in 0..<listPICes.count {
                let button      = UIButton()
                button.frame    = CGRect(x: (w - GlobalConst.BUTTON_W) / 2,
                                         y: GlobalConst.MARGIN + (CGFloat)(i) * (GlobalConst.BUTTON_H + GlobalConst.MARGIN),
                                         width: GlobalConst.BUTTON_W,
                                         height: GlobalConst.BUTTON_H)
                button.tag      = i
                button.titleLabel?.font     = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
                button.backgroundColor      = GlobalConst.BUTTON_COLOR_RED
                button.layer.cornerRadius   = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                button.setTitle(listPICes[i].name, for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                button.translatesAutoresizingMaskIntoConstraints = true
                _listButton.append(button)
                contentView.addSubview(button)
                offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
            }
        }
        // Set parent
        self.setParentView(parent: parent)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00398,
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
        if !G11F01S02._selectedValue.isEmpty() {
            for button in self._listButton {
                if listPICes[button.tag].id == G11F01S02._selectedValue.id {
                    CommonProcess.unMarkButton(button: button)
                    break
                }
            }
        }
        
        // Set new selected value
        G11F01S02._selectedValue = listPICes[sender.tag]
        // Mark selecting button
        CommonProcess.markButton(button: sender as! UIButton)
        self.stepDoneDelegate?.stepDone()
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        if G11F01S02._selectedValue.isEmpty() {
            self.showAlert(message: DomainConst.CONTENT00398)
            return false
        } else {
            return true
        }
    }
}
