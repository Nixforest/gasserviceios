//
//  CategoryListRequest.swift
//  project
//
//  Created by SPJ on 9/18/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CategoryListRequest: BaseRequest {
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
     * Request Category list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter page:        Page index
     */
    public static func request(view: BaseViewController, completionHandler: ((Any?) -> Void)?) {
        //        // Show overlay
        //        LoadingView.shared.showOverlay(view: view.view)
        let request = CategoryListRequest(url: G19Const.PATH_CATEGORY_LIST,
                                                 reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                 view: view)
        request.setData()
        request.completionBlock = completionHandler
        request.execute()
    }
}
