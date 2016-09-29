//
//  CommonProcess.swift
//  project
//
//  Created by Nixforest on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class CommonProcess {
    static func requestLogin(username: String, password: String, view: CommonViewController) {
//        let url:URL = URL(string: Singleton.sharedInstance.getServerURL() + "/api/site/login")!
//        let session = URLSession.shared
//        
//        let request = NSMutableURLRequest(url: url)
//        request.httpMethod = "POST"
//        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
//        
//        // Make data string
//        let dataStr: String = String(format: "{\"username\":\"%@\",\"password\":\"%@\",\"gcm_device_token\":\"1\",\"apns_device_token\":\"1\",\"type\":\"2\"}",
//                                     username, password)
//        let paramString = "q=" + dataStr
//        request.httpBody = paramString.data(using: String.Encoding.utf8)
//        
//        let task = session.dataTask(with: request as URLRequest, completionHandler: {
//            (
//            data, response, error) in
//            // Check error
//            guard error == nil else {
//                view.showAlert(message: "Lỗi kết nối đến máy chủ")
//                LoadingView.shared.hideOverlayView()
//                return
//            }
//            guard let data = data else {
//                view.showAlert(message: "Lỗi kết nối đến máy chủ")
//                LoadingView.shared.hideOverlayView()
//                return
//            }
//            // Convert to string
//            let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//            print(dataString)
//            // Convert to object
//            let model: LoginRespModel = LoginRespModel(jsonString: dataString as! String)
//            if model.status == "1" {
//                Singleton.sharedInstance.loginSuccess(model.token)
////                Singleton.sharedInstance.setUserInfo(userInfo: model.user_info, userId: model.user_id, roleId: model.role_id)
//                print(Singleton.sharedInstance.getUserToken())
//            }
//            LoadingView.shared.hideOverlayView()
//            _ = view.navigationController?.popViewController(animated: true)
//        })
//        
//        task.resume()
        LoadingView.shared.showOverlay(view: view.view)
        let request = LoginRequest(url: "/api/site/login", reqMethod: "POST", view: view)
        request.setData(username: username, password: password)
        request.execute()
    }
    static func requestLogout() {
        let url:URL = URL(string: Singleton.sharedInstance.getServerURL() + "/api/site/logout")!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        // Make data string
        let dataStr: String = String(format: "{\"token\":\"%@\"}",
                                     Singleton.sharedInstance.getUserToken())
        let paramString = "q=" + dataStr
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
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
            //print(dataString)
            // Convert to object
            let model: BaseRespModel = BaseRespModel(jsonString: dataString as! String)
            if model.status == "1" {
                Singleton.sharedInstance.logoutSuccess()
                print(Singleton.sharedInstance.getUserToken())
            }
            LoadingView.shared.hideOverlayView()
        })
        
        task.resume()
    }
    static func requestUserProfile(view: CommonViewController) {
        LoadingView.shared.showOverlay(view: view.view)
        let userProfileReq = UserProfileRequest(url: "/api/user/profile", reqMethod: "POST", view: view)
        userProfileReq.setData(token: Singleton.sharedInstance.getUserToken())
        userProfileReq.execute()
    }
}
