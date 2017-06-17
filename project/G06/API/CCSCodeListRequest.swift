//
//  CCSCodeListRequest.swift
//  project
//
//  Created by SPJ on 6/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class CCSCodeListRequest: BaseRequest {
    /**
     * Set data content
     * - parameter page:        Page index
     */
    func setData(page: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_PAGE, page,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request VIP customer store card list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter page:        Page index
     */
    public static func request(action: Selector, view: BaseViewController,
                               page: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = CCSCodeListRequest(url: G06Const.PATH_CCS_CODE_LIST,
                                           reqMethod: DomainConst.HTTP_POST_REQUEST,
                                           view: view)
        request.setData(page: page)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }

}
