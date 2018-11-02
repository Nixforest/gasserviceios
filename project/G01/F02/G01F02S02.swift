//
//  G01F02S02.swift
//  project
//
//  Created by Nixforest on 10/28/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F02S02: StepContent, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: ConfigBean = ConfigBean(id: "", name: "")
    /** Picker view */
    var _pkView: UIPickerView = UIPickerView()
    
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
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        // Add picker view
        _pkView.translatesAutoresizingMaskIntoConstraints = true
        _pkView.frame = CGRect(x: 0, y: 0,
                               width: w,
                               height: GlobalConst.SCREEN_HEIGHT / 3)
        _pkView.backgroundColor = UIColor.white
        _pkView.dataSource      = self
        _pkView.delegate        = self
        contentView.addSubview(_pkView)
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00182, contentHeight: GlobalConst.SCREEN_HEIGHT / 3,
                   width: w, height: h)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Picker Delegate
    public func pickerView(_ pkviewStep1: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.frame.width
    }
    public func pickerView(_ pkviewStep1: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return GlobalConst.LABEL_HEIGHT
    }
    public func pickerView(_ pkviewStep1: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if G01F02S02._selectedValue.id == BaseModel.shared.listHourHandle[row].id {
            _pkView.selectedRow(inComponent: row)
        }
        return BaseModel.shared.listHourHandle[row].name
    }
    public func pickerView(_ pkviewStep1: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        G01F02S02._selectedValue = BaseModel.shared.listHourHandle[row]
        NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F02),
                                        object: nil)
    }
    func pickerView(_ pkviewStep1: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: BaseModel.shared.listHourHandle[row].name,
                                                  attributes: [NSForegroundColorAttributeName : UIColor.black])
        return attributedString
    }
    
    // MARK: - Picker DataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pkviewStep1: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BaseModel.shared.listHourHandle.count
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        if G01F02S02._selectedValue.id.isEmpty {
            self.showAlert(message: DomainConst.CONTENT00182)
            return false
        } else {
            return true
        }
    }
}

