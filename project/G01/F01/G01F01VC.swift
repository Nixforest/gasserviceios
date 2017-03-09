//
//  CreateUpholdViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F01VC: StepVC, StepDoneDelegate {
    /** Height of top segment */
    let TOP_PART_HEIGHT: CGFloat = 100.0
    
    //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
//    /**
//     * Handle when tap menu item
//     */
//    func asignNotifyForMenuItem() {
//        NotificationCenter.default.addObserver(self, selector: #selector(gasServiceItemTapped), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_GAS_SERVICE_ITEM), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(issueItemTapped(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_ISSUE_ITEM), object: nil)
//    }
    //-- BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
    
    /**
     * Handle view did load
     */
    override func viewDidLoad() {
        // Get height of status bar + navigation bar
        let height = self.getTopHeight()
        let step1 = G01F01S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G01F01S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G01F01S03(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        
        step1.stepDoneDelegate = self
        self.appendContent(stepContent: step1)
        step2.stepDoneDelegate = self
        self.appendContent(stepContent: step2)
        appendSummary(summary: summary)
        // Set title
        self.setTitle(title: DomainConst.CONTENT00178)
        super.viewDidLoad()
        //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
//        // Menu item tap
//        asignNotifyForMenuItem()
        //-- BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
        
        // Do any additional setup after loading the view.
        let phone: UIButton = UIButton()
        phone.frame = CGRect(x: GlobalConst.MARGIN, y: self.getTitleHeight(), width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN, height: TOP_PART_HEIGHT / 2)
        phone.backgroundColor = GlobalConst.BUTTON_COLOR_YELLOW
        phone.setTitle(BaseModel.shared.getCallCenterUpholdNumber(), for: UIControlState())
        phone.setTitleColor(UIColor.white, for: UIControlState())
        phone.titleLabel?.textAlignment = .center
        phone.titleLabel?.font = UIFont.boldSystemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
        let tintImg = ImageManager.getImage(named: G01Const.CALL_CENTER_NUMBER_IMG_NAME)
        let tinted = tintImg?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        phone.setImage(tinted, for: UIControlState())
        phone.tintColor = UIColor.white
        phone.imageView?.contentMode = .scaleAspectFit
        phone.addTarget(self, action: #selector(callCenterTap), for: .touchUpInside)
        self.view.addSubview(phone)
        
        let phoneStr: UIButton = UIButton()
        phoneStr.frame = CGRect(x: phone.frame.minX, y: phone.frame.maxY, width: phone.frame.width, height: TOP_PART_HEIGHT / 2)
        phoneStr.backgroundColor = GlobalConst.BUTTON_COLOR_YELLOW
        phoneStr.setTitle(BaseModel.shared.getHotlineNumber(), for: UIControlState())
        phoneStr.setTitleColor(UIColor.white, for: UIControlState())
        phoneStr.titleLabel?.textAlignment = .center
        phoneStr.titleLabel?.font = UIFont.boldSystemFont(ofSize: GlobalConst.BIG_FONT_SIZE)
        phoneStr.setImage(ImageManager.getImage(named: G01Const.HOTLINE_NUMBER_IMG_NAME), for: UIControlState())
        phoneStr.imageView?.contentMode = .scaleAspectFit
        phoneStr.addTarget(self, action: #selector(hotlineTap), for: .touchUpInside)
        self.view.addSubview(phoneStr)
    }
    
    /**
     * Handle when tap on call center phone number
     * Make a phone call
     */
    func callCenterTap() {
        self.makeACall(phone: BaseModel.shared.getCallCenterUpholdNumber().normalizatePhoneString())
//        if let url = NSURL(string: "tel://\(BaseModel.shared.getCallCenterUpholdNumber().normalizatePhoneString())"), UIApplication.shared.canOpenURL(url as URL) {
//            UIApplication.shared.openURL(url as URL)
//        }
    }
    
    /**
     * Handle when tap on hotline phone number
     * Make a phone call
     */
    func hotlineTap() {
        self.makeACall(phone: BaseModel.shared.getHotlineNumber().normalizatePhoneString())
//        if let url = NSURL(string: "tel://\(BaseModel.shared.getHotlineNumber().normalizatePhoneString())"), UIApplication.shared.canOpenURL(url as URL) {
//            UIApplication.shared.openURL(url as URL)
//        }
    }
    
    /**
     * Did receive memory warning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Clear data before close view
     */
    override func clearData() {
        G01F01S01._selectedValue = ConfigBean(id: "", name: "")
        G01F01S01._otherProblem = ""
        G01F01S02._selectedValue = ConfigBean(id: "", name: "")
        G01F01S02._name = ""
        G01F01S02._phone = ""
    }
    
    /**
     * Handle send request create uphold
     */
    override func btnSendTapped() {
        // Disable action handle notification from server
        BaseModel.shared.enableHandleNotificationFlag(isEnabled: false)
        CreateUpholdRequest.requestCreateUphold(
            customerId: BaseModel.shared.user_id,
            employeeId: "",
            typeUphold: G01F01S01._selectedValue.id,
            content: G01F01S01._otherProblem,
            contactPerson: G01F01S02._name,
            contactTel: G01F01S02._phone,
            requestBy: G01F01S02._selectedValue.id, view: self)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    /**
     * Override get height of top segment function
     * - returns: height of status + navigation bar + Top segment height
     */
    override func getTopHeight() -> CGFloat {
        let top = (self.navigationController!.navigationBar.frame.size.height
            + UIApplication.shared.statusBarFrame.size.height)
        return top + TOP_PART_HEIGHT
    }
    
    /**
     * Get height of status + navigation bar
     * - returns: Height of status + navigation bar
     */
    func getTitleHeight() -> CGFloat {
        return (self.navigationController!.navigationBar.frame.size.height
            + UIApplication.shared.statusBarFrame.size.height)
    }
}
