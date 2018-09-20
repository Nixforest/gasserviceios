//
//  CMSViewRequest.swift
//  project
//
//  Created by SPJ on 9/18/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CMSViewRequest: BaseRequest {
    /**
     * Set data content
     * id
     */
    func setData(id:String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID, id,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request Category list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter id:          id
     */
    public static func request(view: BaseViewController,id:String, completionHandler: ((Any?) -> Void)?) {
        //        // Show overlay
        //        LoadingView.shared.showOverlay(view: view.view)
        let request = CMSViewRequest(url: G19Const.PATH_CMS_VIEW,
                                     reqMethod: DomainConst.HTTP_POST_REQUEST,
                                     view: view)
        request.setData(id: id)
        request.completionBlock = completionHandler
        request.execute()
    }
}
