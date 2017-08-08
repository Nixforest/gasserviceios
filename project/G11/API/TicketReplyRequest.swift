//
//  TicketReplyRequest.swift
//  project
//
//  Created by SPJ on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class TicketReplyRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id: Id of ticket
     * - parameter message: Message of ticket
     */
    func setData(id: String, message: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID, id,
            DomainConst.KEY_MESSAGE, message,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request Family uphold detail information
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter id:          Id of uphold
     * - parameter message: Message of ticket
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               id: String, message: String) {
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = TicketReplyRequest(url: G11Const.PATH_TICKET_REPLY,
                                              reqMethod: DomainConst.HTTP_POST_REQUEST,
                                              view: view)
        request.setData(id: id, message: message)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
