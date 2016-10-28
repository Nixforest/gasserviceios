//
//  StepVC.swift
//  project
//
//  Created by Nixforest on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
class StepVC: CommonViewController, UIScrollViewDelegate, ScrollButtonListDelegate {
    // MARK: Properties
    /** Step number */
    var _numberStep: Int                = 0
    /** Content */
    var _arrayContent: [StepContent]    = [StepContent]()
    /** Summary */
    var _summary: StepSummary           = StepSummary()
    /** Current step */
    var _currentStep: Int               = 0
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
    }
    
    override func viewDidLayoutSubviews() {
        // Set up buttons
        setupButtons()
        // Setup list step button
        setupListButton()
        
        // Setup step contents
        for i in 0..<(_numberStep - 1) {
            self.view.addSubview(self._arrayContent[i])
        }
    }
    
    /**
     * Set list of content views
     * - parameter listContent: List of content views
     */
    func setListContents(listContent: [StepContent]) {
        if listContent.count == _numberStep {
            for item in listContent {
                self._arrayContent.append(item)
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
        _listButton.btnTapDelegate = self    }
    
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
    }
    
    /**
     * Handle when tap on button in scroll list
     * - parameter sender: Button is tapped
     */
    func selectButton(_ sender: AnyObject) {
        moveTo(current: sender.tag)
    }
    
    /**
     * Handle next tap button
     */
    func btnNextTapper() {
        moveNext()
    }
    
    /**
     * Handle back tap button
     */
    func btnBackTapper() {
        moveBack()
    }
    
    /**
     * Move next screen
     */
    func moveNext() {
        _listButton.moveNext()
    }
    
    /**
     * Move previous screen
     */
    func moveBack() {
        _listButton.moveBack()
    }
    
    /**
     * Move to specific screen
     * - parameter current: Screen index
     */
    func moveTo(current: Int) {
        _listButton.moveTo(current: current)
    }
}
