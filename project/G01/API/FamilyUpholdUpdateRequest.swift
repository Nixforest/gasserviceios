//
//  FamilyUpholdUpdateRequest.swift
//  project
//  P0065_FamilyUpholdUpdate_API
//  Created by SPJ on 6/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class FamilyUpholdUpdateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter actionType:      Type of action
     *                              2 - Confirm
     *                              3 - Cancel confirm
     *                              4 -
     *                              5 - Completed
     * - parameter lat:             Latitude
     * - parameter long:            Longitude
     * - parameter id:              Id of uphold
     * - parameter note:            Note
     */
    func setData(actionType: Int, lat: String, long: String,
                 id: String, note: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":%d,\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%d}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ACTION_TYPE,            actionType,
            DomainConst.KEY_LATITUDE,               lat,
            DomainConst.KEY_LONGITUDE,              long,
            DomainConst.KEY_ID,                     id,
            DomainConst.KEY_NOTE_EMPLOYEE,          note,
            DomainConst.KEY_PLATFORM,               DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request Family uphold action
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter actionType:      Type of action
     *                              2 - Confirm
     *                              3 - Cancel confirm
     *                              4 -
     *                              5 - Completed
     * - parameter lat:             Latitude
     * - parameter long:            Longitude
     * - parameter id:              Id of uphold
     * - parameter note:            Note
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               actionType: Int, lat: String, long: String,
                               id: String, note: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = FamilyUpholdUpdateRequest(url: G01Const.PATH_EMPLOYEE_FAMILY_UPHOLD_ACTION,
                                                 reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                 view: view)
        request.setData(actionType: actionType, lat: lat, long: long,
                        id: id, note: note)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
