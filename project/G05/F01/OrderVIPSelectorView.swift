//
//  OrderVIPSelectorView.swift
//  project
//
//  Created by SPJ on 2/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderVIPSelectorView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, CheckBoxDelegate {
    /** Checkbox */
    private var _checkBox:      CustomCheckBox  = CustomCheckBox()
    //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
//    /** Blur view */
//    private var _viewBlur:      UIView          = UIView()
//    /** Number picker */
//    private var _numberPicker:  UIPickerView    = UIPickerView()
//    /** Value button */
//    private var _button:        UIButton        = UIButton()
    /** Config value */
    private var _config:        ConfigBean      = ConfigBean()
//    /** Previous button */
//    private var _prevButton:    UIButton        = UIButton()
    /** Value button */
    private var _valButton:     UIButton        = UIButton()
//    /** Next button */
//    private var _nextButton:    UIButton        = UIButton()
    /** Stepper */
    private var _stepper:       UIStepper       = UIStepper()
    /** Label */
    private var _checkboxLabel: String          = DomainConst.BLANK
    //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /**
     * Setup layout
     * - parameter frame: Frame of control
     * - parameter checkboxLabel: Label of checkbox
     */
    public func setup(frame: CGRect, checkboxLabel: String, config: ConfigBean) {
        //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
        _checkboxLabel = checkboxLabel
        //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
        self.frame = frame
        // Check box
        //self._checkBox.frame = CGRect(x: GlobalConst.MARGIN,
        self._checkBox.frame = CGRect(x: 0,
                                      y: 0,
                                      //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
                                      //width: GlobalConst.BUTTON_W,
                                      width: GlobalConst.BUTTON_W * 2 / 3,
                                      //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
                                      height: frame.height)
        self._checkBox.setTitle(checkboxLabel, for: UIControlState())
        self._checkBox.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self._checkBox.tintColor = UIColor.black
        self._checkBox.setTitleColor(UIColor.black, for: UIControlState())
        self._checkBox.imageView?.contentMode = .scaleAspectFit
        self._checkBox.layoutSubviews()
        self._checkBox.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                      left: GlobalConst.MARGIN,
                                                      bottom: GlobalConst.MARGIN,
                                                      right: GlobalConst.MARGIN)
        self._checkBox.checkChangedDelegate = self
        self.addSubview(self._checkBox)
        
        //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
        // Button
