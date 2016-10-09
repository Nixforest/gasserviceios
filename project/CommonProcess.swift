//
//  CommonProcess.swift
//  project
//
//  Created by Nixforest on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class CommonProcess {
    /**
     * Request login.
     * - parameter username: Username
     * - parameter password: Password
     * - parameter view: View controller
     */
    static func requestLogin(username: String, password: String, view: CommonViewController) {
        //let start = DispatchTime.now()
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = LoginRequest(url: DomainConst.PATH_SITE_LOGIN,
                                   reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData(username: username, password: password)
        request.execute()
        //let end = DispatchTime.now()
        //let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds;
        //let timeInterval = nanoTime / 1000000
        //print("Start request -> Start excute: \(timeInterval) miliseconds")
    }
    
    /**
     * Request logout
     * - parameter view: View controller
     */
    static func requestLogout(view: CommonViewController) {
        LoadingView.shared.showOverlay(view: view.view)
        let logoutReq = LogoutRequest(url: DomainConst.PATH_SITE_LOGOUT,
                                      reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        logoutReq.setData()
        logoutReq.execute()
    }
    
    /**
     * Request logout
     * - parameter view: UIView
     */
    static func requestLogout(view: UIView) {
        LoadingView.shared.showOverlay(view: view)
        let logoutReq = LogoutRequest(url: DomainConst.PATH_SITE_LOGOUT,
                                      reqMethod: GlobalConst.HTTP_POST_REQUEST)
        logoutReq.setData()
        logoutReq.execute()
    }
    
    /**
     * Request user information
     * - parameter view: View controller
     */
    static func requestUserProfile(view: CommonViewController) {
        LoadingView.shared.showOverlay(view: view.view)
        let userProfileReq = UserProfileRequest(url: DomainConst.PATH_USER_PROFILE,
                                                reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        userProfileReq.setData(token: Singleton.sharedInstance.getUserToken())
        userProfileReq.execute()
    }
    
    /**
     * Request change password.
     * - parameter oldPass: Old password
     * - parameter newPass: New password
     * - parameter view: View controller
     */
    static func requestChangePassword(oldPass: String, newPass: String, view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = ChangePassRequest(url: DomainConst.PATH_USER_CHANGE_PASS,
                                   reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData(oldPass: oldPass, newPass: newPass)
        request.execute()
    }
}
