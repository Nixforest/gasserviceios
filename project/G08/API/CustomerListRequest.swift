//
//  CustomerListRequest.swift
//  project
//
//  Created by SPJ on 5/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerListRequest: BaseRequest {
    /**
     * Set data content
     * - parameter keyword: Keyword
     * - parameter type:    Type of request
     */
    func setData(keyword: String, type: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_KEYWORD, keyword,
            DomainConst.KEY_TYPE, type,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request list customer by keyword
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter keyword:     Keyword
     * - parameter type:        Type of request
     */
    public static func request(action: Selector, view: BaseViewController,
                               currentView: UIView,
                               keyword: String, type: String) {
        // Show overlay
        //LoadingView.shared.showOverlay(view: view.view)
        let request = CustomerListRequest(url: DomainConst.PATH_SITE_AUTOCOMPLETE_USER,
                                           reqMethod: DomainConst.HTTP_POST_REQUEST,
                                           view: view)
        request.setData(keyword: keyword, type: type)
        NotificationCenter.default.addObserver(currentView, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        //request.execute()
        request.execute(isShowLoadingView: false)
    }
    
    /**
     * Request list customer by keyword
     * - parameter action:      Action execute when finish this task
     * - parameter keyword:     Keyword
     * - parameter type:        Type of request
     */
    public static func request(action: Selector, view: BaseViewController,
                               keyword: String, type: String) {
        // Show overlay
        //LoadingView.shared.showOverlay(view: view.view)
        let request = CustomerListRequest(url: DomainConst.PATH_SITE_AUTOCOMPLETE_USER,
                                          reqMethod: DomainConst.HTTP_POST_REQUEST,
                                          view: view)
        request.setData(keyword: keyword, type: type)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        //request.execute()
        request.execute(isShowLoadingView: false)
    }
    
    /**
     * Set data content
     * - parameter keyword: Keyword
     */
    func setData(keyword: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_KEYWORD, keyword,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request list customer by keyword
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter keyword:     Keyword
     */
    public static func request(action: Selector, view: BaseViewController,
                               keyword: String) {
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = CustomerListRequest(url: DomainConst.PATH_SITE_AUTOCOMPLETE_USER,
                                          reqMethod: DomainConst.HTTP_POST_REQUEST,
                                          view: view)
        request.setData(keyword: keyword)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
    
    
}
