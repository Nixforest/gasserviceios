//
//  EmployeeCashBookListRequest.swift
//  project
//
//  Created by SPJ on 5/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class EmployeeCashBookListRequest: BaseRequest {
    /**
     * Set data content
     * - parameter page:        Page index
     * - parameter lookup_type: Type of lookup (1-In, 2-Out)
     * - parameter type:        Type of cash book
     * - parameter customer_id: Id of customer, default is "0"
     */
    func setData(page: String, lookup_type: String, type: String, customer_id: String = DomainConst.NUMBER_ZERO_VALUE) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,          BaseModel.shared.getUserToken(),
            DomainConst.KEY_PAGE,           page,
            DomainConst.KEY_LOOKUP_TYPE,    lookup_type,
            DomainConst.KEY_TYPE,           type,
            DomainConst.KEY_CUSTOMER_ID,    customer_id,
            DomainConst.KEY_PLATFORM,       DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request VIP customer store card list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter page:        Page index
     */
    public static func request(action: Selector, view: BaseViewController,
                               page: String, lookup_type: String,
                               type: String,
                               customer_id: String = DomainConst.NUMBER_ZERO_VALUE) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = EmployeeCashBookListRequest(url: G09Const.PATH_VIP_CUSTOMER_CASHBOOK_LIST,
                                           reqMethod: DomainConst.HTTP_POST_REQUEST,
                                           view: view)
        request.setData(page: page, lookup_type: lookup_type,
                        type: type, customer_id: customer_id)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
