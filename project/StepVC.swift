//
//  StepVC.swift
//  project
//
//  Created by Nixforest on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
class StepVC: CommonViewController, UIScrollViewDelegate {
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
        // Setup button Next
        // Setup button Send
        // Setup list step button
        _listButton.btnTapped = btnReplyUpholdTapped
        self.view.addSubview(_listButton)
    }
    override func viewDidLayoutSubviews() {
        _listButton._numberOfBtn = _numberStep
        _listButton.translatesAutoresizingMaskIntoConstraints = true
        _listButton.frame = CGRect(
            x: 0,
            y: 300,
            width: self.view.frame.width,
            height: GlobalConst.SCROLL_BUTTON_LIST_HEIGHT)
        _listButton.setup(height: self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height)
        _listButton.moveNext()
    }
    func btnReplyUpholdTapped(_ sender: AnyObject) {
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
}
