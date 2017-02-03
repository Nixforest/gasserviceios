//
//  OrderTransactionCancelRequest.swift
//  project
//
//  Created by SPJ on 2/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderTransactionCancelRequest: BaseRequest {
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
                BaseModel.shared.setTransactionData(transaction: TransactionBean.init())
                // Handle completion
                DispatchQueue.main.async {
                    self.view.showAlert(
                        message: model.message,
                        okHandler: {
                            (alert: UIAlertAction!) in
                            NotificationCenter.default.post(name: Notification.Name(rawValue: self.theClassName), object: model)
                    })
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
     * - parameter url:         URL
     * - parameter reqMethod:   Request method
     * - parameter view:        Current view
     */
    override init(url: String, reqMethod: String, view: BaseViewController) {
        super.init(url: url, reqMethod: reqMethod, view: view)
    }
    
    /**
     * Set data content
     */
    func setData() {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_TRANSACTION_ID, BaseModel.shared.getTransactionData().id
        )
    }
    
    /**
     * Request order list function
     * - parameter action:  Completion handler
     * - parameter view:    Current view controller
     */
    public static func requestOrderTransactionCancel(action: Selector, view: BaseViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = OrderTransactionCancelRequest(url: G04Const.PATH_ORDER_TRANSACTION_CANCEL,
                                                     reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                     view: view)
        request.setData()
        NotificationCenter.default.addObserver(view, selector: action, name:NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
