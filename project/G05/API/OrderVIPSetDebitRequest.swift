//
//  OrderVIPSetDebitRequest.swift
//  project
//
//  Created by SPJ on 6/8/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderVIPSetDebitRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id:              Id of order
     * - parameter note:            Note
     */
    func setData(id: String, note: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%d}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID,                 id,
            DomainConst.KEY_NOTE,          note,
            DomainConst.KEY_PLATFORM,               DomainConst.PLATFORM_IOS
        )
        
        self.param = ["q": String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%d}",
            DomainConst.KEY_TOKEN,              BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID,                 id,
            DomainConst.KEY_NOTE,          note,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
            )]
    }
    
    /**
     * Request set debit for VIP order
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter id:              Id of order
     * - parameter note_employee:   Note
     */
    public static func request(action: Selector,
                               view: BaseViewController,
                               id: String, note: String,
                               images: [UIImage]) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = OrderVIPSetDebitRequest(url: G05Const.PATH_ORDER_VIP_SET_DEBIT,
                                            reqMethod: DomainConst.HTTP_POST_REQUEST,
                                            view: view)
        request.setData(id: id, note: note)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        //request.execute()
        request.executeUploadFile(listImages: images)
    }
}
