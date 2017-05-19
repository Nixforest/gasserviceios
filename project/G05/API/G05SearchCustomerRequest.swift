//
//  G05SearchCustomerRequest.swift
//  project
//
//  P0056_WinCustomerList_API
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05SearchCustomerRequest: BaseRequest {
    /**
     * Set data content
     * - parameter keyword: Keyword
     */
    func setData(keyword: String) {
        self.data = String.init(
            format: "%@=%@",
            DomainConst.KEY_KEYWORD, keyword
        )
    }
    
    /**
     * Request list customer by keyword
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter keyword:     Keyword
     */
    public static func request(action: Selector, view: BaseViewController,
                               currentView: UIView,
                               keyword: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = G05SearchCustomerRequest(url: G05Const.PATH_SEARCH_CUSTOMER,
                                          reqMethod: DomainConst.HTTP_POST_REQUEST,
                                          view: view)
        request.setData(keyword: keyword)
        NotificationCenter.default.addObserver(currentView, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }

}
