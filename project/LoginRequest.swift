//
//  LoginRequest.swift
//  project
//
//  Created by Nixforest on 9/29/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation

class LoginRequest: BaseRequest {
    override func completetionHandler(request: NSMutableURLRequest) -> URLSessionTask {
        let task = self.session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            // Check error
            guard error == nil else {
                self.view.showAlert(message: "Lỗi kết nối đến máy chủ")
                LoadingView.shared.hideOverlayView()
                return
            }
            guard let data = data else {
                self.view.showAlert(message: "Lỗi kết nối đến máy chủ")
                LoadingView.shared.hideOverlayView()
                return
            }
            // Convert to string
            let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            
            // Convert to object
            let model: LoginRespModel = LoginRespModel(jsonString: dataString as! String)
            if model.status == "1" {
                // Handle login is success
                Singleton.sharedInstance.loginSuccess(model.token)
            } else {
                // Hide overlay
                LoadingView.shared.hideOverlayView()
                DispatchQueue.main.async {
                    self.view.showAlert(message: model.message)
                }
                return
            }
            // Hide overlay
            LoadingView.shared.hideOverlayView()
            // Back to home page (cross-thread)
            DispatchQueue.main.async {
                _ = self.view.navigationController?.popViewController(animated: true)
            }
        })
        return task
    }
    /**
     * Initializer
     * - parameter url: URL
     */
    override init(url: String, reqMethod: String, view: CommonViewController) {
        super.init(url: url, reqMethod: reqMethod, view: view)
    }
    /**
     * Set data content
     * - parameter token: User token
     */
    func setData(username: String, password: String) {
        self.data = "q=" + String.init(
            format: "{\"username\":\"%@\",\"password\":\"%@\",\"gcm_device_token\":\"1\",\"apns_device_token\":\"1\",\"type\":\"3\"}",
            //format: "{\"username\":\"%@\",\"password\":\"%@\",\"gcm_device_token\":\"1\",\"apns_device_token\":\"1\"}",
                                       username, password)
    }
}