//
//  SearchCustomerRequest.swift
//  project
//
//  Created by Nixforest on 10/17/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class SearchCustomerRequest: BaseRequest {
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
            print(dataString)
            // Convert to object
            let model: SearchCustomerRespModel = SearchCustomerRespModel(jsonString: dataString as! String)
            if model.status == "1" {
                Singleton.sharedInstance.saveSearchCustomerResult(result: model)
                // Notify update data on UpholdList view (cross-thread)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_SHOW_SEARCH_BAR_UPHOLDLIST_VIEW), object: model)
                }
            } else {
                //                // Hide overlay
                //                LoadingView.shared.hideOverlayView()
                //                DispatchQueue.main.async {
                //                    self.view.showAlert(message: model.message)
                //                }
                //                return
            }
            // Hide overlay
            LoadingView.shared.hideOverlayView()
            // Back to home page (cross-thread)
            //            DispatchQueue.main.async {
            //                _ = self.view.navigationController?.popViewController(animated: true)
            //            }
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
     * - parameter keyword: Keyword
     */
    func setData(keyword: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, Singleton.sharedInstance.getUserToken(),
            DomainConst.KEY_KEYWORD, keyword
        )
    }
}