//
//  CMSListRequest.swift
//  project
//
//  Created by SPJ on 9/18/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CMSListRequest: BaseRequest {
    /**
     * Set data content
     */
    func setData(categoryId:String, page:String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_CATEGORY_ID, categoryId,
            DomainConst.KEY_PAGE, page,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request Category list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter page:        Page index
     */
    public static func request(view: BaseViewController,categoryId:String, page:String, completionHandler: ((Any?) -> Void)?) {
        //        // Show overlay
        //        LoadingView.shared.showOverlay(view: view.view)
        let request = CMSListRequest(url: G19Const.PATH_CMS_LIST,
                                          reqMethod: DomainConst.HTTP_POST_REQUEST,
                                          view: view)
        request.setData(categoryId: categoryId, page: page)
        request.completionBlock = completionHandler
        request.execute()
    }
}
