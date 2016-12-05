//
//  NotifyCountRequest.swift
//  project
//
//  Created by Nixforest on 11/1/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class NotificationCountRequest: BaseRequest {
    override func completetionHandler(request: NSMutableURLRequest) -> URLSessionTask {
        let task = self.session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            // Check error
            guard error == nil else {
                self.view.showAlert(message: GlobalConst.CONTENT00196)
                LoadingView.shared.hideOverlayView()
                return
            }
            guard let data = data else {
                self.view.showAlert(message: GlobalConst.CONTENT00196)
                LoadingView.shared.hideOverlayView()
                return
            }
            // Convert to string
            let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print(dataString)
            // Convert to object
            let model: NotificationCountRespModel = NotificationCountRespModel(jsonString: dataString as! String)
            if model.status == "1" {
                Singleton.sharedInstance.setNotificationCountText(text: model.NotifyCountText)
                Singleton.sharedInstance.setOtherInfo(data: model.otherInfo)
            } else {
                self.showAlert(message: model.message)
                return
            }
            // Hide overlay
            LoadingView.shared.hideOverlayView()
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_UPDATE_NOTIFY_HOMEVIEW), object: model)
                self.view.updateNotificationStatus()
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
    override init(url: String, reqMethod: String, view: CommonViewController) {
        super.init(url: url, reqMethod: reqMethod, view: view)
    }
    
    /**
     * Set data content
     */
    func setData() {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, Singleton.sharedInstance.getUserToken()
        )
    }
}
