//
//  G05F03S03.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F03S03: StepContent {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: ConfigBean = ConfigBean()
    /** List of button */
    var _listButton = [UIButton]()
    //private var listAgent: [AgentInfoBean] = BaseModel.shared.getOrderConfig().agent.sorted(by: {$0.info_agent.agent_name > $1.info_agent.agent_name})
    private var listAgent: [ConfigBean] = TempDataRespModel.getData().data.sorted(by: {
        $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending
    })

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
        if listAgent.count > 0 {
            for i in 0..<listAgent.count {
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
                button.setTitle(String(i + 1) + ". " + listAgent[i].name, for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                button.translatesAutoresizingMaskIntoConstraints = true
                // Mark button
                if G05F03S03._selectedValue.id == listAgent[i].id {
                    CommonProcess.markButton(button: button)
                }
                _listButton.append(button)
                contentView.addSubview(button)
                offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
            }
        }
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
        if listAgent.count > 0 {
            for i in 0..<listAgent.count {
                // Unmark
                CommonProcess.unMarkButton(button: _listButton[i])
                // Mark button
                if G05F03S03._selectedValue.id == listAgent[i].id {
                    CommonProcess.markButton(button: _listButton[i])
                    G05F03S03._selectedValue = listAgent[i]
                    // Move select button to visible
                    self.getScrollView().scrollRectToVisible(_listButton[i].frame, animated: false)
                }
            }
        }
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
        if !G05F03S03._selectedValue.isEmpty() {
            for button in self._listButton {
                if listAgent[button.tag].id == G05F03S03._selectedValue.id {
                    CommonProcess.unMarkButton(button: button)
                    break
                }
            }
        }
        
        // Set new selected value
        G05F03S03._selectedValue = listAgent[sender.tag]
        // Mark selecting button
        CommonProcess.markButton(button: sender as! UIButton)
        self.stepDoneDelegate?.stepDone()
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        if G05F03S03._selectedValue.isEmpty() {
            self.showAlert(message: DomainConst.CONTENT00377)
            return false
        } else {
            return true
        }
    }
}
