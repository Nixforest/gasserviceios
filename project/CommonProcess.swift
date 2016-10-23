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
     * - parameter view:    View controller
     */
    static func requestChangePassword(oldPass: String, newPass: String, view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = ChangePassRequest(url: DomainConst.PATH_USER_CHANGE_PASS,
                                   reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData(oldPass: oldPass, newPass: newPass)
        request.execute()
    }
    
    /**
     * Request uphold list
     * - parameter page:        Page index
     * - parameter type:        Type uphold (Problem/Periodically)
     * - parameter customerId:  Id of customer
     * - parameter status:      Status of item
     * - parameter view:        View controller
     */
    static func requestUpholdList(page: Int, type: Int, customerId: String, status: String, view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = UpholdListRequest(url: DomainConst.PATH_SITE_UPHOLD_LIST, reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        
        request.setData(page: page, type: type, customerId: customerId, status: status)
        request.execute()
    }
    
    /**
     * Request search customer
     * - parameter keyword: Keyword
     * - parameter view:    View controller
     */
    static func requestSearchCustomer(keyword: String, view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = SearchCustomerRequest(url: DomainConst.PATH_SITE_AUTOCOMPLETE_USER, reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        
        request.setData(keyword: keyword)
        request.execute()
    }
    
    /**
     * Request uphold detail data
     * - parameter upholdId:    Id of uphold
     * - parameter replyId:     Id of uphold
     * - parameter view:    View controller
     */
    static func requestUpholdDetail(upholdId: String, replyId: String,
                                    view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = UpholdDetailRequest(url: DomainConst.PATH_SITE_UPHOLD_VIEW, reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData(upholdId: upholdId, replyId: upholdId)
        request.execute()
    }
    
    /**
     * Set border for control.
     * - parameter view: Control to set border
     */
    static func setBorder(view: UIView) {
        view.layer.borderWidth  = GlobalConst.BUTTON_BORDER_WIDTH
        view.layer.borderColor  = GlobalConst.BUTTON_COLOR_RED.cgColor
        view.clipsToBounds      = true
        view.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
    }
}
