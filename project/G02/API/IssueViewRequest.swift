//
//  IssueViewRequest.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class IssueViewRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id:          Id of issue
     */
    func setData(id: String
        ) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,          BaseModel.shared.getUserToken(),
            DomainConst.KEY_ISSUE_ID,       id,
            DomainConst.KEY_PLATFORM,       DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request issue view
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter id:          Id of issue
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               id: String,
                               isShowLoading: Bool = true
        ) {
        let request = IssueViewRequest(url: DomainConst.PATH_SITE_ISSUE_VIEW,
                                       reqMethod: DomainConst.HTTP_POST_REQUEST,
                                       view: view)
        request.setData(id: id)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute(isShowLoadingView: isShowLoading)
    }
}
