//
//  CustomerRequestListRequest.swift
//  project
//
//  Created by SPJ on 7/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerRequestListRequest: BaseRequest {
    /**
     * Set data content
     * - parameter page:        Page index
     */
    func setData(page: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_PAGE, page,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Set data content
     * - parameter page:              Page index
     * - parameter dateFrom:          Page index
     * - parameter dateTo:            Page index
     * - parameter customer_id:            Page index
     */
    func setData(page: String, dateFrom: String, dateTo: String, customer_id: String ) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_PAGE, page,
            DomainConst.KEY_DATE_FROM, dateFrom,
            DomainConst.KEY_DATE_TO, dateTo,
            DomainConst.KEY_CUSTOMER_ID, customer_id,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request VIP customer request list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter page:        Page index
     */
    /*public static func request(action: Selector, view: BaseViewController,
                               page: String) {
        //        // Show overlay
        //        LoadingView.shared.showOverlay(view: view.view)
        let request = CustomerRequestListRequest(url: G17Const.PATH_VIP_CUSTOMER_REQUEST_LIST,
                                           reqMethod: DomainConst.HTTP_POST_REQUEST,
                                           view: view)
        request.setData(page: page)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }*/
    public static func request(view: BaseViewController, page: String, completionHandler: ((Any?) -> Void)?) {
        //        // Show overlay
        //        LoadingView.shared.showOverlay(view: view.view)
        let request = CustomerRequestListRequest(url: G17Const.PATH_VIP_CUSTOMER_REQUEST_LIST,
                                             reqMethod: DomainConst.HTTP_POST_REQUEST,
                                             view: view)
        request.setData(page: page)
        request.completionBlock = completionHandler
        request.execute()
    }
    
    public static func request(view: BaseViewController, page: String, dateFrom: String,
                               dateTo: String, 
                               customerId: String,completionHandler: ((Any?) -> Void)?) {
        //        // Show overlay
        //        LoadingView.shared.showOverlay(view: view.view)
        let request = CustomerRequestListRequest(url: G17Const.PATH_VIP_CUSTOMER_REQUEST_LIST,
                                                 reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                 view: view)
        request.setData(page: page, dateFrom: dateFrom,
                        dateTo: dateTo,customer_id:customerId)
        request.completionBlock = completionHandler
        request.execute()
    }
}


