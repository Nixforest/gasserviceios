//
//  OrderVIPUpdateRequest.swift
//  project
//
//  Created by SPJ on 4/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderVIPUpdateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id:              Id of order
     * - parameter note_employee:   Note of employee
     * - parameter orderDetail:     Order detail
     */
    func setData(id: String, note_employee: String,
                 orderDetail: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":[%@],\"%@\":%d}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ORDER_ID,               id,
            DomainConst.KEY_NOTE_EMPLOYEE,          note_employee,
            DomainConst.KEY_ORDER_DETAIL,           orderDetail,
            DomainConst.KEY_PLATFORM,               DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request transaction event
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter id:              Id of order
     * - parameter note_employee:   Note of employee
     * - parameter orderDetail:     Order detail
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               id: String, note_employee: String,
                               orderDetail: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = OrderVIPUpdateRequest(url: DomainConst.PATH_ORDER_VIP_UPDATE,
                                                 reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                 view: view)
        request.setData(id: id, note_employee: note_employee,
                        orderDetail: orderDetail)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }

}