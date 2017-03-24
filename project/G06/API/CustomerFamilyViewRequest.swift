//
//  CustomerFamilyViewRequest.swift
//  project
//
//  Created by SPJ on 3/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerFamilyViewRequest: BaseRequest {
    /**
     * Initializer
     * - parameter url: URL
     * - parameter reqMethod: Request method
     * - parameter view: Root view
     */
    override init(url: String, reqMethod: String, view: BaseViewController) {
        super.init(url: url, reqMethod: reqMethod, view: view)
    }
    
    /**
     * Set data content
     * - parameter customer_id: Id of customer
     */
    func setData(customer_id: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_CUSTOMER_ID, customer_id
        )
    }
    
    /**
     * Request customer family detail information
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter customer_id: Id of customer
     */
    public static func requestCustomerFamilyView(action: Selector,
                                                 view: BaseViewController,
                                                 customer_id: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = CustomerFamilyViewRequest(url: G06Const.PATH_CUSTOMER_FAMILY_VIEW,
                                                reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                view: view)
        request.setData(customer_id: customer_id)
        NotificationCenter.default.addObserver(view, selector: action, name:NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }

}
