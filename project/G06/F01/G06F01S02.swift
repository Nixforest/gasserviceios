//
//  G06F01S02.swift
//  project
//
//  Created by SPJ on 4/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F01S02: StepContent, UIPickerViewDelegate, UIPickerViewDataSource {
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
        if BaseModel.shared.getListAgent().count > 0 {
            if G06F01S02._selectedValue.isEmpty() {
                _pkView.selectRow(0, inComponent: 0, animated: true)
                G06F01S02._selectedValue = BaseModel.shared.getListAgent()[0]
            } else {
                for i in 0..<BaseModel.shared.getListAgent().count {
                    if G06F01S02._selectedValue.id == BaseModel.shared.getListAgent()[i].id {
                        _pkView.selectRow(i, inComponent: 0, animated: true)
                        break
                    }
                }
            }
            
        }
        contentView.addSubview(_pkView)
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00240, contentHeight: GlobalConst.SCREEN_HEIGHT / 3,
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
        if G06F01S02._selectedValue.id == BaseModel.shared.getListAgent()[row].id {
            _pkView.selectedRow(inComponent: row)
        }
        return BaseModel.shared.getListAgent()[row].name
    }
    
    public func pickerView(_ pkviewStep1: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        G06F01S02._selectedValue = BaseModel.shared.getListAgent()[row]
    }
    
    func pickerView(_ pkviewStep1: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: BaseModel.shared.getListAgent()[row].name,
                                                  attributes: [NSForegroundColorAttributeName : UIColor.black])
        return attributedString
    }
    
    
    // MARK: - Picker DataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pkviewStep1: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BaseModel.shared.getListAgent().count
    }
    
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        return true
    }
}
