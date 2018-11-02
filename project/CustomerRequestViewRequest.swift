//
//  CustomerRequestViewRequest.swift
//  project
//
//  Created by SPJ on 7/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerRequestViewRequest: BaseRequest{
    /**
     * Set data content
     * - parameter page:        Page index
     */
    func setData(id: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID, id,
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
        let request = CustomerRequestViewRequest(url: G17Const.PATH_VIP_CUSTOMER_REQUEST_VIEW,
                                           reqMethod: DomainConst.HTTP_POST_REQUEST,
                                           view: view)
        request.setData(id: id)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
