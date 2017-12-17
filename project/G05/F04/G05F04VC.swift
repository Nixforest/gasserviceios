//
//  G05F04VC.swift
//  project
//
//  Created by SPJ on 6/8/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F04VC: StepVC, StepDoneDelegate {
    /** Id of cashbook updating */
    public static var _id:          String  = DomainConst.BLANK
    /** Order inf */
    public static var _orderInfo:          String  = DomainConst.BLANK
    override func viewDidLoad() {
        let height = self.getTopHeight()
        let step1 = G05F04S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G05F04S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G05F04Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        step1.stepDoneDelegate = self
        appendContent(stepContent: step1)
        step2.stepDoneDelegate = self
        appendContent(stepContent: step2)
        appendSummary(summary: summary)
        // Set title
        self.setTitle(title: DomainConst.CONTENT00438)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    override func btnSendTapped() {
        OrderVIPSetDebitRequest.request(action: #selector(finishRequestSetDebit(_:)),
                                        view: self,
                                        id: G05F04VC._id,
                                        note: G05F04S02._selectedValue,
                                        images: G05F04S01._selectedValue)
    }
    
    internal func finishRequestSetDebit(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
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
        G05F04VC._id           = DomainConst.BLANK
        G05F04S02._selectedValue = DomainConst.BLANK
        G05F04S01._selectedValue.removeAll()
        //++ BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
        G05F04VC._orderInfo = DomainConst.BLANK
        //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
    }
}
