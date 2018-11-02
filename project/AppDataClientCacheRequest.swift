//
//  AppDataClientCacheRequest.swift
//  project
//
//  Created by SPJ on 8/5/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class AppDataClientCacheRequest: BaseRequest{
    /**
     * Set data content
     */
    func setData() {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request customer family list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     */
    public static func request(action: Selector,
                               view: BaseViewController) {
        let request = AppDataClientCacheRequest(url: G17Const.PATH_VIP_APPDATA_CLIENT_CACHE,
                                                 reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                 view: view)
        request.setData()
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
