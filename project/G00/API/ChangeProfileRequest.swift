//
//  ChangeProfileRequest.swift
//  project
//
//  Created by SPJ on 6/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ChangeProfileRequest: BaseRequest {
    /**
     * Set data content
     * - parameter name:            Name
     * - parameter provinceId:      Id of province
     * - parameter districtId:      Id of district
     * - parameter wardId:          Id of ward
     * - parameter streetId:        Id of street
     * - parameter houseNum:        House number
     * - parameter email:           Email
     * - parameter agentId:         Id of agent
     */
    func setData(name: String, provinceId: String, districtId: String,
                 wardId: String, streetId: String, houseNum: String,
                 email: String, agentId: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_FIRST_NAME,     name,
            DomainConst.KEY_PROVINCE_ID,    provinceId,
            DomainConst.KEY_DISTRICT_ID,    districtId,
            DomainConst.KEY_WARD_ID,        wardId,
            DomainConst.KEY_STREET_ID,      streetId,
            DomainConst.KEY_HOUSE_NUMBER,   houseNum,
            DomainConst.KEY_EMAIL,          email,
            DomainConst.KEY_AGENT_ID,       agentId,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request working report list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter name:            Name
     * - parameter provinceId:      Id of province
     * - parameter districtId:      Id of district
     * - parameter wardId:          Id of ward
     * - parameter streetId:        Id of street
     * - parameter houseNum:        House number
     * - parameter email:           Email
     * - parameter agentId:         Id of agent
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               name: String, provinceId: String, districtId: String,
                               wardId: String, streetId: String, houseNum: String,
                               email: String, agentId: String) {
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = ChangeProfileRequest(url: G00Const.PATH_CHANGE_PROFILE,
                                               reqMethod: DomainConst.HTTP_POST_REQUEST,
                                               view: view)
        request.setData(name: name, provinceId: provinceId, districtId: districtId,
                        wardId: wardId, streetId: streetId, houseNum: houseNum,
                        email: email, agentId: agentId)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
