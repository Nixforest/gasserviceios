//
//  GasRemainListRequest.swift
//  project
//  P0083_GasRemainList_API
//  Created by SPJ on 12/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class GasRemainListRequest: BaseRequest {
    /**
     * Set data content
     * - parameter date_from:       From date value
     * - parameter date_to:         To date value
     * - parameter type:            Type
     * - parameter page:            Page index
     * - parameter gas_remain_type: Gas remain type
     * - parameter customer_id:     Id of customer
     */
    func setData(date_from: String, date_to: String,
                 type: String,
                 page: String, gas_remain_type: Int,
                 customer_id: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%@,\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%d,\"%@\":\"%@\",\"%@\":%d}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_DATE_FROM, date_from,
            DomainConst.KEY_DATE_TO, date_to,
            DomainConst.KEY_FLAG_GAS_24H, BaseModel.shared.getAppType(),
            DomainConst.KEY_TYPE, type,
            DomainConst.KEY_PAGE, page,
            DomainConst.KEY_GAS_REMAIN_TYPE, BaseModel.shared.getGasRemainType(),
            DomainConst.KEY_CUSTOMER_ID, customer_id,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request customer family list
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter date_from:       From date value
     * - parameter date_to:         To date value
     * - parameter type:            Type
     * - parameter page:            Page index
     * - parameter gas_remain_type: Gas remain type
     * - parameter customer_id:     Id of customer
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               date_from: String, date_to: String,
                               type: String,
                               page: String, gas_remain_type: Int,
                               customer_id: String) {
        let request = GasRemainListRequest(url: G14Const.PATH_VIP_CUSTOMER_GAS_REMAIN_LIST,
                                               reqMethod: DomainConst.HTTP_POST_REQUEST,
                                               view: view)
        request.setData(date_from: date_from, date_to: date_to,
                        type: type,
                        page: page, gas_remain_type: gas_remain_type,
                        customer_id: customer_id)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
