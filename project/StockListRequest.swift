//
//  StockListRequest.swift
//  project
//
//  Created by SPJ on 7/25/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class StockListRequest : BaseRequest{
    /**
     * Set data content
     * - parameter page:        Page index
     * - parameter status:      Status of request
     * - parameter from:        From date
     * - parameter to:          To date
     * - parameter customerId:  Id of customer
     */
    //func setData(page: Int) {
    func setData(page: String, type: String, customerId: String, date_from:String, date_to: String, driver_id: String, car_id: String) {
        self.data = "q=" + String.init(
            //format: "{\"%@\":\"%@\",\"%@\":\"%@\"}",
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,              BaseModel.shared.getUserToken(),
            DomainConst.KEY_PAGE,               page,
            DomainConst.KEY_TYPE,               type,
            DomainConst.KEY_CUSTOMER_ID,        customerId,
            DomainConst.KEY_DATE_FROM,          date_from,
            DomainConst.KEY_DATE_TO,            date_to,
            DomainConst.KEY_DRIVER_ID,          driver_id,
            DomainConst.KEY_CAR_ID,             car_id,
            DomainConst.KEY_PLATFORM,           DomainConst.PLATFORM_IOS
        )
        
    }
    public static func request(view: BaseViewController, page: String, type: String,customerId: String, date_from:String, date_to: String, driver_id: String, car_id: String, completionHandler: ((Any?) -> Void)?) {
        //        // Show overlay
        //        LoadingView.shared.showOverlay(view: view.view)
        let request = StockListRequest(url: G18Const.PATH_VIP_STOCK_LIST,
                                                 reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                 view: view)
        request.setData(page: page, type: type, customerId: customerId, date_from: date_from, date_to: date_to, driver_id: driver_id, car_id: car_id)
        request.completionBlock = completionHandler
        request.execute()
    }
}
