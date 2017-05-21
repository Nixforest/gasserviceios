//
//  G09F01VC.swift
//  project
//
//  Created by SPJ on 5/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G09F01VC: StepVC, StepDoneDelegate {
    /** Type of store card */
    public static var _typeId:      String  = DomainConst.BLANK
    /** Mode: 0 - Create, 1 - Update */
    public static var _mode:        String  = DomainConst.NUMBER_ZERO_VALUE
    /** Id of cashbook updating */
    public static var _id:          String  = DomainConst.BLANK

    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        let height = self.getTopHeight()
        let step1 = G09F01S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G09F01S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step3 = G09F01S03(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step4 = G09F01S04(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step5 = G09F01S05(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G09F01Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        step1.stepDoneDelegate = self
        step2.stepDoneDelegate = self
        step3.stepDoneDelegate = self
        step4.stepDoneDelegate = self
        step5.stepDoneDelegate = self
        appendContent(stepContent: step1)
        appendContent(stepContent: step2)
        appendContent(stepContent: step3)
        appendContent(stepContent: step4)
        if G09F01VC._mode == DomainConst.NUMBER_ONE_VALUE {
            appendContent(stepContent: step5)
        }
        appendSummary(summary: summary)
        // Set title
        self.setTitle(title: DomainConst.CONTENT00390)
        if G09F01VC._mode == DomainConst.NUMBER_ONE_VALUE {
            self.setTitle(title: DomainConst.CONTENT00397)
        }
        super.viewDidLoad()
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
    
    
    /**
     * Handle send request cashbook
     */
    override func btnSendTapped() {
        // Create new
        if G09F01VC._mode == DomainConst.NUMBER_ZERO_VALUE {
            EmployeeCashBookCreateRequest.request(
                action:             #selector(finishCreateCashBook(_:)),
                view:               self,
                customerId:         G09F01S02.getTarget().id,
                master_lookup_id:   G09F01VC._typeId,
                date:               G09F01S01.getSelectValue(),
                amount:             G09F01S03._selectedValue,
                note:               G09F01S04.getSelectValue())
        } else {    // Update
            EmployeeCashBookUpdateRequest.request(
                action: #selector(finishCreateCashBook(_:)),
                view: self,
                id: G09F01VC._id,
                customerId: G09F01S02.getTarget().id,
                master_lookup_id: G09F01VC._typeId,
                date: G09F01S01.getSelectValue(),
                amount: G09F01S03._selectedValue,
                note: G09F01S04.getSelectValue())
        }
    }
    
    /**
     * Handle when finish create cashbook
     */
    internal func finishCreateCashBook(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = EmployeeCashBookViewRespModel(jsonString: data)
        if model.isSuccess() {
            // Clear data at steps
            self.clearData()
            showAlert(message: model.message,
                      okHandler: {
                        alert in
                        self.backButtonTapped(self)
            })
        } else {    // Error
            self.showAlert(message: model.message)
        }
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        G09F01VC._mode           = DomainConst.NUMBER_ZERO_VALUE
        G09F01VC._typeId         = DomainConst.BLANK
        G09F01VC._id             = DomainConst.BLANK
        G09F01S01._selectedValue = DomainConst.BLANK
        G09F01S02._target        = CustomerBean.init()
        G09F01S03._selectedValue = DomainConst.BLANK
        G09F01S04._selectedValue = DomainConst.BLANK
    }
}
