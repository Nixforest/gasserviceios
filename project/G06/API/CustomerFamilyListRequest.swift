//
//  CustomerFamilyListRequest
//  project
//
//  Created by SPJ on 3/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerFamilyListRequest: BaseRequest {
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
     * - parameter buying:      Buying type
     * - parameter dateFrom:    From date value
     * - parameter dateTo:      To date value
     * - parameter page:        Page index
     */
    func setData(buying: String, dateFrom: String, dateTo: String, page: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_BUYING, buying,
            DomainConst.KEY_PLATFORM, "3",
            DomainConst.KEY_DATE_FROM, dateFrom,
            DomainConst.KEY_DATE_TO, dateTo,
            DomainConst.KEY_PAGE, page
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
    public static func requestCustomerFamilyList(action: Selector,
                                             view: BaseViewController,
                                             buying: String,
                                             dateFrom: String,
                                             dateTo: String,
                                             page: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = CustomerFamilyListRequest(url: G06Const.PATH_CUSTOMER_FAMILY_LIST,
                                            reqMethod: DomainConst.HTTP_POST_REQUEST,
                                            view: view)
        request.setData(buying: buying,
                        dateFrom: dateFrom,
                        dateTo: dateTo,
                        page: page)
        NotificationCenter.default.addObserver(view, selector: action, name:NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
