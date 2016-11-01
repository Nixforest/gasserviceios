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
     * - parameter reqMethod: Request method Get/Post
     * - parameter view: current view
     */
    init(url: String, reqMethod: String, view: CommonViewController) {
        self.url = url
        self.reqMethod = reqMethod
        self.view = view
    }
    /**
     * Initializer
     * - parameter url: URL
     * - parameter reqMethod: Request method Get/Post
     */
    init(url: String, reqMethod: String) {
        self.url = url
        self.reqMethod = reqMethod
        self.view = CommonViewController()
    }
    
    /**
     * Execute task
     */
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
    
    /**
     * Handle when complete task
     */
    func completetionHandler(request: NSMutableURLRequest) -> URLSessionTask {
        let task = self.session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            // Check error
            guard error == nil else {
                self.view.showAlert(message: GlobalConst.CONTENT00196)
                return
            }
            guard data == nil else {
                self.view.showAlert(message: GlobalConst.CONTENT00196)
                return
            }
        })
        return task
    }
    
    /**
     * Show alert when connection has error.
     * - parameter message: Message string
     */
    func showAlert(message: String) {
        // Hide overlay
        LoadingView.shared.hideOverlayView()
        DispatchQueue.main.async {
            self.view.showAlert(message: message)
        }
    }
}
