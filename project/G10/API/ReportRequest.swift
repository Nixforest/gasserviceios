//
//  ReportOrderFamilyRequest.swift
//  project
//
//  Created by SPJ on 5/30/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportRequest: BaseRequest {
    /**
     * Set data content
     * - parameter from: From date (dd-mm-yy)
     * - parameter to:   To date (dd-mm-yy)
     */
    func setData(from: String, to: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,          BaseModel.shared.getUserToken(),
            DomainConst.KEY_DATE_FROM,      from,
            DomainConst.KEY_DATE_TO,        to,
            DomainConst.KEY_PLATFORM,       DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request report
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter from:        From date (dd-mm-yy)
     * - parameter to:          To date (dd-mm-yy)
     * - parameter url:         Url of request
     */
    public static func request(action: Selector, view: BaseViewController,
                               from: String, to: String, url: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = ReportRequest(url: url,
                                             reqMethod: DomainConst.HTTP_POST_REQUEST,
                                             view: view)
        request.setData(from: from, to: to)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
