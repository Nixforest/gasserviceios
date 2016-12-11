//
//  CreateUpholdReplyRequest.swift
//  project
//
//  Created by Nixforest on 10/31/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class CreateUpholdReplyRequest: BaseRequest {
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
            print(dataString ?? "")
            // Convert to object
            let model: BaseRespModel = BaseRespModel(jsonString: dataString as! String)
            // Enable action handle notification from server
            Singleton.shared.enableHandleNotificationFlag(isEnabled: true)
            if model.status == "1" {
                // Hide overlay
                LoadingView.shared.hideOverlayView()
                // Clear data
                (self.view as! G01F02VC).clearData()
                // Back to home page (cross-thread)
                DispatchQueue.main.async {
                    self.view.showAlert(
                        message: model.message,
                        okHandler: {
                            (alert: UIAlertAction!) in
                            _ = self.view.navigationController?.popViewController(animated: true)
                    })
                    NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_RELOAD_DATA_UPHOLD_DETAIL_VIEW), object: model)
                    Singleton.shared.upholdList.record[Singleton.shared.sharedInt].status = self.status
                }
            } else {
                self.showAlert(message: model.message)
                return
            }
            // Hide overlay
            LoadingView.shared.hideOverlayView()
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
    
    var status: String = String()
    
    /**
     * Set data content
     * - parameter upholdId:    Id of uphold
     * - parameter replyId:     Id of uphold
     */
    func setData(upholdId: String, status: String, statusText: String,  hoursHandle: String,
                 note: String, contact_phone: String, reportWrong: String,
                 listPostReplyImage: [UIImage], customerId: String,
                 noteInternal: String) {
        self.status = statusText
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\",\"%@\":\"%d\",\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, Singleton.shared.getUserToken(),
            DomainConst.KEY_UPHOLD_ID, upholdId,
            DomainConst.KEY_STATUS, status,
            DomainConst.KEY_HOURS_HANDLE, hoursHandle,
            DomainConst.KEY_NOTE, note,
            DomainConst.KEY_CONTACT_PHONE, contact_phone,
            DomainConst.KEY_REPORT_WRONG, reportWrong,
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_NOTE_INTERNAL, noteInternal,
            DomainConst.KEY_LATITUDE, 0.0,
            DomainConst.KEY_LONGITUDE, 0.0,
            DomainConst.KEY_VERSION_CODE, GlobalConst.VERSION_CODE
        )
        self.param = [
            "q" : String.init(
                format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\",\"%@\":\"%d\",\"%@\":\"%@\"}",
                DomainConst.KEY_TOKEN, Singleton.shared.getUserToken(),
                DomainConst.KEY_UPHOLD_ID, upholdId,
                DomainConst.KEY_STATUS, status,
                DomainConst.KEY_HOURS_HANDLE, hoursHandle,
                DomainConst.KEY_NOTE, note,
                DomainConst.KEY_CONTACT_PHONE, contact_phone,
                DomainConst.KEY_REPORT_WRONG, reportWrong,
                DomainConst.KEY_CUSTOMER_ID, customerId,
                DomainConst.KEY_NOTE_INTERNAL, noteInternal,
                DomainConst.KEY_LATITUDE, 0.0,
                DomainConst.KEY_LONGITUDE, 0.0,
                DomainConst.KEY_VERSION_CODE, GlobalConst.VERSION_CODE
            )
        ]
    }
}