//        self._button.frame = CGRect(x: frame.width * 2 / 3,
//                                    y: 0,
//                                    width: frame.width / 3,
//                                    height: frame.height)
//        self._button.setTitle(DomainConst.NUMBER_ZERO_VALUE, for: UIControlState())
//        self._button.setTitleColor(UIColor.white, for: UIControlState())
//        self._button.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
//        self._button.backgroundColor = GlobalConst.BUTTON_COLOR_RED
//        self._button.titleLabel?.font = UIFont.boldSystemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
//        self._button.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
//        var img = ImageManager.getImage(named: DomainConst.ADD_ICON_IMG_NAME)
//        var tintedImg = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//        self._button.setImage(tintedImg, for: UIControlState())
//        self._button.imageView?.contentMode = .scaleAspectFit
//        self._button.tintColor = UIColor.white
//        self._button.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
//                                                      left: GlobalConst.MARGIN,
//                                                      bottom: GlobalConst.MARGIN,
//                                                      right: GlobalConst.MARGIN)
//        self._button.isHidden = true
//        self.addSubview(self._button)
//        
//        // Previous Button
//        self._prevButton.frame = CGRect(x: frame.width * 2 / 3,
//                                    y: 0,
//                                    width: frame.width / 9,
//                                    height: frame.height)
//        self._prevButton.addTarget(self, action: #selector(prevButtonTapped(_:)), for: .touchUpInside)
//        self._prevButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
//        img = ImageManager.getImage(named: DomainConst.BACK_ICON_IMG_NAME)
//        tintedImg = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//        self._prevButton.setImage(img, for: UIControlState())
//        self._prevButton.imageView?.contentMode = .scaleAspectFit
//        self._prevButton.tintColor = UIColor.white
//        self._prevButton.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
//                                                    left: GlobalConst.MARGIN,
//                                                    bottom: GlobalConst.MARGIN,
//                                                    right: GlobalConst.MARGIN)
//        self.addSubview(self._prevButton)
        // Value button
        //self._valButton.frame = CGRect(x: self._prevButton.frame.maxX,
        let btnWidth: CGFloat = frame.width / 7
        self._valButton.frame = CGRect(x: frame.maxX - GlobalConst.STEPPER_LAYOUT_WIDTH - GlobalConst.MARGIN * 2 - btnWidth,
                                       y: 0,
                                       //width: frame.width / 7,
                                       width: btnWidth,
                                       height: frame.height)
        
        self._valButton.setTitle(config.name, for: UIControlState())
        //++ BUG0086-SPJ (NguyenPT 20170530) Add phone
        if config.name != DomainConst.NUMBER_ZERO_VALUE {
            self._checkBox.bChecked = true
        }
        //-- BUG0086-SPJ (NguyenPT 20170530) Add phone
        self._valButton.setTitleColor(UIColor.white, for: UIControlState())
        self._valButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self._valButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
        self._valButton.addTarget(self, action: #selector(btnValueTapped(_:)), for: .touchUpInside)
        self._valButton.accessibilityIdentifier = _checkboxLabel
        self.addSubview(self._valButton)
        
//        // Next Button
//        self._nextButton.frame = CGRect(x: self._valButton.frame.maxX,
//                                        y: 0,
//                                        width: frame.width / 9,
//                                        height: frame.height)
//        self._nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
//        self._nextButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
//        img = ImageManager.getImage(named: DomainConst.NEXT_ICON_IMG_NAME)
//        tintedImg = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//        self._nextButton.setImage(img, for: UIControlState())
//        self._nextButton.imageView?.contentMode = .scaleAspectFit
//        self._nextButton.tintColor = UIColor.white
//        self._nextButton.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
//                                                        left: GlobalConst.MARGIN,
//                                                        bottom: GlobalConst.MARGIN,
//                                                        right: GlobalConst.MARGIN)
//        
//        self.addSubview(self._nextButton)
        
//        // Number picker
//        self._numberPicker.frame = CGRect(x: 0,
//                                          y: GlobalConst.SCREEN_HEIGHT * 2 / 3,
//                                          width: GlobalConst.SCREEN_WIDTH,
//                                          height: GlobalConst.SCREEN_HEIGHT / 3)
//        self._numberPicker.backgroundColor = UIColor.white
//        self._numberPicker.delegate = self
//        self._numberPicker.dataSource = self
//        self._numberPicker.isHidden = false
//        CommonProcess.setBorder(view: self._numberPicker)
//        // Blur view
//        self._viewBlur.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH,
//                                      height: GlobalConst.SCREEN_HEIGHT)
//        self._viewBlur.backgroundColor = UIColor(white: 0x444444, alpha: 0)
//        self._viewBlur.addSubview(self._numberPicker)
        _stepper.frame = CGRect(x: frame.maxX - GlobalConst.STEPPER_LAYOUT_WIDTH - GlobalConst.MARGIN,
                                y: (frame.height - GlobalConst.STEPPER_LAYOUT_HEIGHT) / 2,
                                width: 0,
                                height: 0)
        //++ BUG0063-SPJ (NguyenPT 20170520) Fix bug
//        _stepper.wraps = true
//        _stepper.autorepeat = false
        _stepper.wraps = false
        _stepper.autorepeat = true
        //-- BUG0063-SPJ (NguyenPT 20170520) Fix bug
        _stepper.maximumValue = 999
        _stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        self.addSubview(_stepper)
        //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
        self._config = config
        self.makeComponentsColor()
    }
    
    //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
    /**
     * Handle when change value in stepper control
     */
    internal func stepperValueChanged(_ sender: UIStepper) {
        updateValue(value: String(describing: Int(sender.value)))
        //++ BUG0063-SPJ (NguyenPT 20170520) Fix bug: Set check when value is not zero
        self._checkBox.bChecked = (Int(sender.value) != 0)
        //-- BUG0063-SPJ (NguyenPT 20170520) Fix bug: Set check when value is not zero
    }
    //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
    
    /**
     * Handle click event
     */
    public func prevButtonTapped(_ sender: AnyObject) {
        //++ BUG0070-SPJ (NguyenPT 20170426) Handle convert String -> Int
        //var value = Int(self._config.name)! - 1
        var value = 0
        if let number = Int(self._config.name) {
            value = number - 1
        }
        //-- BUG0070-SPJ (NguyenPT 20170426) Handle convert String -> Int
        if value < 0 {
            value = 0
        }
        //self._config.name = String(value)
        //self._valButton.setTitle(self._config.name, for: UIControlState())
        updateValue(value: String(value))
    }
    
    /**
     * Handle click event
     */
    public func nextButtonTapped(_ sender: AnyObject) {
        //++ BUG0070-SPJ (NguyenPT 20170426) Handle convert String -> Int
        //var value = Int(self._config.name)! + 1
        var value = 0
        if let number = Int(self._config.name) {
            value = number - 1
        }
        //-- BUG0070-SPJ (NguyenPT 20170426) Handle convert String -> Int
        if value < 0 {
            value = 0
        }
        //self._config.name = String(value)
        //self._valButton.setTitle(self._config.name, for: UIControlState())
        updateValue(value: String(value))
    }
    
    //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
