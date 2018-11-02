//
//  StoreCardUpdateRequest.swift
//  project
//  P0051_StoreCardUpdate_API
//  Created by SPJ on 5/8/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class StoreCardUpdateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id:              Id of store card
     * - parameter customerId:      Id of customer
     * - parameter storeCardType:   Type of store card
     * - parameter date:            Delivery date
     * - parameter note:            Note
     * - parameter orderDetail:     Detail of order
     * - parameter listImgDelete:   List images to delete
     */
    func setData(id: String,
                 customerId: String,
                 storeCardType: String,
                 date: String,
                 note: String,
                 orderDetail: String,
                 //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
                 listImgDelete: String) {
                 //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":[%@],\"%@\":[%@],\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID, id,
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_TYPE_IN_OUT, storeCardType,
            DomainConst.KEY_DATE_DELIVERY, date,
            DomainConst.KEY_NOTE, note,
            DomainConst.KEY_ORDER_DETAIL, orderDetail,
            DomainConst.KEY_LIST_ID_IMAGE, listImgDelete,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
        //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        self.param = ["q": String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":[%@],\"%@\":[%@],\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,          BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID,             id,
            DomainConst.KEY_CUSTOMER_ID,    customerId,
            DomainConst.KEY_TYPE_IN_OUT,    storeCardType,
            DomainConst.KEY_DATE_DELIVERY,  date,
            DomainConst.KEY_NOTE,           note,
            DomainConst.KEY_ORDER_DETAIL,   orderDetail,
            DomainConst.KEY_LIST_ID_IMAGE, listImgDelete,
            DomainConst.KEY_PLATFORM,       DomainConst.PLATFORM_IOS
            )]
        //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
    }
    
    /**
     * Request VIP customer store card list
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter id:              Id of store card
     * - parameter customerId:      Id of customer
     * - parameter storeCardType:   Type of store card
     * - parameter date:            Delivery date
     * - parameter note:            Note
     * - parameter orderDetail:     Detail of order
     */
    public static func request(action: Selector, view: BaseViewController,
                               id: String,
                               customerId: String,
                               storeCardType: String,
                               date: String,
                               note: String,
                               orderDetail: String,
                               //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
                               images: [UIImage],
                               listImgDelete: String) {
                               //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = StoreCardUpdateRequest(url: G08Const.PATH_VIP_CUSTOMER_STORE_CARD_UPDATE,
                                             reqMethod: DomainConst.HTTP_POST_REQUEST,
                                             view: view)
        request.setData(id: id,
                        customerId: customerId,
                        storeCardType: storeCardType,
                        date: date,
                        note: note,
                        orderDetail: orderDetail,
                        listImgDelete: listImgDelete)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        //request.execute()
        request.executeUploadFile(listImages: images)
        //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
    }

}
