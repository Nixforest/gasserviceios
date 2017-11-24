//
//  GenerateOTPRequest.swift
//  project
//  P0079_GenerateOTP_API
//  Created by SPJ on 10/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class GenerateOTPRequest: BaseRequest {
    /**
     * Set data content
     * - parameter phone:    Phone number
     */
    func setData(phone: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":%d}",
            DomainConst.KEY_PHONE,      phone,
            DomainConst.KEY_PLATFORM,   DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request generate OTP
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter phone:       Phone number
     */
    public static func request(action: Selector, view: BaseViewController,
                               phone: String) {
        let request = GenerateOTPRequest(
            url: G00Const.PATH_CUSTOMER_GENERATE_OTP,
            reqMethod: DomainConst.HTTP_POST_REQUEST,
            view: view)
        request.setData(phone: phone)
        NotificationCenter.default.addObserver(view, selector: action, name:NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}