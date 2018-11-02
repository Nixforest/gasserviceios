//
//  GasRemainViewRequest.swift
//  project
//
//  Created by SPJ on 12/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class GasRemainViewRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id:          Id of record
     */
    func setData(id: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%d,\"%@\":%@,\"%@\":%d}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID, id,
            DomainConst.KEY_GAS_REMAIN_TYPE, BaseModel.shared.getGasRemainType(),
            DomainConst.KEY_FLAG_GAS_24H, BaseModel.shared.getAppType(),
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request customer family list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter id:          Id of record
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               id: String) {
        let request = GasRemainViewRequest(url: G14Const.PATH_VIP_CUSTOMER_GAS_REMAIN_VIEW,
                                               reqMethod: DomainConst.HTTP_POST_REQUEST,
                                               view: view)
        request.setData(id: id)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
