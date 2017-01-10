//
//  OrderViewRequest.swift
//  project
//
//  Created by SPJ on 12/31/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderViewRequest: BaseRequest {
    
    override func completetionHandler(request: NSMutableURLRequest) -> URLSessionTask {
        let task = self.session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            // Check error
            guard error == nil else {
                self.showAlert(message: DomainConst.CONTENT00196)
                return
            }
            guard let data = data else {
                self.showAlert(message: DomainConst.CONTENT00196)
                return
            }
            // Convert to string
            let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print(dataString ?? "")
            // Convert to object
            let model: BaseRespModel = BaseRespModel(jsonString: dataString as! String)
            if model.status == DomainConst.RESPONSE_STATUS_SUCCESS {
                // Hide overlay
                LoadingView.shared.hideOverlayView()
                // Set data
                (self.view as! G04F00S02VC).setData(jsonString: dataString as! String)
                // Update data to G04F00S02 view (cross-thread)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: G04Const.NOTIFY_NAME_G04_ORDER_VIEW_SET_DATA), object: model)
                }
            } else {
                self.showAlert(message: model.message)
                return
            }
        })
        return task
    }
    
    /**
     * Initializer
     * - parameter url: URL
     * - parameter reqMethod: Request method
     * - parameter view: Root view
     */
    override init(url: String, reqMethod: String, view: BaseViewController) {
        super.init(url: url, reqMethod: reqMethod, view: view)
    }
    
    /**
     * Set data content
     * - parameter id:    Order id
     */
    func setData(id: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_TRANSACTION_HISTORY_ID, id
        )
    }
    
    /**
     * Request order view function
     * - parameter id:    Order id
     */
    public static func requestOrderView(id: String, view: BaseViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = OrderViewRequest(url: G04Const.PATH_ORDER_TRANSACTION_VIEW,
                                       reqMethod: DomainConst.HTTP_POST_REQUEST,
                                       view: view)
        request.setData(id: id)
        request.execute()
    }
}
