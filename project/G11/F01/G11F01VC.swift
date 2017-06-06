//
//  G11F01VC.swift
//  project
//
//  Created by Nix Nixforest on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G11F01VC: StepVC, StepDoneDelegate {
    /** Selected value */
    public static var _handlerId:   String          = DomainConst.BLANK

    override func viewDidLoad() {
        let height = self.getTopHeight()
        let step1 = G11F01S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
//        let step2 = G11F01S02(w: GlobalConst.SCREEN_WIDTH,
//                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G11F01Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        step1.stepDoneDelegate = self
//        step2.stepDoneDelegate = self
        appendContent(stepContent: step1)
//        appendContent(stepContent: step2)
        appendSummary(summary: summary)
        self.setTitle(title: DomainConst.CONTENT00402)
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
        TicketCreateRequest.request(action: #selector(finishCreateTicket(_:)),
                                    view: self,
                                    id: G11F01VC._handlerId,
                                    title: G11F01S01._selectedValue.title,
                                    message: G11F01S01._selectedValue.content)
    }
    
    /**
     * Handle when finish create ticket
     */
    internal func finishCreateTicket(_ notification: Notification) {
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
        G11F01VC._handlerId = DomainConst.BLANK
        G11F01S01._selectedValue = (DomainConst.BLANK, DomainConst.BLANK)
        G11F01S02._selectedValue = ConfigBean.init()
    }
}
