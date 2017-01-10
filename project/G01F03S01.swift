//
//  G01F03S01.swift
//  project
//
//  Created by Nixforest on 11/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

class G01F03S01: StepContent {
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
        if BaseModel.shared.listRatingStatus.count > 0 {
            for i in 0..<BaseModel.shared.listRatingStatus.count {
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = true
                button.frame = CGRect(
                    x: (w - GlobalConst.BUTTON_W) / 2,
                    y: GlobalConst.MARGIN + (CGFloat)(i) * (GlobalConst.BUTTON_H + GlobalConst.MARGIN),
                    width: GlobalConst.BUTTON_W,
                    height: GlobalConst.BUTTON_H)
                button.tag = i
                button.setTitle(BaseModel.shared.listRatingStatus[i].name, for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
                button.backgroundColor = GlobalConst.BUTTON_COLOR_RED
                var imgName = DomainConst.BLANK
                switch BaseModel.shared.listRatingStatus[i].id {
                case "1":
                    imgName = "icon53.png"
                    break
                case "2":
                    imgName = "icon52.png"
                    break
                case "3":
                    imgName = "icon54.png"
                    break
                default:
                    break
                }
                button.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0)
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                button.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                button.setLeftImage(imageName: imgName, padding: 10.0)
                // Mark button
                if G01F03S01._selectedValue.id == BaseModel.shared.listRatingStatus[i].id {
                    CommonProcess.markButton(button: button)
                }
                _listButton.append(button)
                contentView.addSubview(button)
                offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
            }
        }
        // Set parent
        self.setParentView(parent: parent)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00206,
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
        if !G01F03S01._selectedValue.id.isEmpty {
            for button in self._listButton {
                if BaseModel.shared.listRatingStatus[button.tag].id == G01F03S01._selectedValue.id {
                    CommonProcess.unMarkButton(button: button)
                    break
                }
            }
        }
        
        // Set new selected value
        G01F03S01._selectedValue = BaseModel.shared.listRatingStatus[sender.tag]
        // Mark selecting button
        CommonProcess.markButton(button: sender as! UIButton)
        NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F03), object: nil)
        self.stepDoneDelegate?.stepDone()
    }
    
    override func checkDone() -> Bool {
        if G01F03S01._selectedValue.id.isEmpty {
            self.showAlert(message: DomainConst.CONTENT00206)
            return false
        } else {
            return true
        }
    }
}
