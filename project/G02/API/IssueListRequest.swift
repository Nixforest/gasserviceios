//
//  IssueListRequest.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class IssueListRequest: BaseRequest {
    /**
     * Set data content
     * - parameter page:        Page index
     * - parameter type:        Type of list
     * - parameter customer_id: Id of customer
     * - parameter problem:     Problem
     */
    func setData(page: String, type: String,
                 customer_id: String, problem: String
        ) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,          BaseModel.shared.getUserToken(),
            DomainConst.KEY_PAGE,           page,
            DomainConst.KEY_TYPE,           type,
            DomainConst.KEY_CUSTOMER_ID,    customer_id,
            DomainConst.KEY_PROBLEM,        problem,
            DomainConst.KEY_FLAG_GAS_24H,   BaseModel.shared.getAppType(),
            DomainConst.KEY_PLATFORM,       DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request issue list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter page:        Page index
     * - parameter type:        Type of list
     * - parameter customer_id: Id of customer
     * - parameter problem:     Problem
     */
    public static func request(action: Selector, view: BaseViewController,
                               page: String, type: String,
                               customer_id: String, problem: String
        ) {
        let request = IssueListRequest(url: DomainConst.PATH_SITE_ISSUE_LIST,
                                        reqMethod: DomainConst.HTTP_POST_REQUEST,
                                        view: view)
        request.setData(page: page, type: type,
                        customer_id: customer_id, problem: problem)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
