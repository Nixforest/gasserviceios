//
//  G07F03VC.swift
//  project
//
//  Created by SPJ on 7/27/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G07F03VC: StepVC, StepDoneDelegate {
    /** Current agent */
    public static var _currentAgent:    CustomerBean    = CustomerBean()
    /** Order id */
    public static var _orderId:         String          = DomainConst.BLANK

    override func viewDidLoad() {
        // Get height of status bar + navigation bar
        let height = self.getTopHeight()
        let step1 = G07F03S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G07F03Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        step1.stepDoneDelegate = self
        appendContent(stepContent: step1)
        appendSummary(summary: summary)
        step1.setTargetType(title: DomainConst.CONTENT00377,
                            type: DomainConst.SEARCH_TARGET_TYPE_AGENT)
        self.setTitle(title: DomainConst.CONTENT00458)
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
        if G07F03S01._target.isEmpty() {
            showAlert(message: DomainConst.CONTENT00462)
            return
        }
        if G07F03S01._target.id == G07F03VC._currentAgent.id {
            showAlert(message: DomainConst.CONTENT00463)
            return
        }
        OrderFamilyHandleRequest.requestChangeAgentOrder(
            action: #selector(finishRequestHandler(_:)),
            view: self,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: G07F03VC._orderId,
            agentId: G07F03S01._target.id)
    }
    
    /**
     * Handle when finish request
     */
    internal func finishRequestHandler(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            self.clearData()
            showAlert(message: model.message, okHandler: {
                alert in
                self.backButtonTapped(self)
            })
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        G07F03VC._currentAgent = CustomerBean.init()
        G07F03VC._orderId = DomainConst.BLANK
        G07F03S01._target = CustomerBean.init()
        //++ BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
        G07F03S01._type = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
        //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
    }
}