//    /**
//     * Handle click event.
//     */
//    public func btnTapped(_ sender: AnyObject) {
//        self._viewBlur.isHidden = false
//        var currentView: UIViewController? = nil
//        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
//            currentView = navigationController.visibleViewController
//        }
//        currentView?.view.addSubview(self._viewBlur)
//        if !self._checkBox.bChecked {
//            self._checkBox.bChecked = true
//        }
//    }
    //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
    
    //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
//    /**
//     * Show number picker
//     */
//    private func showNumberPicker() {
//        if BaseModel.shared.getDebugShowNumPickerFlag() {
//            // Show picker
//            self._viewBlur.isHidden = false
//            if let currentView = BaseViewController.getCurrentViewController() {
//                currentView.view.addSubview(self._viewBlur)
//            }
//        }
//    }
    //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
    
    /**
     * Tap value button event handler
     */
    internal func btnValueTapped(_ sender: AnyObject) {
        //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
//        showNumberPicker()
        //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
    }
    
    /**
     * Update title of value button and selected row in number picker
     * - parameter value: String value
     */
    private func updateValue(value: String) {
        self._config.name = value
        self._valButton.setTitle(value, for: UIControlState())
        //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
//        self._numberPicker.selectRow(Int(value)!, inComponent: 0, animated: true)
        //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
    }
    
    
    func checkChanged(_ sender: AnyObject) {
        //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
//        if self._checkBox.bChecked {
//            if BaseModel.shared.getDebugShowNumPickerFlag() {
//                showNumberPicker()
//            }
//        } else {
//            if BaseModel.shared.getDebugShowNumPickerFlag() {
//                self._viewBlur.removeFromSuperview()
//            }
//            //self._valButton.setTitle(DomainConst.NUMBER_ZERO_VALUE, for: UIControlState())
//            updateValue(value: DomainConst.NUMBER_ZERO_VALUE)
//        }
        //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
        //++ BUG0063-SPJ (NguyenPT 20170520) Fix bug: Set check when value is not zero
        if _checkBox.bChecked  {    // Checked
            if self._config.name == DomainConst.NUMBER_ZERO_VALUE { // Value = 0
                updateValue(value: DomainConst.NUMBER_ONE_VALUE)    // Set value = 1
            }
        } else {                    // Unchecked
            if self._config.name != DomainConst.NUMBER_ZERO_VALUE { // Value != 0
                updateValue(value: DomainConst.NUMBER_ZERO_VALUE)   // Set value = 0
            }
        }
        //-- BUG0063-SPJ (NguyenPT 20170520) Fix bug: Set check when value is not zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.frame.width / 3
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return self.frame.height
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
//    public func getValue() -> Int {
//        return self._numberPicker.selectedRow(inComponent: 0)
//    }
    //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
//        pickerView.removeFromSuperview()
//        self._viewBlur.removeFromSuperview()
//        self._config.name = String(row)
//        self._button.setTitle(String(row), for: UIControlState())
//        self._valButton.setTitle(String(row), for: UIControlState())
        //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
    }
    
    /**
     * Get config value
     * - returns: Config value
     */
    public func getSelectorValue() -> ConfigBean {
        return _config
    }
    
    /**
     * Get check value
     * - returns: Check box value
     */
    public func getCheckValue() -> Bool {
        return self._checkBox.bChecked
    }
}
