//
//  IssueReplyRequest.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/31/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class IssueReplyRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id:                  Id of issue
     * - parameter message:             Message
     * - parameter chief_monitor_id:    Id of issue
     * - parameter monitor_agent_id:    Id of issue
     * - parameter accounting_id:       Id of issue
     */
    func setData(id: String,
                 message: String,
                 chief_monitor_id: String,
                 monitor_agent_id: String,
                 accounting_id: String
        ) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,              BaseModel.shared.getUserToken(),
            DomainConst.KEY_ISSUE_ID,           id,
            DomainConst.KEY_MESSAGE,            message,
            DomainConst.KEY_CHIEF_MONITOR_ID,   chief_monitor_id,
            DomainConst.KEY_MONITOR_AGENT_ID,   monitor_agent_id,
            DomainConst.KEY_ACCOUNTING_ID,      accounting_id,
            DomainConst.KEY_PLATFORM,           DomainConst.PLATFORM_IOS
        )
        self.param = [
            "q" : String.init(
                format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
                DomainConst.KEY_TOKEN,              BaseModel.shared.getUserToken(),
                DomainConst.KEY_ISSUE_ID,           id,
                DomainConst.KEY_MESSAGE,            message,
                DomainConst.KEY_CHIEF_MONITOR_ID,   chief_monitor_id,
                DomainConst.KEY_MONITOR_AGENT_ID,   monitor_agent_id,
                DomainConst.KEY_ACCOUNTING_ID,      accounting_id,
                DomainConst.KEY_PLATFORM,       DomainConst.PLATFORM_IOS
            )
        ]
    }
    
    /**
     * Request issue reply
     * - parameter action:              Action execute when finish this task
     * - parameter view:                Current view
     * - parameter id:                  Id of issue
     * - parameter message:             Message
     * - parameter chief_monitor_id:    Id of issue
     * - parameter monitor_agent_id:    Id of issue
     * - parameter accounting_id:       Id of issue
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               id: String,
                               message: String,
                               chief_monitor_id: String,
                               monitor_agent_id: String,
                               accounting_id: String,
                               listImages: [UIImage]
        ) {
        let request = IssueReplyRequest(url: DomainConst.PATH_SITE_ISSUE_REPLY,
                                       reqMethod: DomainConst.HTTP_POST_REQUEST,
                                       view: view)
        request.setData(id: id, message: message,
                        chief_monitor_id: chief_monitor_id,
                        monitor_agent_id: monitor_agent_id,
                        accounting_id: accounting_id)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.executeUploadFile(listImages: listImages)
    }
}
