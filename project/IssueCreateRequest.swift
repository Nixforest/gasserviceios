//
//  IssueCreateRequest.swift
//  project
//
//  Created by SPJ on 9/18/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class IssueCreateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter customerId:      Id of customer
     * - parameter title:           title
     * - parameter message:         message
     * - parameter problem:         problem
     */
    func setData(title:String, message:String, problem:String, customerId: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_TITLE, title,
            DomainConst.KEY_MESSAGE, message,
            DomainConst.KEY_PROBLEM, problem,
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
        // ++ add image
        self.param = ["q": String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_TITLE, title,
            DomainConst.KEY_MESSAGE, message,
            DomainConst.KEY_PROBLEM, problem,
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
            )]
        // -- add image
        
    }
    
    
    /**
     * Customer Request Create Request
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter customerId:      Id of customer
     * - parameter json:            Json Material
     * - parameter action_invest:   Action Invest
     */
    public static func request(action: Selector, view: BaseViewController,
                               title:String, message:String, problem:String, customerId: String, images: [UIImage]) {
        let request = IssueCreateRequest(url: G02Const.PATH_ISSUE_CREATE,
                                                   reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                   view: view)
        request.setData(title: title, message: message, problem: problem, customerId: customerId)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        //request.execute()
        request.executeUploadFile(listImages: images)
    }
}
