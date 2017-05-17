//
//  EmployeeCashBookViewRequest.swift
//  project
//
//  Created by SPJ on 5/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class EmployeeCashBookViewRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id:        Id of store card
     */
    func setData(id: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID, id,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request VIP customer store card list
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter id:        Id of store card
     */
    public static func request(action: Selector, view: BaseViewController,
                               id: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = EmployeeCashBookViewRequest(url: G09Const.PATH_VIP_CUSTOMER_CASHBOOK_VIEW,
                                           reqMethod: DomainConst.HTTP_POST_REQUEST,
                                           view: view)
        request.setData(id: id)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
