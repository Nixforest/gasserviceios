//
//  CustomerRequestCreateRequest.swift
//  project
//
//  Created by SPJ on 7/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerRequestCreateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter customerId:      Id of customer
     * - parameter json:            Json Material
     */
    func setData(customerId: String,
                 json: String, note: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":[%@],\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_JSON, json,
            DomainConst.KEY_NOTE, note,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Customer Request Create Request
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter customerId:      Id of customer
     * - parameter json:            Json Material
     */
    public static func request(action: Selector, view: BaseViewController,
                               customerId: String,
                               json: String,
                               note: String) {
        let request = CustomerRequestCreateRequest(url: G17Const.PATH_VIP_CUSTOMER_REQUEST_CREATE,
                                             reqMethod: DomainConst.HTTP_POST_REQUEST,
                                             view: view)
        request.setData(customerId: customerId,
                        json: json,
                        note: note)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}

