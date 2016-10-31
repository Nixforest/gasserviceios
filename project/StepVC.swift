//
//  StepVC.swift
//  project
//
//  Created by Nixforest on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
class StepVC: CommonViewController, UIScrollViewDelegate, ScrollButtonListDelegate, UIPopoverPresentationControllerDelegate {
    // MARK: Properties
    /** Step number */
    var _numberStep: Int                = 0
    /** Content */
    var _arrayContent: [StepContent]    = [StepContent]()
    /** Summary */
    var _summary: StepSummary           = StepSummary()
    /** Current step */
    var _currentStep: Int               = -1
    /** Back step button */
    var _btnBack: UIButton              = UIButton()
    /** Next step button */
    var _btnNext: UIButton              = UIButton()
    /** Send button */
    var _btnSend: UIButton              = UIButton()
    /** Scrollbutton list */
    var _listButton: ScrollButtonList   = ScrollButtonList()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up button Back
        self.view.addSubview(_btnBack)
        _btnBack.addTarget(self, action: #selector(btnBackTapper), for: .touchUpInside)
        // Setup button Next
        self.view.addSubview(_btnNext)
        _btnNext.addTarget(self, action: #selector(btnNextTapper), for: .touchUpInside)
        // Setup button Send
        self.view.addSubview(_btnSend)
        // Setup list step button
        self.view.addSubview(_listButton)
        self.moveNext()
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        // Setup navigation bar
        setupNavigationBar(title: GlobalConst.CONTENT00186, isNotifyEnable: Singleton.sharedInstance.checkIsLogin())
    }
    
    override func viewDidLayoutSubviews() {
        // Set up buttons
        setupButtons()
        // Setup list step button
        setupListButton()
        
        // Setup step contents
        for i in 0..<(_numberStep - 2) {
            self.view.addSubview(self._arrayContent[i])
        }
    }
    
    /**
     * Set list of content views
     * - parameter listContent: List of content views
     */
    func setListContents(listContent: [StepContent]) {
        if listContent.count == (_numberStep - 1) {
            for item in listContent {
                self._arrayContent.append(item)
                item.isHidden = true
            }
        }
    }
    
    /**
     * Set up layout for list buttons.
     */
    func setupListButton() {
        _listButton._numberOfBtn = _numberStep
        _listButton.translatesAutoresizingMaskIntoConstraints = true
        _listButton.frame = CGRect(
            x: 0,
            y: self.view.frame.height - GlobalConst.SCROLL_BUTTON_LIST_HEIGHT,
            width: self.view.frame.width,
            height: GlobalConst.SCROLL_BUTTON_LIST_HEIGHT)
        _listButton.setup()
        _listButton.btnTapDelegate = self
    }
    
    /**
     * Set up buttons: Back, Next, Send
     */
    func setupButtons() {
        // Set up button Back
        _btnBack.translatesAutoresizingMaskIntoConstraints = true
        _btnBack.frame = CGRect(
            x: 0,
            y: self.view.frame.height - GlobalConst.SCROLL_BUTTON_LIST_HEIGHT - GlobalConst.BUTTON_H,
            width: GlobalConst.BUTTON_H,
            height: GlobalConst.BUTTON_H)
        _btnBack.setImage(UIImage(named: "back.png"), for: UIControlState())
        _btnBack.backgroundColor    = GlobalConst.BUTTON_COLOR_RED
        _btnBack.tintColor          = UIColor.white
        _btnBack.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        //_btnBack.isHidden           = true
        
        // Set up button Next
        _btnNext.translatesAutoresizingMaskIntoConstraints = true
        _btnNext.frame = CGRect(
            x: self.view.frame.width - GlobalConst.BUTTON_H,
            y: self.view.frame.height - GlobalConst.SCROLL_BUTTON_LIST_HEIGHT - GlobalConst.BUTTON_H,
            width: GlobalConst.BUTTON_H,
            height: GlobalConst.BUTTON_H)
        _btnNext.setImage(UIImage(named: "back.png"), for: UIControlState())
        _btnNext.transform          = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
        _btnNext.backgroundColor    = GlobalConst.BUTTON_COLOR_RED
        _btnNext.tintColor          = UIColor.white
        _btnNext.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        //_btnNext.isHidden           = true
        
        // Setup button Send
        _btnSend.translatesAutoresizingMaskIntoConstraints = true
        _btnSend.frame = CGRect(
            x: (GlobalConst.SCREEN_WIDTH) / 2  - GlobalConst.BUTTON_H,
            y: self.view.frame.height - GlobalConst.SCROLL_BUTTON_LIST_HEIGHT - GlobalConst.BUTTON_H,
            width: GlobalConst.BUTTON_H * 2,
            height: GlobalConst.BUTTON_H)
        _btnSend.setTitle(GlobalConst.CONTENT00180, for: .normal)
        _btnSend.backgroundColor    = GlobalConst.BUTTON_COLOR_RED
        _btnSend.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        _btnSend.tintColor          = UIColor.white
        _btnSend.isHidden           = true
    }
    
    /**
     * Handle when tap on button in scroll list
     * - parameter sender: Button is tapped
     */
    func selectButton(_ sender: AnyObject) {
        // Current is summary
        if self._currentStep == (self._numberStep - 1) {
            moveTo(current: sender.tag)
        } else if (self._currentStep >= 0) {
            if self._arrayContent[self._currentStep].checkDone() {
                moveTo(current: sender.tag)
            }
        }
    }
    
    /**
     * Handle next tap button
     */
    func btnNextTapper() {
        if self._currentStep < (self._numberStep - 1) {
            if self._arrayContent[self._currentStep].checkDone() {
                moveNext()
            }
        }
    }
    
    /**
     * Handle back tap button
     */
    func btnBackTapper() {
        // Current is summary
        if self._currentStep == (self._numberStep - 1) {
            moveBack()
        } else if (self._currentStep > 0) {
            if self._arrayContent[self._currentStep].checkDone() {
                moveBack()
            }
        }
    }
    
    /**
     * Move next screen
     */
    func moveNext() {
        if _currentStep == -1 {
            _currentStep += 1
            if _numberStep > 0 {
                _arrayContent[_currentStep].isHidden = false
            }
        } else if (_currentStep < (_numberStep - 2)) {
            _arrayContent[_currentStep].isHidden = true
            _currentStep += 1
            _listButton.moveNext()
            _arrayContent[_currentStep].isHidden = false
        } else if _currentStep == (_numberStep - 2) {
            _currentStep += 1
            _listButton.moveNext()
            _summary.isHidden = false
        }
        updateButton()
    }
    
    /**
     * Move previous screen
     */
    func moveBack() {
        if _currentStep > 0 {
            if _currentStep == (_numberStep - 1) {
                _summary.isHidden = true
                _currentStep -= 1
                _arrayContent[_currentStep].isHidden = false
                _listButton.moveBack()
            } else {
                _arrayContent[_currentStep].isHidden = true
                _currentStep -= 1
                _arrayContent[_currentStep].isHidden = false
                _listButton.moveBack()
            }
        }
        updateButton()
    }
    
    /**
     * Move to specific screen
     * - parameter current: Screen index
     */
    func moveTo(current: Int) {
        if ((current < _numberStep) && (current >= 0) && (current != _currentStep)) {
            // Current screen is summary screen
            if _currentStep == (_numberStep - 1) {
                _summary.isHidden = true
                _currentStep = current
                _arrayContent[_currentStep].isHidden = false
            } else if current == (_numberStep - 1) {
                _arrayContent[_currentStep].isHidden = true
                _currentStep = current
                _summary.isHidden = false
            } else {
                _arrayContent[_currentStep].isHidden = true
                _currentStep = current
                _arrayContent[_currentStep].isHidden = false
            }
            _listButton.moveTo(current: current)
        }
        updateButton()
    }
    
    /**
     * Update show/hide status of back-next-send button
     */
    func updateButton() {
        if _currentStep == 0 {
            _btnBack.isHidden = true
        }
        if _currentStep == (_numberStep - 1) {
            _btnNext.isHidden = true
            _btnSend.isHidden = false
        }
        if _currentStep < (_numberStep - 1) {
            _btnNext.isHidden = false
        }
        if _currentStep > 0 {
            _btnBack.isHidden = false
        }
    }
    func appendContent(stepContent: StepContent) {
        let height = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        stepContent.translatesAutoresizingMaskIntoConstraints = true
        stepContent.frame = CGRect(
            x: 0,
            y: height,
            width: GlobalConst.SCREEN_WIDTH,
            height: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT))
        self.view.addSubview(stepContent)
    }
    func appendSummary(summary: StepSummary) {
        let height = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        summary.translatesAutoresizingMaskIntoConstraints = true
        summary.frame = CGRect(
            x: 0,
            y: height,
            width: GlobalConst.SCREEN_WIDTH,
            height: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT))
        summary.isHidden = true
        self._summary = summary
        self.view.addSubview(summary)
    }
    
    /**
     * Override: show menu controller
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GlobalConst.POPOVER_MENU_IDENTIFIER {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    
    /**
     * ...
     */
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
