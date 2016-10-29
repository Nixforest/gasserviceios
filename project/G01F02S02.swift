//
//  G01F02S02.swift
//  project
//
//  Created by Nixforest on 10/28/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F02S02: StepContent, UIPickerViewDelegate, UIPickerViewDataSource {
    /** Selected value */
    static var _selectedValue: ConfigBean = ConfigBean(id: "", name: "")
    // MARK: Properties
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
    init(w: CGFloat, h: CGFloat) {
        super.init()
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        //contentView.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        // Add picker view
        _pkView.translatesAutoresizingMaskIntoConstraints = true
        _pkView.frame = CGRect(x: 0,
                               y: 0,
                               width: w,
                               height: GlobalConst.SCREEN_HEIGHT / 3)
        _pkView.backgroundColor = UIColor.black
        
        
        _pkView.dataSource = self
        _pkView.delegate = self
        contentView.addSubview(_pkView)
        
        self.setup(mainView: contentView, title: GlobalConst.CONTENT00182, contentHeight: GlobalConst.SCREEN_HEIGHT / 3,
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
        G01F02S01._selectedValue = Singleton.sharedInstance.listUpholdStatus[sender.tag]
        self.stepDoneDelegate?.stepDone()
    }
    
    // MARK: - Picker Delegate
    public func pickerView(_ pkviewStep1: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.frame.width
    }
    public func pickerView(_ pkviewStep1: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return GlobalConst.LABEL_HEIGHT
    }
    public func pickerView(_ pkviewStep1: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Singleton.sharedInstance.listHourHandle[row].name
    }
    public func pickerView(_ pkviewStep1: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        G01F02S02._selectedValue = Singleton.sharedInstance.listHourHandle[row]
    }
    func pickerView(_ pkviewStep1: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: Singleton.sharedInstance.listHourHandle[row].name, attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    // MARK: - Picker DataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pkviewStep1: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Singleton.sharedInstance.listHourHandle.count
    }
}

