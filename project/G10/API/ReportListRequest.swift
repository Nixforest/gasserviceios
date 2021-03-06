//
//  ReportListRequest.swift
//  project
//
//  Created by SPJ on 5/30/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportListRequest: BaseRequest {
    /**
     * Set data content
     */
    func setData() {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,          BaseModel.shared.getUserToken(),
            DomainConst.KEY_PLATFORM,       DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request Report list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     */
    public static func request(action: Selector, view: BaseViewController) {
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = ReportListRequest(url: G10Const.PATH_REPORT_LIST,
                                                  reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                  view: view)
        request.setData()
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
