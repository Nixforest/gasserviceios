//
//  TicketCreateRequest.swift
//  project
//
//  Created by SPJ on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class TicketCreateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id: Id of PIC
     * - parameter title: Title of ticket
     * - parameter message: Message of ticket
     */
    func setData(id: String, title: String, message: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,      BaseModel.shared.getUserToken(),
            DomainConst.KEY_SEND_TO_ID, id,
            DomainConst.KEY_TITLE,      title,
            DomainConst.KEY_MESSAGE,    message,
            DomainConst.KEY_PLATFORM,   DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request create ticket
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter id:          Id of PIC
     * - parameter title:       Title of ticket
     * - parameter message:     Message of ticket
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               id: String, title: String, message: String) {
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = TicketCreateRequest(url: G11Const.PATH_TICKET_CREATE,
                                         reqMethod: DomainConst.HTTP_POST_REQUEST,
                                         view: view)
        request.setData(id: id, title: title, message: message)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
