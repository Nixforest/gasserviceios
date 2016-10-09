//
//  LogoutRequest.swift
//  project
//
//  Created by Nixforest on 10/8/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class LogoutRequest: BaseRequest {
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
            let model: BaseRespModel = BaseRespModel(jsonString: dataString as! String)
            if model.status == "1" {
                // Handle logout is success
                Singleton.sharedInstance.logoutSuccess()
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
                _ = self.view.navigationController?.popToRootViewController(animated: true)
            }
        })
        return task
    }
    /**
     * Initializer
     * - parameter url: URL
     * - parameter reqMethod: Request method Get/Post
     * - parameter view: current view
     */
    override init(url: String, reqMethod: String, view: CommonViewController) {
        super.init(url: url, reqMethod: reqMethod, view: view)
    }
    /**
     * Initializer
     * - parameter url: URL
     * - parameter reqMethod: Request method Get/Post
     *
     */
    override init(url: String, reqMethod: String) {
        super.init(url: url, reqMethod: reqMethod)
    }
    /**
     * Set data content
     */
    func setData() {
        self.data = "q=" + String.init(format: "{\"token\":\"%@\"}", Singleton.sharedInstance.getUserToken())
    }
}