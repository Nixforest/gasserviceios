//
//  CustomerRequestUpdateRequest.swift
//  project
//
//  Created by SPJ on 7/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerRequestUpdateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id:              Id of gas remain
     * - parameter customerId:      Id of customer
     * - parameter json:            JsonMaterial
     * - parameter note:            Note of Customer Request
     * - parameter listImgDelete:   List images to delete
     * - parameter action_invest:   Action Invest
     */
    func setData(id: String, customerId: String,
                 json: String,
                 note: String, listImgDelete: String, action_invest: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":[%@],\"%@\":\"%@\",\"%@\":[%@],\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID, id,
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_JSON, json,
            DomainConst.KEY_NOTE, note,
            DomainConst.KEY_LIST_ID_IMAGE, listImgDelete,
            DomainConst.KEY_ACTION_INVEST, action_invest,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
        // ++ add image
        self.param = ["q": String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":[%@],\"%@\":\"%@\",\"%@\":[%@],\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID, id,
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_JSON, json,
            DomainConst.KEY_NOTE, note,
            DomainConst.KEY_LIST_ID_IMAGE, listImgDelete,
            //++ BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
            DomainConst.KEY_ACTION_INVEST, action_invest,
            //-- BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
            )]
        // -- add image
    }
    
    /**
     * Customer Request Update Request
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter id:              Id of customer request
     * - parameter customerId:      Id of customer
     * - parameter json:            Json Material
     * - parameter note:            Note of customer request
     * - parameter action_invest:   Action Invest
     */
    public static func request(action: Selector, view: BaseViewController,
                               id: String, customerId: String,
                               json: String,
                               note: String, images: [UIImage], listImgDelete: String, action_invest: String) {
        let request = CustomerRequestUpdateRequest(url: G17Const.PATH_VIP_CUSTOMER_REQUEST_UPDATE,
                                             reqMethod: DomainConst.HTTP_POST_REQUEST,
                                             view: view)
        request.setData(id: id, customerId: customerId,
                        json: json,
                        note: note,listImgDelete: listImgDelete, action_invest: action_invest)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        //request.execute()
        request.executeUploadFile(listImages: images)
    }
}
