//
//  OrderConfig.swift
//  project
//
//  Created by SPJ on 1/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderConfigRequest: BaseRequest {
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
            let model: OrderConfigRespModel = OrderConfigRespModel(jsonString: dataString as! String)
            if model.status == DomainConst.RESPONSE_STATUS_SUCCESS {
                // Hide overlay
                LoadingView.shared.hideOverlayView()
                // Set data
                (self.view as! MapViewController).saveAgentInfo(data: model.getRecord())
                // Update data to MapViewController view (cross-thread)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: G04Const.NOTIFY_NAME_G04_ADDRESS_VIEW_SET_DATA), object: model)
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
     * - parameter page:    Page index
     */
    func setData() {
        self.data = "q=" + String.init(
            format: "{}")
    }
    
    /**
     * Request order list function
     * - parameter page:    Page index
     */
    public static func requestOrderConfig(view: BaseViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = OrderConfigRequest(url: G04Const.PATH_ORDER_CONFIG,
                                       reqMethod: DomainConst.HTTP_POST_REQUEST,
                                       view: view)
        request.setData()
        request.execute()
    }
}
