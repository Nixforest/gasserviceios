//
//  EmployeeCashBookUpdateRequest.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class EmployeeCashBookUpdateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id:                  Id of cashbook
     * - parameter customerId:          Id of customer
     * - parameter master_lookup_id:    Type of cashbook
     * - parameter date:                Delivery date
     * - parameter amount:              Amount of money
     * - parameter note:                Note
     * - parameter listImgDelete:   List images to delete
     */
    func setData(id: String,
                 customerId: String,
                 master_lookup_id: String,
                 date: String,
                 amount: String,
                 note: String,
                 app_order_id: String,
                 listImgDelete: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":[%@],\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,              BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID,                 id,
            DomainConst.KEY_APP_ORDER_ID,       app_order_id,
            DomainConst.KEY_CUSTOMER_ID,        customerId,
            DomainConst.KEY_MASTER_LOOKUP_ID,   master_lookup_id,
            DomainConst.KEY_DATE_INPUT,         date,
            DomainConst.KEY_AMOUNT,             amount,
            DomainConst.KEY_NOTE,               note,
            DomainConst.KEY_LIST_ID_IMAGE,      listImgDelete,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
        //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        self.param = ["q": String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":[%@],\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,              BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID,                 id,
            DomainConst.KEY_APP_ORDER_ID,       app_order_id,
            DomainConst.KEY_CUSTOMER_ID,        customerId,
            DomainConst.KEY_MASTER_LOOKUP_ID,   master_lookup_id,
            DomainConst.KEY_DATE_INPUT,         date,
            DomainConst.KEY_AMOUNT,             amount,
            DomainConst.KEY_NOTE,               note,
            DomainConst.KEY_LIST_ID_IMAGE,      listImgDelete,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
            )]
        //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
    }
    
    /**
     * Request VIP customer store card list
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter customerId:      Id of customer
     * - parameter storeCardType:   Type of store card
     * - parameter date:            Delivery date
     * - parameter note:            Note
     * - parameter orderDetail:     Detail of order
     */
    public static func request(action: Selector, view: BaseViewController,
                               id: String,
                               customerId: String,
                               master_lookup_id: String,
                               date: String,
                               amount: String,
                               note: String,
                               app_order_id: String,
                               //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
                               images: [UIImage],
                               listImgDelete: String) {
                               //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = EmployeeCashBookUpdateRequest(url: G09Const.PATH_VIP_CUSTOMER_CASHBOOK_UPDATE,
                                                    reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                    view: view)
        request.setData(id: id, customerId: customerId,
                        master_lookup_id: master_lookup_id,
                        date: date,
                        amount: amount,
                        note: note,
                        app_order_id: app_order_id,
                        listImgDelete: listImgDelete)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        //request.execute()
        request.executeUploadFile(listImages: images)
        //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
    }
}
