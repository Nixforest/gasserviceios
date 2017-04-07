//
//  WorkingReportCreateRequest.swift
//  project
//
//  Created by SPJ on 3/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class WorkingReportCreateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter content:         Content of report
     * - parameter longitude:       Longitude
     * - parameter latitude:        Latitude
     * - parameter version_code:    Version code
     */
    func setData(content: String, longitude: String,
                 latitude: String, version_code: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,                  BaseModel.shared.getUserToken(),
            DomainConst.KEY_CONTENT,                content,
            DomainConst.KEY_LONGITUDE,              longitude,
            DomainConst.KEY_LATITUDE,               latitude,
            DomainConst.KEY_VERSION_CODE,           version_code,
            DomainConst.KEY_PLATFORM,               DomainConst.PLATFORM_IOS
        )
        self.param = [
            "q": String.init(
                format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
                DomainConst.KEY_TOKEN,                  BaseModel.shared.getUserToken(),
                DomainConst.KEY_CONTENT,                content,
                DomainConst.KEY_LONGITUDE,              longitude,
                DomainConst.KEY_LATITUDE,               latitude,
                DomainConst.KEY_VERSION_CODE,           version_code,
                DomainConst.KEY_PLATFORM,               DomainConst.PLATFORM_IOS
            )
        ]
    }
    /**
     * Request create Working report
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter content:         Content of report
     * - parameter longitude:       Longitude
     * - parameter latitude:        Latitude
     * - parameter version_code:    Version code
     * - parameter listImage:       List images
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               content: String, longitude: String,
                               latitude: String, version_code: String,
                               listImage: [UIImage]) {
        
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = WorkingReportCreateRequest(url: G06Const.PATH_USER_WORKING_REPORT_CREATE,
                                                  reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                  view: view)
        request.setData(content: content, longitude: longitude,
                        latitude: latitude,
                        version_code: version_code)
        NotificationCenter.default.addObserver(view, selector: action, name:NSNotification.Name(rawValue: request.theClassName), object: nil)
        //request.execute()
        request.executeUploadFile(listImages: listImage)
    }
}
