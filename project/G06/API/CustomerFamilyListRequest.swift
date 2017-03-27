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
     * Set data content
     * - parameter buying:      Buying type
     * - parameter dateFrom:    From date value
     * - parameter dateTo:      To date value
     * - parameter page:        Page index
     */
    func setData(buying: String, dateFrom: String, dateTo: String, page: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_BUYING, buying,
            DomainConst.KEY_DATE_FROM, dateFrom,
            DomainConst.KEY_DATE_TO, dateTo,
            DomainConst.KEY_PAGE, page,
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
