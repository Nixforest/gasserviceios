//
//  G01F02VC.swift
//  project
//
//  Created by Nixforest on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F02VC: StepVC, StepDoneDelegate {
    
    override func viewDidLoad() {
        let height = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        let step1 = G01F02S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var step2 = G01F02S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var step3 = G01F02S03(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var step4 = G01F02S04(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var step5 = G01F02S05(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var step6 = G01F02S06(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var summary = G01F02S07(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        
        step1.stepDoneDelegate = self
        self.appendContent(stepContent: step1)
        if Singleton.sharedInstance.currentUpholdDetail.uphold_type != DomainConst.UPHOLD_TYPE_PERIODICALLY {
        step2.stepDoneDelegate = self
        self.appendContent(stepContent: step2)
        }
        step3.stepDoneDelegate = self
        self.appendContent(stepContent: step3)
        step4.stepDoneDelegate = self
        self.appendContent(stepContent: step4)
        step5.stepDoneDelegate = self
        self.appendContent(stepContent: step5)
        step6.stepDoneDelegate = self
        self.appendContent(stepContent: step6)
        self._numberStep = self._arrayContent.count + 1
        appendSummary(summary: summary)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clearData() {
        G01F02S01._selectedValue = ConfigBean(id: "", name: "")
        G01F02S02._selectedValue = ConfigBean(id: "", name: "")
        G01F02S03._selectedValue = nil
        G01F02S04._selectedValue = (name: "", phone: "")
        G01F02S05._selectedValue = ""
        G01F02S06._selectedValue.removeAll()
    }
    override func btnSendTapped() {
        CommonProcess.requestCreateUpholdReply(
            upholdId: Singleton.sharedInstance.currentUpholdDetail.id,
            status: G01F02S01._selectedValue.id,
            hoursHandle: G01F02S02._selectedValue.id,
            note: G01F02S04._selectedValue.name,
            contact_phone: G01F02S04._selectedValue.phone,
            reportWrong: (G01F02S03._selectedValue)! ? "0" : "1",
            listPostReplyImage: G01F02S06._selectedValue,
            customerId: Singleton.sharedInstance.currentUpholdDetail.customer_id,
            noteInternal: G01F02S05._selectedValue,
            view: self)
    }
    
    func stepDone() {
        self.moveNext()
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