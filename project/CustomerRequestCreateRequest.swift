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
     * - parameter action_invest:   Action Invest
     */
    func setData(customerId: String,
                 json: String, note: String, action_invest: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":[%@],\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_JSON, json,
            DomainConst.KEY_NOTE, note,
            //++ BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
            DomainConst.KEY_ACTION_INVEST, action_invest,
            //-- BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
        // ++ add image
        self.param = ["q": String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":[%@],\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_JSON, json,
            DomainConst.KEY_NOTE, note,
            DomainConst.KEY_ACTION_INVEST, action_invest,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
            )]
        // -- add image
        
    }
    
    /**
     * Customer Request Create Request
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter customerId:      Id of customer
     * - parameter json:            Json Material
     * - parameter action_invest:   Action Invest
     */
    public static func request(action: Selector, view: BaseViewController,
                               customerId: String,
                               json: String,
                               note: String,action_invest: String, images: [UIImage]) {
        let request = CustomerRequestCreateRequest(url: G17Const.PATH_VIP_CUSTOMER_REQUEST_CREATE,
                                             reqMethod: DomainConst.HTTP_POST_REQUEST,
                                             view: view)
        request.setData(customerId: customerId,
                        json: json,
                        note: note, action_invest: action_invest)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        //request.execute()
        request.executeUploadFile(listImages: images)
    }
}

