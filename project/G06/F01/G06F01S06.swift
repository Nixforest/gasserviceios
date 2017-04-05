//
//  G06F01S06.swift
//  project
//
//  Created by SPJ on 4/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F01S06: StepContent {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: [ConfigBean] = [ConfigBean]()
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
        if BaseModel.shared.getListFamilyInvestments().count > 0 {
            for i in 0..<BaseModel.shared.getListFamilyInvestments().count {
                let button      = UIButton()
                button.frame    = CGRect(x: (w - GlobalConst.BUTTON_W) / 2,
                                         y: GlobalConst.MARGIN + (CGFloat)(i) * (GlobalConst.BUTTON_H + GlobalConst.MARGIN),
                                         width: GlobalConst.BUTTON_W,
                                         height: GlobalConst.BUTTON_H)
                button.tag      = i
                button.titleLabel?.font     = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
                button.backgroundColor      = GlobalConst.BUTTON_COLOR_RED
                button.layer.cornerRadius   = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                button.setTitle(BaseModel.shared.getListFamilyInvestments()[i].name, for: .normal)
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
        }
        // Set parent
        self.setParentView(parent: parent)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00306,
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
        let currentVal = BaseModel.shared.getListFamilyInvestments()[(sender as! UIButton).tag]
        var bIsFound = false
        for i in 0..<G06F01S06._selectedValue.count {
            if G06F01S06._selectedValue[i].id == currentVal.id {
                bIsFound = true
                G06F01S06._selectedValue.remove(at: i)
                CommonProcess.unMarkButton(button: sender as! UIButton)
                break
            }
        }
        if !bIsFound {
            G06F01S06._selectedValue.append(currentVal)
            CommonProcess.markButton(button: sender as! UIButton)
        }
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        return true
    }
}
