//
//  TransactionCreateRequest.swift
//  project
//  P0082_CreateTransaction_API
//  Created by SPJ on 12/19/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class TransactionCreateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter buying:      Buying type
     * - parameter dateFrom:    From date value
     * - parameter dateTo:      To date value
     * - parameter page:        Page index
     */
    func setData() {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request customer family list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter buying:      Buying type
     * - parameter dateFrom:    From date value
     * - parameter dateTo:      To date value
     * - parameter page:        Page index
     */
    public static func request(action: Selector,
                               view: BaseViewController) {
        let request = TransactionCreateRequest(url: G07Const.PATH_ORDER_TRANSACTION_CREATE,
                                                reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                view: view)
        request.setData()
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
