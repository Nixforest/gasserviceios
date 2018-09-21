//
//  TempDataRequest.swift
//  project
//
//  Created by SPJ on 5/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class TempDataRequest: BaseRequest {
    /**
     * Set data content
     * - parameter agent_id:        Id of agent
     */
    func setData(agent_id: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_AGENT_ID, agent_id
        )
    }
    
    /**
     * Request list customer by keyword
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter agent_id:        Id of agent
     */
    public static func request(action: Selector, view: BaseViewController,
                               agent_id: String) {
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = TempDataRequest(url: G05Const.PATH_WINDOW_GET_CONFIG,
                                               reqMethod: DomainConst.HTTP_POST_REQUEST,
                                               view: view)
        request.setData(agent_id: agent_id)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
