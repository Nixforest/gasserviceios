//
//  CreateUpholdReplyRequest.swift
//  project
//
//  Created by Nixforest on 10/31/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

class CreateUpholdReplyRequest: BaseRequest {
    //++ BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
//    override func completetionHandler(request: NSMutableURLRequest) -> URLSessionTask {
//        let task = self.session.dataTask(with: request as URLRequest, completionHandler: {
//            (
//            data, response, error) in
//            // Check error
//            guard error == nil else {
//                self.showAlert(message: DomainConst.CONTENT00196)
//                return
//            }
//            guard let data = data else {
//                self.showAlert(message: DomainConst.CONTENT00196)
//                return
//            }
//            // Convert to string
//            let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//            print(dataString ?? "")
//            // Convert to object
//            let model: BaseRespModel = BaseRespModel(jsonString: dataString as! String)
//            // Enable action handle notification from server
//            BaseModel.shared.enableHandleNotificationFlag(isEnabled: true)
//            if model.status == DomainConst.RESPONSE_STATUS_SUCCESS {
//                // Hide overlay
//                LoadingView.shared.hideOverlayView()
//                // Clear data
//                (self.view as! G01F02VC).clearData()
//                // Back to home page (cross-thread)
//                DispatchQueue.main.async {
//                    self.view.showAlert(
//                        message: model.message,
//                        okHandler: {
//                            (alert: UIAlertAction!) in
//                            NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_RELOAD_DATA_UPHOLD_DETAIL_VIEW), object: model)
//                            BaseModel.shared.upholdList.updateStatus(id: BaseModel.shared.sharedDoubleStr.0, status: self.status)
//                            _ = self.view.navigationController?.popViewController(animated: true)
//                    })
//                }
//            } else {
//                self.showAlert(message: model.message)
//                return
//            }
//            // Hide overlay
//            LoadingView.shared.hideOverlayView()
//        })
//        return task
//    }
//    
//    /**
//     * Initializer
//     * - parameter url: URL
//     * - parameter reqMethod: Request method
//     * - parameter view: Root view
//     */
//    override init(url: String, reqMethod: String, view: BaseViewController) {
//        super.init(url: url, reqMethod: reqMethod, view: view)
//    }
//    
//    var status: String = String()
    //-- BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
    
    /**
     * Set data content
     * - parameter upholdId:    Id of uphold
     * - parameter replyId:     Id of uphold
     */
    func setData(upholdId: String, status: String, statusText: String,  hoursHandle: String,
                 note: String, contact_phone: String, reportWrong: String,
                 listPostReplyImage: [UIImage], customerId: String,
                 noteInternal: String) {
        //++ BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
//        self.status = statusText
        //-- BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\",\"%@\":\"%d\",\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
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
            DomainConst.KEY_VERSION_CODE, DomainConst.VERSION_CODE
        )
        self.param = [
            "q" : String.init(
                format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\",\"%@\":\"%d\",\"%@\":\"%@\"}",
                DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
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
                DomainConst.KEY_VERSION_CODE, DomainConst.VERSION_CODE
            )
        ]
    }
    /**
     * Request create uphold reply
     * - parameter upholdId:            Id of uphold item
     * - parameter status:              Status of uphold
     * - parameter hoursHandle:         Hours handle
     * - parameter note:                Name of reviewer
     * - parameter contact_phone:       Phone of reviewer
     * - parameter reportWrong:         Report wrong
     * - parameter listPostReplyImage:  List images
     * - parameter customerId:          Id of customer
     * - parameter noteInternal:        Note internal
     * - parameter view:                View controller
     */
    public static func requestCreateUpholdReply(action: Selector,
                                         upholdId: String,
                                         status: String, statusText: String,
                                         hoursHandle: String,
                                         note: String, contact_phone: String,
                                         reportWrong: String,
                                         listPostReplyImage: [UIImage],
                                         customerId: String,
                                         noteInternal: String,
                                         view: BaseViewController) {
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = CreateUpholdReplyRequest(url: DomainConst.PATH_SITE_UPHOLD_REPLY, reqMethod: DomainConst.HTTP_POST_REQUEST, view: view)
        request.setData(upholdId: upholdId,
                        status: status, statusText: statusText, hoursHandle: hoursHandle,
                        note: note, contact_phone: contact_phone,
                        reportWrong: reportWrong,
                        listPostReplyImage: listPostReplyImage,
                        customerId: customerId,
                        noteInternal: noteInternal)
        //++ BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        //-- BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
        //request.execute()
        request.executeUploadFile(listImages: listPostReplyImage)
    }
}
