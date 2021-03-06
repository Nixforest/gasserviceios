//
//  CreateUpholdStep1ViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F01S01: StepContent {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: ConfigBean = ConfigBean(id: "", name: "")
    /** Other problem content */
    static var _otherProblem: String = ""
    /** List of selection */
    var _listButton = [UIButton]()
    /** Label othe problem */
    var _lblOtherProblem: UITextView = UITextView()
    
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
        if BaseModel.shared.listUpholdType.count > 0 {
            for i in 0..<BaseModel.shared.listUpholdType.count {
                let button      = UIButton()
                button.frame    = CGRect(x: (w - GlobalConst.BUTTON_W) / 2,
                                         y: GlobalConst.MARGIN + (CGFloat)(i) * (GlobalConst.BUTTON_H + GlobalConst.MARGIN),
                                         width: GlobalConst.BUTTON_W,
                                         height: GlobalConst.BUTTON_H)
                button.tag      = i
                button.titleLabel?.font     = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
                button.backgroundColor      = GlobalConst.BUTTON_COLOR_RED
                button.layer.cornerRadius   = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                button.setTitle(BaseModel.shared.listUpholdType[i].name, for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = true
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                // Mark button
                if G01F01S01._selectedValue.id == BaseModel.shared.listUpholdType[i].id {
                    CommonProcess.markButton(button: button)
                }
                _listButton.append(button)
                contentView.addSubview(button)
                offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
            }
            // Label title
            _lblOtherProblem.translatesAutoresizingMaskIntoConstraints = true
            _lblOtherProblem.frame = CGRect(x: (w - GlobalConst.BUTTON_W) / 2,
                                            y: offset,
                                            width: GlobalConst.BUTTON_W,
                                            height: GlobalConst.LABEL_HEIGHT * 3)
            _lblOtherProblem.text               = G01F01S01._otherProblem
            _lblOtherProblem.font               = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
            _lblOtherProblem.isHidden           = G01F01S01._otherProblem.isEmpty
            _lblOtherProblem.isEditable         = false
            _lblOtherProblem.backgroundColor    = UIColor.white
            CommonProcess.setBorder(view: _lblOtherProblem)
            offset += GlobalConst.LABEL_HEIGHT * 3 + GlobalConst.MARGIN
            contentView.addSubview(_lblOtherProblem)
        }
        // Set parent
        self.setParentView(parent: parent)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00201,
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
        if !G01F01S01._selectedValue.id.isEmpty {
            for button in self._listButton {
                if BaseModel.shared.listUpholdType[button.tag].id == G01F01S01._selectedValue.id {
                    CommonProcess.unMarkButton(button: button)
                    break
                }
            }
        }
        
        // Set new selected value
        G01F01S01._selectedValue = BaseModel.shared.listUpholdType[sender.tag]
        // Mark selecting button
        CommonProcess.markButton(button: sender as! UIButton)
        if G01F01S01._selectedValue.name == DomainConst.OPTION_OTHER {
            createAlert()
        } else {
            _lblOtherProblem.isHidden           = true
            G01F01S01._otherProblem             = ""
            NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F01), object: nil)
            self.stepDoneDelegate?.stepDone()
        }
    }
    
    /**
     * Create alert to input other problem
     */
    func createAlert() {
        if G01F01S01._selectedValue.name == DomainConst.OPTION_OTHER {
            var inputTextField: UITextField?
            // Create alert
            let alert = UIAlertController(title: DomainConst.CONTENT00203, message: "", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { textField -> Void in
                inputTextField                      = textField
                inputTextField?.placeholder         = DomainConst.CONTENT00063
                inputTextField?.clearButtonMode     = .whileEditing
                inputTextField?.font                = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
            })
            // Add cancel action
            let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
            
            // Add ok action
            let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
                if !(inputTextField?.text?.isEmpty)! {
                    G01F01S01._otherProblem         = (inputTextField?.text)!
                    self._lblOtherProblem.text      = G01F01S01._otherProblem
                    self._lblOtherProblem.isHidden  = G01F01S01._otherProblem.isEmpty
                    NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F01), object: nil)
                    self.stepDoneDelegate?.stepDone()
                } else {
                    self.createAlert()
                }
            }
            
            alert.addAction(cancel)
            alert.addAction(ok)
            self.getParentView().present(alert, animated: true, completion: { () -> Void in
                self.layoutIfNeeded()
            })
        }
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        if G01F01S01._selectedValue.id.isEmpty {
            self.showAlert(message: DomainConst.CONTENT00201)
            return false
        } else {
            if ((G01F01S01._selectedValue.name == DomainConst.OPTION_OTHER)
                && (G01F01S01._otherProblem.isEmpty)) {
                self.showAlert(message: DomainConst.CONTENT00201)
                return false
            } else {
                return true
            }
        }
    }
}
