//
//  GasRemainCreateRequest.swift
//  project
//
//  Created by SPJ on 12/31/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class GasRemainCreateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter customerId:      Id of customer
     * - parameter date:            Delivery date
     * - parameter orderDetail:     Detail of order
     */
    func setData(customerId: String,
                 date: String,
                 orderDetail: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%d,\"%@\":%@,\"%@\":[%@],\"%@\":%d}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_DATE_INPUT, date,
            DomainConst.KEY_GAS_REMAIN_TYPE, BaseModel.shared.getGasRemainType(),
            DomainConst.KEY_FLAG_GAS_24H, BaseModel.shared.getAppType(),
            DomainConst.KEY_ORDER_DETAIL, orderDetail,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request VIP customer store card list
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter customerId:      Id of customer
     * - parameter date:            Delivery date
     * - parameter orderDetail:     Detail of order
     */
    public static func request(action: Selector, view: BaseViewController,
                               customerId: String,
                               date: String,
                               orderDetail: String) {
        let request = GasRemainCreateRequest(url: G14Const.PATH_VIP_CUSTOMER_GAS_REMAIN_CREATE,
                                             reqMethod: DomainConst.HTTP_POST_REQUEST,
                                             view: view)
        request.setData(customerId: customerId,
                        date: date,
                        orderDetail: orderDetail)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
