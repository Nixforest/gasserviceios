//
//  TicketListRequest.swift
//  project
//
//  Created by SPJ on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class TicketListRequest: BaseRequest {
    /**
     * Set data content
     * - parameter page: Page index
     * - parameter type:        Type of request
     */
    func setData(page: String, type: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,          BaseModel.shared.getUserToken(),
            DomainConst.KEY_PAGE,           page,
            DomainConst.KEY_STATUS,         type,
            DomainConst.KEY_PLATFORM,       DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request Ticket list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter page:        Page index
     * - parameter type:        Type of request
     */
    public static func request(action: Selector, view: BaseViewController,
                               page: String, type: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = TicketListRequest(url: G11Const.PATH_TICKET_LIST,
                                        reqMethod: DomainConst.HTTP_POST_REQUEST,
                                        view: view)
        request.setData(page: page, type: type)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
