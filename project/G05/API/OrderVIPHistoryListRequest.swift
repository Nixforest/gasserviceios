//
//  OrderVIPHistoryListRequest.swift
//  project
//  P0074_OrderVIPHistory_API
//  Created by SPJ on 7/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderVIPHistoryListRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id:              Id of customer
     * - parameter type:            Type of request
     */
    func setData(id: String, type: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%d}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_CUSTOMER_ID,            id,
            DomainConst.KEY_TYPE,                   type,
            DomainConst.KEY_PLATFORM,               DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request transaction event
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter id:              Id of customer
     * - parameter type:            Type of request
     */
    public static func request(action: Selector,
                               view: UIView,
                               id: String, type: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view)
        let request = OrderVIPHistoryListRequest(url: G05Const.PATH_ORDER_VIP_HISTORY_LIST,
                                            reqMethod: DomainConst.HTTP_POST_REQUEST)
        request.setData(id: id, type: type)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
