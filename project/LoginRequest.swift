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
        let start = DispatchTime.now()
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
            let end = DispatchTime.now()
            var nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds;
            var timeInterval = nanoTime / 1000000
            print("Start LoginRequest -> Convert to string: \(end.uptimeNanoseconds) - \(start.uptimeNanoseconds) = \(timeInterval) miliseconds")
            // Convert to object
            let model: LoginRespModel = LoginRespModel(jsonString: dataString as! String)
            let end1 = DispatchTime.now()
            nanoTime = end1.uptimeNanoseconds - start.uptimeNanoseconds
            timeInterval = nanoTime / 1000000
            print("Start LoginRequest -> Convert to object: \(timeInterval) miliseconds")
            if model.status == "1" {
                Singleton.sharedInstance.loginSuccess(model.token)
            }
            let end2 = DispatchTime.now()
            nanoTime = end2.uptimeNanoseconds - start.uptimeNanoseconds
            timeInterval = nanoTime / 1000000
            print("Start LoginRequest -> Login success: \(timeInterval) miliseconds")
            LoadingView.shared.hideOverlayView()
            let end3 = DispatchTime.now()
            nanoTime = end3.uptimeNanoseconds - start.uptimeNanoseconds
            timeInterval = nanoTime / 1000000
            print("Start LoginRequest -> HideOverlayView: \(end3.uptimeNanoseconds) - \(start.uptimeNanoseconds) = \(timeInterval) miliseconds")
            //DispatchQueue.async(execute: DispatchQueue.main)
            //dispatch_async(DispatchQueue.main)
            DispatchQueue.main.async {
                _ = self.view.navigationController?.popViewController(animated: true)
            }
            
            let end4 = DispatchTime.now()
            nanoTime = end4.uptimeNanoseconds - start.uptimeNanoseconds
            timeInterval = nanoTime / 1000000
            print("Start LoginRequest -> popViewController: \(end4.uptimeNanoseconds) - \(start.uptimeNanoseconds) = \(timeInterval) miliseconds")
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
        self.data = "q=" + String.init(format: "{\"username\":\"%@\",\"password\":\"%@\",\"gcm_device_token\":\"1\",\"apns_device_token\":\"1\",\"type\":\"2\"}",
                                       username, password)
    }
}
