//
//  G00F01VC.swift
//  project
//  Update account information
//  Created by SPJ on 6/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00F01VC: StepVC, StepDoneDelegate {
    public static var _fullAddress:     FullAddressBean = FullAddressBean()

    override func viewDidLoad() {

        // Do any additional setup after loading the view.
        let height = self.getTopHeight()
        let step1 = G00F01S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G00F01S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step3 = G00F01S03(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G00F01Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        step1.stepDoneDelegate = self
        step2.stepDoneDelegate = self
        step3.stepDoneDelegate = self
        appendContent(stepContent: step1)
        appendContent(stepContent: step2)
        appendContent(stepContent: step3)
        appendSummary(summary: summary)
        step2.setTargetType(title: DomainConst.CONTENT00377,
                            type: DomainConst.SEARCH_TARGET_TYPE_AGENT)
        step3.setAddress(address: FullAddressBean(
            provinceId: (BaseModel.shared.user_info?.getProvinceId())!,
            districtId: (BaseModel.shared.user_info?.getDistrictId())!,
            wardId: (BaseModel.shared.user_info?.getWardId())!,
            streetId: (BaseModel.shared.user_info?.getStreetId())!,
            houseNumber: (BaseModel.shared.user_info?.getHouseNumber())!,
            fullAddress: (BaseModel.shared.user_info?.getAddress())!))
        self.setTitle(title: DomainConst.CONTENT00442)
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

    override func btnSendTapped() {
        ChangeProfileRequest.request(
            action: #selector(finishRequestChangeProfile(_:)),
            view: self,
            name: G00F01S01._selectedValue.name,
            provinceId: G00F01VC._fullAddress.provinceId,
            districtId: G00F01VC._fullAddress.districtId,
            wardId: G00F01VC._fullAddress.wardId,
            streetId: G00F01VC._fullAddress.streetId,
            houseNum: G00F01VC._fullAddress.houseNumber,
            email: G00F01S01._selectedValue.email,
            agentId: G00F01S02._target.id)
    }
    
    internal func finishRequestChangeProfile(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            // Clear data at steps
            self.clearData()
            showAlert(message: model.message,
                      okHandler: {
                        alert in
                        //++ BUG0123-SPJ (NguyenPT 20170711) Handle update Agent id after change on Account screen
                        BaseModel.shared.user_info = nil
                        //-- BUG0123-SPJ (NguyenPT 20170711) Handle update Agent id after change on Account screen
                        self.backButtonTapped(self)
            })
        } else {    // Error
            showAlert(message: model.message)
        }
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        G00F01VC._fullAddress = FullAddressBean.init()
        G00F01S01._selectedValue = (DomainConst.BLANK, DomainConst.BLANK)
        G00F01S02._target = CustomerBean.init()
        G00F01S03._address = DomainConst.BLANK
    }
}
