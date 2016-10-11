//
//  ReplyUpholdViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/1/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ReplyUpholdViewController: UIViewController {
    
    static let sharedInstance: ReplyUpholdViewController = {
        let instance = ReplyUpholdViewController()
        return instance
    }()
    
    static var valStep0 = String()
    static var valStep1 = String()
    static var valStep2 = String()
    static var valNameStep3 = String()
    static var valPhoneStep3 = String()
    static var valStep4 = String()
    static var valStep5 :[UIImage] = []
    
    
    
    var arrayCtnView:[Int] = [0, 1, 2, 3, 4, 5, 6]
    
    var isStep0Done:Bool = false
    var isStep1Done:Bool = false
    var isStep2Done:Bool = false
    var isStep3Done:Bool = false
    var isStep4Done:Bool = false
    var isStep5Done:Bool = false
    var isStep6Done:Bool = false
    
    // MARK: - Outlet declare
    @IBOutlet weak var viewBackground: UIView!
    
    
    @IBOutlet weak var ctnviewReplyUpholdStep0: UIView!
    @IBOutlet weak var ctnviewReplyUpholdStep1: UIView!
    @IBOutlet weak var ctnviewReplyUpholdStep2: UIView!
    @IBOutlet weak var ctnviewReplyUpholdStep3: UIView!
    @IBOutlet weak var ctnviewReplyUpholdStep4: UIView!
    @IBOutlet weak var ctnviewReplyUpholdStep5: UIView!
    @IBOutlet weak var ctnviewReplyUpholdStep6: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    
    
    // MARK: - show containerView
    func showContainerView(aCtnView: UIView) {
       
        switch aCtnView.tag {
        case 0:
            ctnviewReplyUpholdStep0.isHidden = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep0ButtonToMiddle"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "hideBtnBack"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnNext"), object: nil)
            ctnviewReplyUpholdStep1.isHidden = true
            ctnviewReplyUpholdStep2.isHidden = true
            ctnviewReplyUpholdStep3.isHidden = true
            ctnviewReplyUpholdStep4.isHidden = true
            ctnviewReplyUpholdStep5.isHidden = true
            ctnviewReplyUpholdStep6.isHidden = true
        case 1:
            ctnviewReplyUpholdStep0.isHidden = true
            ctnviewReplyUpholdStep1.isHidden = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep1ButtonToMiddle"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnBack"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnNext"), object: nil)
            ctnviewReplyUpholdStep2.isHidden = true
            ctnviewReplyUpholdStep3.isHidden = true
            ctnviewReplyUpholdStep4.isHidden = true
            ctnviewReplyUpholdStep5.isHidden = true
            ctnviewReplyUpholdStep6.isHidden = true
        case 2:
            ctnviewReplyUpholdStep0.isHidden = true
            ctnviewReplyUpholdStep1.isHidden = true
            ctnviewReplyUpholdStep2.isHidden = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep2ButtonToMiddle"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnBack"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnNext"), object: nil)
            ctnviewReplyUpholdStep3.isHidden = true
            ctnviewReplyUpholdStep4.isHidden = true
            ctnviewReplyUpholdStep5.isHidden = true
            ctnviewReplyUpholdStep6.isHidden = true
        case 3:
            ctnviewReplyUpholdStep0.isHidden = true
            ctnviewReplyUpholdStep1.isHidden = true
            ctnviewReplyUpholdStep2.isHidden = true
            ctnviewReplyUpholdStep3.isHidden = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep3ButtonToMiddle"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnBack"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnNext"), object: nil)
            ctnviewReplyUpholdStep4.isHidden = true
            ctnviewReplyUpholdStep5.isHidden = true
            ctnviewReplyUpholdStep6.isHidden = true
        case 4:
            ctnviewReplyUpholdStep0.isHidden = true
            ctnviewReplyUpholdStep1.isHidden = true
            ctnviewReplyUpholdStep2.isHidden = true
            ctnviewReplyUpholdStep3.isHidden = true
            ctnviewReplyUpholdStep4.isHidden = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep4ButtonToMiddle"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnBack"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnNext"), object: nil)
            ctnviewReplyUpholdStep5.isHidden = true
            ctnviewReplyUpholdStep6.isHidden = true
        case 5:
            ctnviewReplyUpholdStep0.isHidden = true
            ctnviewReplyUpholdStep1.isHidden = true
            ctnviewReplyUpholdStep2.isHidden = true
            ctnviewReplyUpholdStep3.isHidden = true
            ctnviewReplyUpholdStep4.isHidden = true
            ctnviewReplyUpholdStep5.isHidden = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep5ButtonToMiddle"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnBack"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnNext"), object: nil)
            ctnviewReplyUpholdStep6.isHidden = true
        case 6:
            ctnviewReplyUpholdStep0.isHidden = true
            ctnviewReplyUpholdStep1.isHidden = true
            ctnviewReplyUpholdStep2.isHidden = true
            ctnviewReplyUpholdStep3.isHidden = true
            ctnviewReplyUpholdStep4.isHidden = true
            ctnviewReplyUpholdStep5.isHidden = true
            ctnviewReplyUpholdStep6.isHidden = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep6ButtonToMiddle"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnBack"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "hideBtnNext"), object: nil)
        default:
            break
        }
    }
    
    
    
    @IBOutlet weak var scrViewButton: UIView!
    
    @IBOutlet weak var btnReplyUpholdStep0: UIButton!
    @IBOutlet weak var btnReplyUpholdStep1: UIButton!
    @IBOutlet weak var btnReplyUpholdStep2: UIButton!
    @IBOutlet weak var btnReplyUpholdStep3: UIButton!
    @IBOutlet weak var btnReplyUpholdStep4: UIButton!
    @IBOutlet weak var btnReplyUpholdStep5: UIButton!
    @IBOutlet weak var btnReplyUpholdStep6: UIButton!

    // MARK: - Button Action
    
    @IBAction func btnBackTapped(_ sender: AnyObject) {
        if ctnviewReplyUpholdStep1.isHidden == false {
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep0)
        }
        if ctnviewReplyUpholdStep2.isHidden == false {
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep1)
        }
        if ctnviewReplyUpholdStep3.isHidden == false {
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep2)
        }
        if ctnviewReplyUpholdStep4.isHidden == false {
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep3)
        }
        if ctnviewReplyUpholdStep5.isHidden == false {
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep4)
        }
        if ctnviewReplyUpholdStep6.isHidden == false {
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep5)
        }
    }
    @IBAction func btnNextTapped(_ sender: AnyObject) {
        // 0->1
        if ctnviewReplyUpholdStep0.isHidden == false {
            checkValidData(viewStep: ctnviewReplyUpholdStep0)
        }else {
            // 1->2
            if ctnviewReplyUpholdStep1.isHidden == false {
                    checkValidData(viewStep: ctnviewReplyUpholdStep1)
            }else {
                // 2->3
                if ctnviewReplyUpholdStep2.isHidden == false {
                        checkValidData(viewStep: ctnviewReplyUpholdStep2)
                }else {
                    // 3->4
                    if ctnviewReplyUpholdStep3.isHidden == false {
                            checkValidData(viewStep: ctnviewReplyUpholdStep3)
                    }else {
                        //4->5
                        if ctnviewReplyUpholdStep4.isHidden == false {
                                checkValidData(viewStep: ctnviewReplyUpholdStep4)
                        } else {
                            //5->6
                            if ctnviewReplyUpholdStep5.isHidden == false {
                                    checkValidData(viewStep: ctnviewReplyUpholdStep5)
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "showValue"), object: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    /**
     * Step Button Tapped
     */
    @IBAction func btnReplyUpholdStep0Tapped(_ sender: AnyObject) {
        print(sender.tag)
        switch sender.tag {
        case 0:
                self.showContainerView(aCtnView: self.ctnviewReplyUpholdStep0)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep0ButtonToMiddle"), object: nil)
        case 1:
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep1)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep1ButtonToMiddle"), object: nil)
        case 2:
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep2)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep2ButtonToMiddle"), object: nil)
        case 3:
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep3)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep3ButtonToMiddle"), object: nil)
        case 4:
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep4)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep4ButtonToMiddle"), object: nil)
        case 5:
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep4)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep4ButtonToMiddle"), object: nil)
        case 6:
            self.showContainerView(aCtnView: ctnviewReplyUpholdStep6)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep6ButtonToMiddle"), object: nil)
        default:
            break
        }
    }
    
    
    // MARK: - move button to middle of line
    func moveStep0ButtonToMiddle(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnReplyUpholdStep0)
        //check status of Button
        
        setBtnColor(aButton: btnReplyUpholdStep1)
        setBtnColor(aButton: btnReplyUpholdStep2)
        setBtnColor(aButton: btnReplyUpholdStep3)
        setBtnColor(aButton: btnReplyUpholdStep4)
        setBtnColor(aButton: btnReplyUpholdStep5)
        setBtnColor(aButton: btnReplyUpholdStep6)
    }
    func moveStep1ButtonToMiddle(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnReplyUpholdStep1)
        //check status of Button
        setBtnColor(aButton: btnReplyUpholdStep0)
        
        setBtnColor(aButton: btnReplyUpholdStep2)
        setBtnColor(aButton: btnReplyUpholdStep3)
        setBtnColor(aButton: btnReplyUpholdStep4)
        setBtnColor(aButton: btnReplyUpholdStep5)
        setBtnColor(aButton: btnReplyUpholdStep6)
    }
    func moveStep2ButtonToMiddle(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnReplyUpholdStep2)
        //check status of Button
        setBtnColor(aButton: btnReplyUpholdStep0)
        setBtnColor(aButton: btnReplyUpholdStep1)
        
        setBtnColor(aButton: btnReplyUpholdStep3)
        setBtnColor(aButton: btnReplyUpholdStep4)
        setBtnColor(aButton: btnReplyUpholdStep5)
        setBtnColor(aButton: btnReplyUpholdStep6)
    }
    func moveStep3ButtonToMiddle(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnReplyUpholdStep3)
        //check status of Button
        setBtnColor(aButton: btnReplyUpholdStep0)
        setBtnColor(aButton: btnReplyUpholdStep1)
        setBtnColor(aButton: btnReplyUpholdStep2)
        
        setBtnColor(aButton: btnReplyUpholdStep4)
        setBtnColor(aButton: btnReplyUpholdStep5)
        setBtnColor(aButton: btnReplyUpholdStep6)
    }
    func moveStep4ButtonToMiddle(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnReplyUpholdStep4)
        //check status of Button
        setBtnColor(aButton: btnReplyUpholdStep0)
        setBtnColor(aButton: btnReplyUpholdStep1)
        setBtnColor(aButton: btnReplyUpholdStep2)
        setBtnColor(aButton: btnReplyUpholdStep3)
        
        setBtnColor(aButton: btnReplyUpholdStep5)
        setBtnColor(aButton: btnReplyUpholdStep6)
    }
    func moveStep5ButtonToMiddle(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnReplyUpholdStep5)
        //check status of Button
        setBtnColor(aButton: btnReplyUpholdStep0)
        setBtnColor(aButton: btnReplyUpholdStep1)
        setBtnColor(aButton: btnReplyUpholdStep2)
        setBtnColor(aButton: btnReplyUpholdStep3)
        setBtnColor(aButton: btnReplyUpholdStep4)
        
        setBtnColor(aButton: btnReplyUpholdStep6)
    }
    func moveStep6ButtonToMiddle(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnReplyUpholdStep6)
        //check status of Button
        setBtnColor(aButton: btnReplyUpholdStep0)
        setBtnColor(aButton: btnReplyUpholdStep1)
        setBtnColor(aButton: btnReplyUpholdStep2)
        setBtnColor(aButton: btnReplyUpholdStep3)
        setBtnColor(aButton: btnReplyUpholdStep4)
        setBtnColor(aButton: btnReplyUpholdStep5)
        
    }
    
    func moveButtonToMiddle(aButton:UIButton) {
        switch aButton.tag {
        case 0:
            scrViewButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) + GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        case 1:
            scrViewButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) - (GlobalConst.BUTTON_HEIGHT) + GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        case 2:
            scrViewButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) - (GlobalConst.BUTTON_HEIGHT * 2) + GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        case 3:
            scrViewButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) - (GlobalConst.BUTTON_HEIGHT * 3) + GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        case 4:
            scrViewButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) - (GlobalConst.BUTTON_HEIGHT * 4) + GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        case 5:
            scrViewButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) - (GlobalConst.BUTTON_HEIGHT * 5) + GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        case 6:
            scrViewButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) - (GlobalConst.BUTTON_HEIGHT * 6) + GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        default:
            break
        }
        aButton.backgroundColor = GlobalConst.BUTTON_COLOR_SELECTING
    }
    
    // MARK: - Set button color
    func setBtnColor(aButton: UIButton) {
        if aButton.isEnabled == true {
            aButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        } else {
            aButton.backgroundColor = GlobalConst.BUTTON_COLOR_DISABLE
        }
    }
    
    // MARK: - Next Step Notification
    func toStep1(_ notification: Notification) {
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep1)
    }
    func toStep2(_ notification: Notification) {
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep2)
    }
    func toStep3(_ notification: Notification) {
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep3)
    }
    func toStep4(_ notification: Notification) {
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep4)
    }
    func toStep5(_ notification: Notification) {
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep5)
    }
    func toStep6(_ notification: Notification) {
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep6)
    }
    
    
    // MARK: - Step done
    func step0Done (_ notification: Notification) {
        isStep0Done = true
        btnReplyUpholdStep0.isEnabled = isStep0Done
        btnReplyUpholdStep1.isEnabled = isStep0Done
        btnReplyUpholdStep0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep1)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep1ButtonToMiddle"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnBack"), object: nil)
    }
    func step1Done (_ notification: Notification) {
        isStep1Done = true
        
        btnReplyUpholdStep2.isEnabled = isStep1Done
        btnReplyUpholdStep1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep2)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep2ButtonToMiddle"), object: nil)
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "showCtnViewStep2"), object: nil)
    }
    func step2Done (_ notification: Notification) {
        isStep2Done = true
        
        btnReplyUpholdStep3.isEnabled = isStep2Done
        btnReplyUpholdStep2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep3)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep3ButtonToMiddle"), object: nil)
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "showCtnViewStep3"), object: nil)
    }
    func step3Done (_ notification: Notification) {
        isStep3Done = true
        
        btnReplyUpholdStep4.isEnabled = isStep3Done
        btnReplyUpholdStep3.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep4)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep4ButtonToMiddle"), object: nil)
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "showCtnViewStep4"), object: nil)
    }
    func step4Done (_ notification: Notification) {
        isStep4Done = true
        btnReplyUpholdStep5.isEnabled = isStep4Done
        btnReplyUpholdStep4.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep5)
        //ReplyUpholdStep4ViewController.sharedInstance.txtvStep4.becomeFirstResponder()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep5ButtonToMiddle"), object: nil)
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "showCtnViewStep5"), object: nil)
    }
    func step5Done (_ notification: Notification) {
        isStep5Done = true
        btnReplyUpholdStep6.isEnabled = isStep5Done
        btnReplyUpholdStep5.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self.showContainerView(aCtnView: ctnviewReplyUpholdStep6)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep6ButtonToMiddle"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "hideBtnNext"), object: nil)
    }
    func step6Done (_ notification: Notification) {
        isStep6Done = true
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep6ButtonToMiddle"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCtnViewStep6"), object: nil)
    }
    
    func showBtnBack(_ notification: Notification) {
        if ctnviewReplyUpholdStep0.isHidden == true {
            btnBack.isHidden = false
        }
    }
    func hideBtnNext(_ notification: Notification) {
        if ctnviewReplyUpholdStep6.isHidden == false {
            btnNext.isHidden = true
        }
    }
    func hideBtnBack(_ notification: Notification) {
        if ctnviewReplyUpholdStep0.isHidden == false {
            btnBack.isHidden = true
        }
    }
    func showBtnNext(_ notification: Notification) {
        if ctnviewReplyUpholdStep6.isHidden == true {
            btnNext.isHidden = false
        }
    }
    
    // MARK: - check valid data in Step
    func checkValidData(viewStep: UIView) {
        switch viewStep.tag {
        case 0:
            if ReplyUpholdViewController.valStep0.isEmpty == true {
                let nextAlert = UIAlertController(title: "",
                                                  message: GlobalConst.CONTENT00028,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: GlobalConst.CONTENT00008,
                                             style: .cancel,
                                             handler: {(notificationAlert) -> Void in ()})
                nextAlert.addAction(okAction)
                self.present(nextAlert, animated: true, completion: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "step0Done"), object: nil)
                self.showContainerView(aCtnView: ctnviewReplyUpholdStep1)
            }
        case 1:
            if ReplyUpholdViewController.valStep1.isEmpty == true {
                let nextAlert = UIAlertController(title: "",
                                                  message: GlobalConst.CONTENT00028,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: GlobalConst.CONTENT00008,
                                             style: .cancel,
                                             handler: {(notificationAlert) -> Void in ()})
                nextAlert.addAction(okAction)
                self.present(nextAlert, animated: true, completion: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "step1Done"), object: nil)
                self.showContainerView(aCtnView: ctnviewReplyUpholdStep2)
            }
        case 2:
            if ReplyUpholdViewController.valStep2.isEmpty == true {
                let nextAlert = UIAlertController(title: "",
                                                  message: GlobalConst.CONTENT00028,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: GlobalConst.CONTENT00008,
                                             style: .cancel,
                                             handler: {(notificationAlert) -> Void in ()})
                nextAlert.addAction(okAction)
                self.present(nextAlert, animated: true, completion: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "step2Done"), object: nil)
                self.showContainerView(aCtnView: ctnviewReplyUpholdStep3)
            }

        case 3:
            if (ReplyUpholdViewController.valNameStep3.isEmpty == true) || (ReplyUpholdViewController.valPhoneStep3.isEmpty == true) {
                let nextAlert = UIAlertController(title: "",
                                                  message: GlobalConst.CONTENT00028,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: GlobalConst.CONTENT00008,
                                             style: .cancel,
                                             handler: {(notificationAlert) -> Void in ()})
                nextAlert.addAction(okAction)
                self.present(nextAlert, animated: true, completion: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "step3Done"), object: nil)
                self.showContainerView(aCtnView: ctnviewReplyUpholdStep4)
            }

        case 4:
            if ReplyUpholdViewController.valStep4.isEmpty == true {
                print(ReplyUpholdViewController.valStep4)
                let nextAlert = UIAlertController(title: "",
                                                  message: GlobalConst.CONTENT00028,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: GlobalConst.CONTENT00008,
                                             style: .cancel,
                                             handler: {(notificationAlert) -> Void in ()})
                nextAlert.addAction(okAction)
                self.present(nextAlert, animated: true, completion: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "step4Done"), object: nil)
                self.showContainerView(aCtnView: ctnviewReplyUpholdStep5)
            }
        case 5:
            if ReplyUpholdViewController.valStep5.isEmpty == true {
                let nextAlert = UIAlertController(title: "",
                                                  message: GlobalConst.CONTENT00028,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: GlobalConst.CONTENT00008,
                                             style: .cancel,
                                             handler: {(notificationAlert) -> Void in ()})
                nextAlert.addAction(okAction)
                self.present(nextAlert, animated: true, completion: nil)
            } else {
                self.showContainerView(aCtnView: ctnviewReplyUpholdStep6)
            }

        default:
            break
        }
    }

    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Background
        viewBackground.translatesAutoresizingMaskIntoConstraints = true
        viewBackground.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        viewBackground.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        viewBackground.frame = CGRect(x: 0, y: (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT), width: (GlobalConst.SCREEN_WIDTH), height: (GlobalConst.SCREEN_HEIGHT - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT)))
        viewBackground.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        btnBack.translatesAutoresizingMaskIntoConstraints = true
        btnBack.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.PARENT_BORDER_WIDTH - GlobalConst.BUTTON_HEIGHT * 2, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        btnBack.setImage(UIImage(named: "back.png"), for: UIControlState())
        btnBack.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnBack.tintColor = UIColor.white
        btnBack.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        btnBack.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnBack.layer.borderColor = GlobalConst.BUTTON_COLOR_GRAY.cgColor
        btnBack.isHidden = !isStep0Done
        viewBackground.addSubview(btnBack)
        
        btnNext.translatesAutoresizingMaskIntoConstraints = true
        btnNext.frame = CGRect(x: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH - GlobalConst.BUTTON_HEIGHT, y: viewBackground.frame.size.height - GlobalConst.PARENT_BORDER_WIDTH - GlobalConst.BUTTON_HEIGHT * 2, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        btnNext.setImage(UIImage(named: "back.png"), for: UIControlState())
        btnNext.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
        btnNext.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnNext.tintColor = UIColor.white
        btnNext.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        btnNext.layer.borderColor = GlobalConst.BUTTON_COLOR_GRAY.cgColor
        btnNext.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnNext.isHidden = isStep5Done
        viewBackground.addSubview(btnNext)
        
        // MARK: - containerView show/hide in initiation
        ctnviewReplyUpholdStep0.isHidden = false
        ctnviewReplyUpholdStep1.isHidden = true
        ctnviewReplyUpholdStep2.isHidden = true
        ctnviewReplyUpholdStep3.isHidden = true
        ctnviewReplyUpholdStep4.isHidden = true
        ctnviewReplyUpholdStep5.isHidden = true
        ctnviewReplyUpholdStep6.isHidden = true

        // MARK: - ContainerView Frame
        ctnviewReplyUpholdStep0.translatesAutoresizingMaskIntoConstraints = true
        ctnviewReplyUpholdStep0.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        ctnviewReplyUpholdStep0.tag = 0
        
        ctnviewReplyUpholdStep1.translatesAutoresizingMaskIntoConstraints = true
        ctnviewReplyUpholdStep1.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        ctnviewReplyUpholdStep1.tag = 1
        
        ctnviewReplyUpholdStep2.translatesAutoresizingMaskIntoConstraints = true
        ctnviewReplyUpholdStep2.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        ctnviewReplyUpholdStep2.tag = 2
        
        ctnviewReplyUpholdStep3.translatesAutoresizingMaskIntoConstraints = true
        ctnviewReplyUpholdStep3.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        ctnviewReplyUpholdStep3.tag = 3
        
        ctnviewReplyUpholdStep4.translatesAutoresizingMaskIntoConstraints = true
        ctnviewReplyUpholdStep4.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        ctnviewReplyUpholdStep4.tag = 4
        
        ctnviewReplyUpholdStep5.translatesAutoresizingMaskIntoConstraints = true
        ctnviewReplyUpholdStep5.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        ctnviewReplyUpholdStep5.tag = 5
        
        ctnviewReplyUpholdStep6.translatesAutoresizingMaskIntoConstraints = true
        ctnviewReplyUpholdStep6.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        ctnviewReplyUpholdStep6.tag = 6

        // MARK: - Scroll Button
        scrViewButton.translatesAutoresizingMaskIntoConstraints = true
        scrViewButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) + GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        scrViewButton.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        btnReplyUpholdStep0.translatesAutoresizingMaskIntoConstraints = true
        //btnReplyUpholdStep0.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnReplyUpholdStep0.layer.borderColor = UIColor.green.cgColor
        btnReplyUpholdStep0.frame = CGRect(x: 0, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        scrViewButton.addSubview(btnReplyUpholdStep0)
        btnReplyUpholdStep0.layer.cornerRadius = 0.5 * GlobalConst.BUTTON_HEIGHT
        btnReplyUpholdStep0.setTitle("1", for: .normal)
        btnReplyUpholdStep0.setTitleColor(UIColor.white , for: .normal)
        btnReplyUpholdStep0.backgroundColor = GlobalConst.BUTTON_COLOR_SELECTING
        btnReplyUpholdStep0.tag = 0
        
        btnReplyUpholdStep1.translatesAutoresizingMaskIntoConstraints = true
        btnReplyUpholdStep1.frame = CGRect(x: GlobalConst.BUTTON_HEIGHT, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        //btnReplyUpholdStep1.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnReplyUpholdStep1.layer.borderColor = UIColor.green.cgColor
        btnReplyUpholdStep1.layer.cornerRadius = 0.5 * GlobalConst.BUTTON_HEIGHT
        btnReplyUpholdStep1.setTitle("2", for: .normal)
        btnReplyUpholdStep1.setTitleColor(UIColor.white , for: .normal)
        btnReplyUpholdStep1.backgroundColor = GlobalConst.BUTTON_COLOR_DISABLE
        btnReplyUpholdStep1.tag = 1
        
        btnReplyUpholdStep2.translatesAutoresizingMaskIntoConstraints = true
        btnReplyUpholdStep2.frame = CGRect(x: GlobalConst.BUTTON_HEIGHT * 2, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        //btnReplyUpholdStep2.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnReplyUpholdStep2.layer.borderColor = UIColor.green.cgColor
        btnReplyUpholdStep2.layer.cornerRadius = 0.5 * GlobalConst.BUTTON_HEIGHT
        btnReplyUpholdStep2.setTitle("3", for: .normal)
        btnReplyUpholdStep2.setTitleColor(UIColor.white , for: .normal)
        btnReplyUpholdStep2.backgroundColor = GlobalConst.BUTTON_COLOR_DISABLE
        btnReplyUpholdStep2.tag = 2
        //
        btnReplyUpholdStep3.translatesAutoresizingMaskIntoConstraints = true
        btnReplyUpholdStep3.frame = CGRect(x: GlobalConst.BUTTON_HEIGHT * 3, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        //btnReplyUpholdStep3.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnReplyUpholdStep3.layer.borderColor = UIColor.green.cgColor
        btnReplyUpholdStep3.layer.cornerRadius = 0.5 * GlobalConst.BUTTON_HEIGHT
        btnReplyUpholdStep3.setTitle("4", for: .normal)
        btnReplyUpholdStep3.setTitleColor(UIColor.white , for: .normal)
        btnReplyUpholdStep3.backgroundColor = GlobalConst.BUTTON_COLOR_DISABLE
        btnReplyUpholdStep3.tag = 3
        
        btnReplyUpholdStep4.translatesAutoresizingMaskIntoConstraints = true
        btnReplyUpholdStep4.frame = CGRect(x: GlobalConst.BUTTON_HEIGHT * 4, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        //btnReplyUpholdStep4.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnReplyUpholdStep4.layer.borderColor = UIColor.green.cgColor
        btnReplyUpholdStep4.layer.cornerRadius = 0.5 * GlobalConst.BUTTON_HEIGHT
        btnReplyUpholdStep4.setTitle("5", for: .normal)
        btnReplyUpholdStep4.setTitleColor(UIColor.white , for: .normal)
        btnReplyUpholdStep4.backgroundColor = GlobalConst.BUTTON_COLOR_DISABLE
        btnReplyUpholdStep4.tag = 4
        
        btnReplyUpholdStep5.translatesAutoresizingMaskIntoConstraints = true
        btnReplyUpholdStep5.frame = CGRect(x: GlobalConst.BUTTON_HEIGHT * 5, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        //btnReplyUpholdStep5.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnReplyUpholdStep5.layer.borderColor = UIColor.green.cgColor
        btnReplyUpholdStep5.layer.cornerRadius = 0.5 * GlobalConst.BUTTON_HEIGHT
        btnReplyUpholdStep5.setTitle("6", for: .normal)
        btnReplyUpholdStep5.setTitleColor(UIColor.white , for: .normal)
        btnReplyUpholdStep5.backgroundColor = GlobalConst.BUTTON_COLOR_DISABLE
        btnReplyUpholdStep5.tag = 5
        
        btnReplyUpholdStep6.translatesAutoresizingMaskIntoConstraints = true
        btnReplyUpholdStep6.frame = CGRect(x: GlobalConst.BUTTON_HEIGHT * 6, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        
        btnReplyUpholdStep6.layer.cornerRadius = 0.5 * GlobalConst.BUTTON_HEIGHT
        btnReplyUpholdStep6.setTitle("7", for: .normal)
        btnReplyUpholdStep6.setTitleColor(UIColor.white , for: .normal)
        btnReplyUpholdStep6.backgroundColor = GlobalConst.BUTTON_COLOR_DISABLE
        btnReplyUpholdStep6.tag = 6

        btnReplyUpholdStep0.isEnabled = false
        btnReplyUpholdStep1.isEnabled = false
        btnReplyUpholdStep2.isEnabled = false
        btnReplyUpholdStep3.isEnabled = false
        btnReplyUpholdStep4.isEnabled = false
        btnReplyUpholdStep5.isEnabled = false
        btnReplyUpholdStep6.isEnabled = false
        
        // Do any additional setup after loading the view.
        // MARK: - Notification Center
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.step0Done(_:)), name:NSNotification.Name(rawValue: "step0Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.step1Done(_:)), name:NSNotification.Name(rawValue: "step1Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.step2Done(_:)), name:NSNotification.Name(rawValue: "step2Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.step3Done(_:)), name:NSNotification.Name(rawValue: "step3Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.step4Done(_:)), name:NSNotification.Name(rawValue: "step4Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.step5Done(_:)), name:NSNotification.Name(rawValue: "step5Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.step6Done(_:)), name:NSNotification.Name(rawValue: "step6Done"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.moveStep0ButtonToMiddle(_:)), name:NSNotification.Name(rawValue: "moveStep0ButtonToMiddle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.moveStep1ButtonToMiddle(_:)), name:NSNotification.Name(rawValue: "moveStep1ButtonToMiddle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.moveStep2ButtonToMiddle(_:)), name:NSNotification.Name(rawValue: "moveStep2ButtonToMiddle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.moveStep3ButtonToMiddle(_:)), name:NSNotification.Name(rawValue: "moveStep3ButtonToMiddle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.moveStep4ButtonToMiddle(_:)), name:NSNotification.Name(rawValue: "moveStep4ButtonToMiddle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.moveStep5ButtonToMiddle(_:)), name:NSNotification.Name(rawValue: "moveStep5ButtonToMiddle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.moveStep6ButtonToMiddle(_:)), name:NSNotification.Name(rawValue: "moveStep6ButtonToMiddle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.showBtnBack(_:)), name:NSNotification.Name(rawValue: "showBtnBack"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.hideBtnBack(_:)), name:NSNotification.Name(rawValue: "hideBtnBack"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.hideBtnNext(_:)), name:NSNotification.Name(rawValue: "hideBtnNext"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.showBtnNext(_:)), name:NSNotification.Name(rawValue: "showBtnNext"), object: nil)
        
        /*
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.showContainerView(aCtnView: ctnviewReplyUpholdStep0)), name:NSNotification.Name(rawValue: "showCtnViewStep0"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.showContainerView(aCtnView: ctnviewReplyUpholdStep1)), name:NSNotification.Name(rawValue: "showCtnViewStep1"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.showContainerView(aCtnView: ctnviewReplyUpholdStep2)), name:NSNotification.Name(rawValue: "showCtnViewStep2"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.showContainerView(aCtnView: ctnviewReplyUpholdStep3)), name:NSNotification.Name(rawValue: "showCtnViewStep3"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.showContainerView(aCtnView: ctnviewReplyUpholdStep4)), name:NSNotification.Name(rawValue: "showCtnViewStep4"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.showContainerView(aCtnView: ctnviewReplyUpholdStep5)), name:NSNotification.Name(rawValue: "showCtnViewStep5"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdViewController.showContainerView(aCtnView: ctnviewReplyUpholdStep6)), name:NSNotification.Name(rawValue: "showCtnViewStep6"), object: nil)
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
