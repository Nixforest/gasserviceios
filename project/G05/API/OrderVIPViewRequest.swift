//
//  OrderVIPViewRequest.swift
//  project
//
//  Created by SPJ on 2/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderVIPViewRequest: BaseRequest {
    //++ BUG0060-SPJ (NguyenPT 20170421) Remove completetion handler
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
//    
//    /**
//     * Initializer
//     * - parameter url: URL
//     * - parameter reqMethod: Request method
//     * - parameter view: Root view
//     */
//    override init(url: String, reqMethod: String, view: BaseViewController) {
//        super.init(url: url, reqMethod: reqMethod, view: view)
//    }
    //++ BUG0060-SPJ (NguyenPT 20170421) Remove completetion handler
    
    /**
     * Set data content
     * - parameter id:    Id of order
     */
    func setData(id: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ORDER_ID, id
        )
    }
    
    /**
     * Request order list function
     * - parameter page:    Page index
     */
    public static func request(action: Selector, view: BaseViewController,
                                           id: String) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = OrderVIPViewRequest(url: G05Const.PATH_ORDER_VIP_VIEW,
                                          reqMethod: DomainConst.HTTP_POST_REQUEST,
                                          view: view)
        request.setData(id: id)
        NotificationCenter.default.addObserver(view, selector: action, name:NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
