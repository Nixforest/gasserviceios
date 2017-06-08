//
//  EmployeeCashBookCreateRequest.swift
//  project
//  P0055_EmployeeCashBookCreate_API
//  Created by SPJ on 5/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class EmployeeCashBookCreateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter customerId:          Id of customer
     * - parameter master_lookup_id:    Type of cashbook
     * - parameter date:                Delivery date
     * - parameter amount:              Amount of money
     * - parameter note:                Note
     */
    func setData(customerId: String,
                 master_lookup_id: String,
                 date: String,
                 amount: String,
                 note: String, appOrderId: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,              BaseModel.shared.getUserToken(),
            DomainConst.KEY_CUSTOMER_ID,        customerId,
            DomainConst.KEY_MASTER_LOOKUP_ID,   master_lookup_id,
            DomainConst.KEY_DATE_INPUT,         date,
            DomainConst.KEY_AMOUNT,             amount,
            DomainConst.KEY_NOTE,               note,
            DomainConst.KEY_APP_ORDER_ID,       appOrderId,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
        
        self.param = ["q": String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,              BaseModel.shared.getUserToken(),
            DomainConst.KEY_CUSTOMER_ID,        customerId,
            DomainConst.KEY_MASTER_LOOKUP_ID,   master_lookup_id,
            DomainConst.KEY_DATE_INPUT,         date,
            DomainConst.KEY_AMOUNT,             amount,
            DomainConst.KEY_NOTE,               note,
            DomainConst.KEY_APP_ORDER_ID,       appOrderId,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )]
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
                               customerId: String,
                               master_lookup_id: String,
                               date: String,
                               amount: String,
                               note: String,
                               images: [UIImage], appOrderId: String = DomainConst.BLANK) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = EmployeeCashBookCreateRequest(url: G09Const.PATH_VIP_CUSTOMER_CASHBOOK_CREATE,
                                             reqMethod: DomainConst.HTTP_POST_REQUEST,
                                             view: view)
        request.setData(customerId: customerId,
                        master_lookup_id: master_lookup_id,
                        date: date,
                        amount: amount,
                        note: note,
                        appOrderId: appOrderId)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        //request.execute()
        request.executeUploadFile(listImages: images)
    }
}
