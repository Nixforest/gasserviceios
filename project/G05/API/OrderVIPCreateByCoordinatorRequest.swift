//
//  OrderVIPCreateByCoordinatorRequest.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderVIPCreateByCoordinatorRequest: BaseRequest {
    /**
     * Set data content
     * - parameter customer_id:     Id of customer
     * - parameter agent_id:        Id of agent
     * - parameter date:            Delivery date
     * - parameter b50:             50kg quantity
     * - parameter b45:             45kg quantity
     * - parameter b12:             12kg quantity
     * - parameter b6:              6kg quantity
     * - parameter note:            Note
     */
    func setData(customer_id: String, agent_id: String, date: String, type: String,
                 b50: String, b45: String, b12: String, b6: String, note: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_CUSTOMER_ID, customer_id,
            DomainConst.KEY_AGENT_ID, agent_id,
            DomainConst.KEY_DATE_DELIVERY, date,
            DomainConst.KEY_TYPE, type,
            DomainConst.KEY_B50, String(b50),
            DomainConst.KEY_B45, String(b45),
            DomainConst.KEY_B12, String(b12),
            DomainConst.KEY_B6, String(b6),
            DomainConst.KEY_NOTE, note
        )
    }
    
    /**
     * Request order list function
     * - parameter action:          Action
     * - parameter view:            Current View controller
     * - parameter customer_id:     Id of customer
     * - parameter agent_id:        Id of agent
     * - parameter date:            Delivery date
     * - parameter b50:             50kg quantity
     * - parameter b45:             45kg quantity
     * - parameter b12:             12kg quantity
     * - parameter b6:              6kg quantity
     * - parameter note:            Note
     */
    public static func request(action: Selector, view: BaseViewController,
                                             customer_id: String, agent_id: String,
                                             date: String, type: String,
                                             b50: String, b45: String, b12: String,
                                             b6: String, note: String) {
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = OrderVIPCreateByCoordinatorRequest(url: G05Const.PATH_ORDER_VIP_CREATE_BY_COORDINATOR,
                                            reqMethod: DomainConst.HTTP_POST_REQUEST,
                                            view: view)
        request.setData(customer_id: customer_id, agent_id: agent_id,
                        date: date, type: type,
                        b50: b50, b45: b45, b12: b12, b6: b6, note: note)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }

}
