//
//  G01F03VC.swift
//  project
//
//  Created by Nixforest on 11/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation

class G01F03VC: StepVC, StepDoneDelegate {
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self, selector: #selector(gasServiceItemTapped), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_GAS_SERVICE_ITEM), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(issueItemTapped(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_ISSUE_ITEM), object: nil)
    }
    
    override func viewDidLoad() {
        let height = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        let step1 = G01F03S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G01F03S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step3 = G01F03S03(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G01F03S04(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        
        step2.stepDoneDelegate = self
        self.appendContent(stepContent: step2)
        step1.stepDoneDelegate = self
        self.appendContent(stepContent: step1)
        step3.stepDoneDelegate = self
        self.appendContent(stepContent: step3)
        self._numberStep = self._arrayContent.count + 1
        appendSummary(summary: summary)
        // Set title
        self._title = GlobalConst.CONTENT00098
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clearData() {
        G01F03S01._selectedValue = ConfigBean(id: "", name: "")
        G01F03S02._selectedValue = [Int]()
        G01F03S03._selectedValue = ""
    }
    override func btnSendTapped() {
        CommonProcess.requestRatingUphold(id: Singleton.sharedInstance.sharedString,
                                          ratingStatusId: G01F03S01._selectedValue.id,
                                          listRating: G01F03S02._selectedValue,
                                          content: G01F03S03._selectedValue, view: self)
//        CommonProcess.requestCreateUphold(
//            customerId: Singleton.sharedInstance.user_id,
//            employeeId: "",
//            typeUphold: G01F01S01._selectedValue.id,
//            content: G01F01S01._otherProblem,
//            contactPerson: G01F01S02._name,
//            contactTel: G01F01S02._phone,
//            requestBy: G01F01S02._selectedValue.id, view: self)
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
    override func viewDidAppear(_ animated: Bool) {
        self.updateNotificationStatus()
    }
}
