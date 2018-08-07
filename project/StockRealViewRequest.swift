//
//  StockRealViewRequest.swift
//  project
//
//  Created by SPJ on 7/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class StockRealViewRequest : BaseRequest{
    /**
     * Set data content
     * - parameter app_order_id:        Id of app_order
     */
    //func setData(page: Int) {
    func setData( app_order_id: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,          BaseModel.shared.getUserToken(),
            DomainConst.KEY_APP_ORDER_ID,           app_order_id,
            DomainConst.KEY_PLATFORM,       DomainConst.PLATFORM_IOS
        )
    }
    public static func request(view: BaseViewController, app_order_id: String,completionHandler: ((Any?) -> Void)?) {
        //        // Show overlay
        //        LoadingView.shared.showOverlay(view: view.view)
        let request = StockViewRequest(url: G18Const.PATH_VIP_STOCK_REAL_VIEW,
                                       reqMethod: DomainConst.HTTP_POST_REQUEST,
                                       view: view)
        request.setData(app_order_id: app_order_id)
        request.completionBlock = completionHandler
        request.execute()
    }
}

