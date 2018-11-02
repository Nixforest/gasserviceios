//
//  EventClickCallRequest.swift
//  project
//
//  Created by SPJ on 10/4/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

//++ BUG0222-SPJ (KhoiVT 20181004 ) save Track when user call in VIP Order and CustomerOrder
class EventClickCallRequest: BaseRequest {
    /**
     * Set data content
     * - parameter phone:      phone of customer
     * - parameter type:       type of customer
     * - parameter obj_id:     Object Id
     */
    func setData(phone: String,
                 type: String, obj_id: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_PHONE, phone,
            DomainConst.KEY_TYPE, type,
            DomainConst.KEY_OBJECT_ID, obj_id,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * EventClickCallRequest
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter phone:           phone of customer
     * - parameter type:            type of customer
     * - parameter obj_id:          Object Id
     */
    public static func request(action: Selector, view: BaseViewController,
                               phone: String,
                               type: String, obj_id: String) {
        let request = EventClickCallRequest(url: G07Const.PATH_EVENT_CLICK_CALL,
                                                   reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                   view: view)
        request.setData(phone: phone, type: type, obj_id: obj_id)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
//-- BUG0222-SPJ (KhoiVT 20181004 ) save Track when user call in VIP Order and CustomerOrder
