//
//  StepVC.swift
//  project
//
//  Created by Nixforest on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
class StepVC: CommonViewController, UIScrollViewDelegate, ScrollButtonListDelegate {
    /** Step number */
    var _numberStep = 0
    /** Content */
    var _arrayContent: [StepContent] = [StepContent]()
    /** Summary */
    var _summary: StepSummary = StepSummary()
    /** Current step */
    var _currentStep = 0
    /** Back step button */
    var _btnBack = UIButton()
    /** Next step button */
    var _btnNext = UIButton()
    /** Send button */
    var _btnSend = UIButton()
    /** Scrollbutton list */
    var _listButton: ScrollButtonList = ScrollButtonList()
    
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
        // Set up button Back
        _btnBack.translatesAutoresizingMaskIntoConstraints = true
        _btnBack.frame = CGRect(
            x: 0,
            y: self.view.frame.height - GlobalConst.SCROLL_BUTTON_LIST_HEIGHT - GlobalConst.BUTTON_H,
            width: GlobalConst.BUTTON_H,
            height: GlobalConst.BUTTON_H)
        _btnBack.setImage(UIImage(named: "back.png"), for: UIControlState())
        _btnBack.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        _btnBack.tintColor = UIColor.white
        _btnBack.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        // Set up button Next
        _btnNext.translatesAutoresizingMaskIntoConstraints = true
        _btnNext.frame = CGRect(
            x: self.view.frame.width - GlobalConst.BUTTON_H,
            y: self.view.frame.height - GlobalConst.SCROLL_BUTTON_LIST_HEIGHT - GlobalConst.BUTTON_H,
            width: GlobalConst.BUTTON_H,
            height: GlobalConst.BUTTON_H)
        _btnNext.setImage(UIImage(named: "back.png"), for: UIControlState())
        _btnNext.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
        _btnNext.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        _btnNext.tintColor = UIColor.white
        _btnNext.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        // Setup button Send
        _btnSend.translatesAutoresizingMaskIntoConstraints = true
        _btnSend.frame = CGRect(
            x: (GlobalConst.SCREEN_WIDTH) / 2  - GlobalConst.BUTTON_H,
            y: self.view.frame.height - GlobalConst.SCROLL_BUTTON_LIST_HEIGHT - GlobalConst.BUTTON_H,
            width: GlobalConst.BUTTON_H * 2,
            height: GlobalConst.BUTTON_H)
        _btnSend.setTitle("Gửi", for: .normal)
        _btnSend.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        _btnSend.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        _btnSend.tintColor = UIColor.white
        // Setup list step button
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
    func btnNextTapper() {
        _listButton.moveNext()
    }
    func selectButton(_ sender: AnyObject) {
        switch sender.tag {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
        _listButton.moveTo(current: sender.tag)
    }
    func btnBackTapper() {
        _listButton.moveBack()
    }
}
