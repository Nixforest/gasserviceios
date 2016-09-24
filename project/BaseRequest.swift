//
//  BaseRequest.swift
//  project
//
//  Created by Nixforest on 9/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class BaseRequest {
    /** URL */
    var url: String = ""
    /** Data of request */
    var data: String = ""
    /** Request method: GET/POST */
    var reqMethod: String = ""
    /** Session */
    var session = URLSession.shared
    /** Current view */
    var view: CommonViewController
    /**
     * Initializer
     * - parameter url: URL
     */
    init(url: String, reqMethod: String, view: CommonViewController) {
        self.url = url
        self.reqMethod = reqMethod
        self.view = view
    }
    func execute() {
        let serverUrl: URL = URL(string: Singleton.sharedInstance.getServerURL() + self.url)!
        let request = NSMutableURLRequest(url: serverUrl)
        request.httpMethod = self.reqMethod
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        // Make data string
        request.httpBody = self.data.data(using: String.Encoding.utf8)
        let task = completetionHandler(request: request)
        task.resume()
    }
    func completetionHandler(request: NSMutableURLRequest) -> URLSessionTask {
        let task = self.session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            // Check error
            guard error == nil else {
                //view.showAlert(message: "Lỗi kết nối đến máy chủ")
                return
            }
            guard let data = data else {
                //view.showAlert(message: "Lỗi kết nối đến máy chủ")
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
        })
        return task
    }
}
