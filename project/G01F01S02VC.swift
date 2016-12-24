//
//  CreateUpholdStep2ViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F01S02: StepContent {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: ConfigBean = ConfigBean(id: "", name: "")
    /** Name */
    static var _name: String = ""
    /** Phone */
    static var _phone: String = ""
    /** List of selection */
    var _listButton = [UIButton]()
    /** Name textfield */
    var _tbxName = UITextView()
    /** Phone textfield */
    var _tbxPhone = UITextView()
    
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
        if BaseModel.shared.listContactType.count > 0 {
            for i in 0..<BaseModel.shared.listContactType.count {
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = true
                button.frame = CGRect(
                    x: (w - GlobalConst.BUTTON_W) / 2,
                    y: GlobalConst.MARGIN + (CGFloat)(i) * (GlobalConst.BUTTON_H + GlobalConst.MARGIN),
                    width: GlobalConst.BUTTON_W,
                    height: GlobalConst.BUTTON_H)
                button.tag = i
                button.setTitle(BaseModel.shared.listContactType[i].name, for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
                button.backgroundColor = GlobalConst.BUTTON_COLOR_RED
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                button.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                // Mark button
                if G01F01S02._selectedValue.id == BaseModel.shared.listContactType[i].id {
                    CommonProcess.markButton(button: button)
                }
                _listButton.append(button)
                contentView.addSubview(button)
                offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
            }
            // Name textfield
            _tbxName.frame = CGRect(
                x: (w - GlobalConst.EDITTEXT_W) / 2,
                y: offset,
                width: GlobalConst.EDITTEXT_W,
                height: GlobalConst.EDITTEXT_H)
            _tbxName.translatesAutoresizingMaskIntoConstraints = true
            _tbxName.font = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
            _tbxName.isEditable = false
            if !G01F01S02._name.isEmpty {
                _tbxName.text = G01F01S02._name
            }
            CommonProcess.setBorder(view: _tbxName)
            offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
            contentView.addSubview(_tbxName)
            // Phone textfield
            _tbxPhone.frame = CGRect(
                x: (w - GlobalConst.EDITTEXT_W) / 2,
                y: offset,
                width: GlobalConst.EDITTEXT_W,
                height: GlobalConst.EDITTEXT_H)
            _tbxPhone.translatesAutoresizingMaskIntoConstraints = true
            _tbxPhone.font = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
            _tbxPhone.isEditable = false
            if !G01F01S02._phone.isEmpty {
                _tbxName.text = G01F01S02._phone
            }
            CommonProcess.setBorder(view: _tbxPhone)
            offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
            contentView.addSubview(_tbxPhone)
        }
        // Set parent
        self._parent = parent
        
        self.setup(mainView: contentView, title: GlobalConst.CONTENT00204,
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
        if !G01F01S02._selectedValue.id.isEmpty {
            for button in self._listButton {
                if BaseModel.shared.listContactType[button.tag].id == G01F01S02._selectedValue.id {
                    CommonProcess.unMarkButton(button: button)
                    break
                }
            }
        }
        
        // Set new selected value
        G01F01S02._selectedValue = BaseModel.shared.listContactType[sender.tag]
        // Mark selecting button
        CommonProcess.markButton(button: sender as! UIButton)
        createAlert()
    }
    
    func createAlert() {
        var tbxName: UITextField?
        var tbxPhone: UITextField?
        // Create alert
        let alert = UIAlertController(title: GlobalConst.CONTENT00076, message: "", preferredStyle: .alert)
        // Add textfield name
        alert.addTextField(configurationHandler: { textField -> Void in
            tbxName = textField
            //tbxName?.translatesAutoresizingMaskIntoConstraints = true
            tbxName?.placeholder        = GlobalConst.CONTENT00055
            tbxName?.clearButtonMode    = .whileEditing
            tbxName?.frame.size.height  = GlobalConst.EDITTEXT_H
            //tbxName?.borderStyle        = .roundedRect
            tbxName?.returnKeyType      = .next
            tbxName?.autocapitalizationType = .words
            tbxName?.font = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
            tbxName?.text               = G01F01S02._name
        })
        // Add textfield phone
        alert.addTextField(configurationHandler: { textField -> Void in
            tbxPhone = textField
            //tbxPhone?.translatesAutoresizingMaskIntoConstraints = true
            tbxPhone?.placeholder       = GlobalConst.CONTENT00054
            tbxPhone?.clearButtonMode   = .whileEditing
            tbxPhone?.keyboardType      = .phonePad
            tbxPhone?.frame.size.height = GlobalConst.EDITTEXT_H
            //tbxPhone?.borderStyle       = .roundedRect
            tbxPhone?.text              = G01F01S02._phone
            tbxPhone?.font = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        })
        // Add cancel action
        let cancel = UIAlertAction(title: GlobalConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: GlobalConst.CONTENT00008, style: .default) { action -> Void in
            if !(tbxName?.text?.isEmpty)! && !(tbxPhone?.text?.isEmpty)! {
                G01F01S02._name     = (tbxName?.text)!
                self._tbxName.text  = G01F01S02._name
                G01F01S02._phone     = (tbxPhone?.text)!
                self._tbxPhone.text  = G01F01S02._phone
                NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_G01F01), object: nil)
                self.stepDoneDelegate?.stepDone()
            } else {
                self.createAlert()
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self._parent?.present(alert, animated: true, completion: { () -> Void in
            self.layoutIfNeeded()
        })
    }
    
    override func checkDone() -> Bool {
        if G01F01S02._selectedValue.id.isEmpty {
            self._parent?.showAlert(message: GlobalConst.CONTENT00204)
            return false
        } else {
            if (G01F01S02._name.isEmpty || G01F01S02._phone.isEmpty) {
                self._parent?.showAlert(message: GlobalConst.CONTENT00204)
                return false
            } else {
                return true
            }
        }
    }
}
