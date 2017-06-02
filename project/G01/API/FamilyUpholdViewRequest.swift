//
//  FamilyUpholdViewRequest.swift
//  project
//
//  Created by SPJ on 6/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class FamilyUpholdViewRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id: Id of uphold
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
     * Request Family uphold detail information
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter id:          Id of uphold
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               id: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = FamilyUpholdViewRequest(url: G01Const.PATH_EMPLOYEE_FAMILY_UPHOLD_VIEW,
                                                reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                view: view)
        request.setData(id: id)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
