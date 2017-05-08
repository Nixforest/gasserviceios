//
//  WorkingReportListRequest.swift
//  project
//
//  Created by SPJ on 3/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class WorkingReportListRequest: BaseRequest {
    /**
     * Set data content
     * - parameter dateFrom:    From date value
     * - parameter dateTo:      To date value
     * - parameter page:        Page index
     */
    func setData(dateFrom: String, dateTo: String, page: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_DATE_FROM, dateFrom,
            DomainConst.KEY_DATE_TO, dateTo,
            DomainConst.KEY_PAGE, page,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request working report list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter dateFrom:    From date value
     * - parameter dateTo:      To date value
     * - parameter page:        Page index
     */
    public static func request(action: Selector,
                                                 view: BaseViewController,
                                                 dateFrom: String,
                                                 dateTo: String,
                                                 page: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = WorkingReportListRequest(url: G06Const.PATH_USER_WORKING_REPORT_LIST,
                                                reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                view: view)
        request.setData(dateFrom: dateFrom,
                        dateTo: dateTo,
                        page: page)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
