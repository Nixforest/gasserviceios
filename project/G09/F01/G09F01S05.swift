//
//  G09F01S05.swift
//  project
//
//  Created by SPJ on 5/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G09F01S05: StepContent {
    /** List of button */
    var _listButton = [UIButton]()
    /** List of cashbook type */
    private var listTypes: [ConfigBean] = CacheDataRespModel.record.getListCashBookType()

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
        var selectedIdx = 0
        if listTypes.count > 0 {
            for i in 0..<listTypes.count {
                let button      = UIButton()
                button.frame    = CGRect(x: (w - GlobalConst.BUTTON_W) / 2,
                                         y: GlobalConst.MARGIN + (CGFloat)(i) * (GlobalConst.BUTTON_H + GlobalConst.MARGIN),
                                         width: GlobalConst.BUTTON_W,
                                         height: GlobalConst.BUTTON_H)
                button.tag      = i
                button.titleLabel?.font     = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
                button.backgroundColor      = GlobalConst.BUTTON_COLOR_RED
                button.layer.cornerRadius   = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                //button.contentHorizontalAlignment = .left
                button.setTitle(listTypes[i].name, for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                button.translatesAutoresizingMaskIntoConstraints = true
                // Mark button
                if G09F01VC._typeId == listTypes[i].id {
                    CommonProcess.markButton(button: button)
                    selectedIdx = i
                }
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
        if selectedIdx != 0 {
            getScrollView().scrollRectToVisible(_listButton[selectedIdx].frame, animated: false)
        }
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
        if !G09F01VC._typeId.isBlank {
            for button in self._listButton {
                if listTypes[button.tag].id == G09F01VC._typeId {
                    CommonProcess.unMarkButton(button: button)
                    break
                }
            }
        }
        
        // Set new selected value
        G09F01VC._typeId = listTypes[sender.tag].id
        // Mark selecting button
        CommonProcess.markButton(button: sender as! UIButton)
        self.stepDoneDelegate?.stepDone()
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        if G09F01VC._typeId.isBlank {
            self.showAlert(message: DomainConst.CONTENT00398)
            return false
        } else {
            return true
        }
    }
}
