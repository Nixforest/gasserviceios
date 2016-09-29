//
//  UserProfileRequest.swift
//  project
//
//  Created by Nixforest on 9/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class UserProfileRequest: BaseRequest {
    override func completetionHandler(request: NSMutableURLRequest) -> URLSessionTask {
        let task = self.session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            // Check error
            guard error == nil else {
                //view.showAlert(message: "Lỗi kết nối đến máy chủ")
                LoadingView.shared.hideOverlayView()
                return
            }
            guard let data = data else {
                //view.showAlert(message: "Lỗi kết nối đến máy chủ")
                LoadingView.shared.hideOverlayView()
                return
            }
            // Convert to string
            let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print(dataString)
            // Convert to object
            let model: UserProfileRespModel = UserProfileRespModel(jsonString: dataString as! String)
            if model.status == "1" {
                Singleton.sharedInstance.setUserInfo(userInfo: model.record)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "view.setData"), object: nil)
                //self.view.setData()
            }
            LoadingView.shared.hideOverlayView()
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
    func setData(token: String) {
        self.data = "q=" + String.init(format: "{\"token\":\"%@\"}", token)
    }
}