//
//  G01F02VC.swift
//  project
//
//  Created by Nixforest on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F02VC: StepVC, StepDoneDelegate {
    /**
     * View did load
     */
    override func viewDidLoad() {
        // Get height of status bar + navigation bar
        let height = self.getTopHeight()
        let step1 = G01F02S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G01F02S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step3 = G01F02S03(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step4 = G01F02S04(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step5 = G01F02S05(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step6 = G01F02S06(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step7 = G01F02S08(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G01F02S07(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        
        step1.stepDoneDelegate = self
        self.appendContent(stepContent: step1)
        if BaseModel.shared.currentUpholdDetail.uphold_type != DomainConst.UPHOLD_TYPE_PERIODICALLY {
            step2.stepDoneDelegate = self
            self.appendContent(stepContent: step2)
        }
        step7.stepDoneDelegate = self
        self.appendContent(stepContent: step7)
        step3.stepDoneDelegate = self
        self.appendContent(stepContent: step3)
        step4.stepDoneDelegate = self
        self.appendContent(stepContent: step4)
        step5.stepDoneDelegate = self
        self.appendContent(stepContent: step5)
        step6.stepDoneDelegate = self
        self.appendContent(stepContent: step6)
        
        appendSummary(summary: summary)
        // Set title
        self.setTitle(title: DomainConst.CONTENT00186)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /**
     * Did receive memory warning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        G01F02S01._selectedValue = ConfigBean(id: "", name: "")
        G01F02S02._selectedValue = ConfigBean(id: "", name: "")
        G01F02S03._selectedValue = nil
        G01F02S04._selectedValue = (name: "", phone: "")
        G01F02S05._selectedValue = ""
        G01F02S06._selectedValue.removeAll()
        G01F02S08._selectedValue = DomainConst.BLANK
    }
    
    /**
     * Handle send request create uphold reply
     */
    override func btnSendTapped() {
        // Disable action handle notification from server
        BaseModel.shared.enableHandleNotificationFlag(isEnabled: false)
        CreateUpholdReplyRequest.requestCreateUpholdReply(
            //-- BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
            action: #selector(finishHandleRequest(_:)),
            //-- BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
            upholdId: BaseModel.shared.currentUpholdDetail.id,
            status: G01F02S01._selectedValue.id, statusText: G01F02S01._selectedValue.name,
            hoursHandle: G01F02S02._selectedValue.id,
            note: G01F02S04._selectedValue.name,
            contact_phone: G01F02S04._selectedValue.phone,
            reportWrong: (G01F02S03._selectedValue)! ? DomainConst.REPORT_RIGHT : DomainConst.REPORT_WRONG,
            listPostReplyImage: G01F02S06._selectedValue,
            customerId: BaseModel.shared.currentUpholdDetail.customer_id,
            noteInternal: G01F02S05._selectedValue,
            view: self,
            code_complete: G01F02S08._selectedValue)
    }
    //-- BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
    internal func finishHandleRequest(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            BaseModel.shared.upholdList.updateStatus(id: BaseModel.shared.sharedDoubleStr.0, status: G01F02S01._selectedValue.name)
            self.clearData()
            NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_RELOAD_DATA_UPHOLD_DETAIL_VIEW), object: model)
            self.backButtonTapped(self)
        } else {
            showAlert(message: model.message)
        }
    }
    //-- BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
