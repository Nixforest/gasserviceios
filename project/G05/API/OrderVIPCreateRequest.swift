//
//  OrderVIPCreateRequest.swift
//  project
//
//  Created by SPJ on 2/16/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderVIPCreateRequest: BaseRequest {
//    override func completetionHandler(request: NSMutableURLRequest) -> URLSessionTask {
//        let task = self.session.dataTask(with: request as URLRequest, completionHandler: {
//            (
//            data, response, error) in
//            // Check error
//            guard error == nil else {
//                self.showAlert(message: DomainConst.CONTENT00196)
//                return
//            }
//            guard let data = data else {
//                self.showAlert(message: DomainConst.CONTENT00196)
//                return
//            }
//            // Convert to string
//            let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//            print(dataString ?? "")
//            // Convert to object
//            let model: OrderVIPCreateRespModel = OrderVIPCreateRespModel(jsonString: dataString as! String)
//            if model.status == DomainConst.RESPONSE_STATUS_SUCCESS {
//                // Hide overlay
//                LoadingView.shared.hideOverlayView()
//                // Update data to MapViewController view (cross-thread)
//                DispatchQueue.main.async {
//                    NotificationCenter.default.post(name: Notification.Name(rawValue: self.theClassName), object: model)
//                }
//            } else {
//                self.showAlert(message: model.message)
//                return
//            }
//        })
//        return task
//    }
    
//    /**
//     * Initializer
//     * - parameter url: URL
//     * - parameter reqMethod: Request method
//     * - parameter view: Root view
//     */
//    override init(url: String, reqMethod: String, view: BaseViewController) {
//        super.init(url: url, reqMethod: reqMethod, view: view)
//    }
    
    /**
     * Set data content
     * - parameter page:    Page index
     */
    func setData(b50: String, b45: String, b12: String, b6: String,
                 //++ BUG0086-SPJ (NguyenPT 20170530) Add phone
                 customerPhone: String,
                 //-- BUG0086-SPJ (NguyenPT 20170530) Add phone
                 note: String,
                 //++ BUG0116-SPJ (NguyenPT 20170628) Handle VIP customer order: select sub-agent
                 store_id: String) {
                 //-- BUG0116-SPJ (NguyenPT 20170628) Handle VIP customer order: select sub-agent
        var is_chain_store = 0
        if !BaseModel.shared.getListVipCustomerStores().isEmpty {
            is_chain_store = 1
        }
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%d}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_B50,                        String(b50),
            DomainConst.KEY_B45,                        String(b45),
            DomainConst.KEY_B12,                        String(b12),
            DomainConst.KEY_B6,                         String(b6),
            //++ BUG0086-SPJ (NguyenPT 20170530) Add phone
            DomainConst.KEY_CUSTOMER_CONTACT,           customerPhone,
            //-- BUG0086-SPJ (NguyenPT 20170530) Add phone
            DomainConst.KEY_NOTE_CUSTOMER,              note,
            //++ BUG0116-SPJ (NguyenPT 20170628) Handle VIP customer order: select sub-agent
            DomainConst.KEY_CUSTOMER_CHAIN_STORE_ID,    store_id,
            DomainConst.KEY_IS_CHAIN_STORE,             String(is_chain_store),
            //-- BUG0116-SPJ (NguyenPT 20170628) Handle VIP customer order: select sub-agent
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request order list function
     * - parameter page:    Page index
     */
    public static func requestOrderVIPCreate(action: Selector, view: BaseViewController,
                                          b50: String, b45: String, b12: String,
                                          b6: String, customerPhone: String, note: String,
                                          //++ BUG0116-SPJ (NguyenPT 20170628) Handle VIP customer order: select sub-agent
                                          store_id: String) {
                                          //-- BUG0116-SPJ (NguyenPT 20170628) Handle VIP customer order: select sub-agent
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = OrderVIPCreateRequest(url: G05Const.PATH_ORDER_VIP_CREATE,
                                            reqMethod: DomainConst.HTTP_POST_REQUEST,
                                            view: view)
        request.setData(b50: b50, b45: b45, b12: b12, b6: b6,
                        customerPhone: customerPhone, note: note,
                        //++ BUG0116-SPJ (NguyenPT 20170628) Handle VIP customer order: select sub-agent
                        store_id: store_id)
                        //-- BUG0116-SPJ (NguyenPT 20170628) Handle VIP customer order: select sub-agent
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
