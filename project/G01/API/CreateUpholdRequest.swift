//
//  CreateUpholdRequest.swift
//  project
//
//  Created by Nixforest on 11/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

class CreateUpholdRequest: BaseRequest {
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
//                (self.view as! G01F01VC).clearData()
//                // Back to home page (cross-thread)
//                DispatchQueue.main.async {
//                    self.view.showAlert(
//                        message: model.message,
//                        okHandler: {
//                            (alert: UIAlertAction!) in
//                            _ = self.view.navigationController?.popViewController(animated: true)
//                    })
//                }
//            } else {
//                self.showAlert(message: model.message)
//                return
//            }
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
    //-- BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
    
    /**
     * Set data content
     * - parameter upholdId:    Id of uphold
     * - parameter replyId:     Id of uphold
     */
    func setData(customerId: String, employeeId: String,
                 typeUphold: String, content: String, contactPerson: String,
                 contactTel: String, requestBy: String, storeId: String) {
        var isChainStore = DomainConst.NUMBER_ZERO_VALUE
        if !storeId.isEmpty {
            isChainStore = DomainConst.NUMBER_ONE_VALUE
        }
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%@,\"%@\":%d}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_EMPLOYEE_ID, employeeId,
            DomainConst.KEY_UPHOLD_TYPE, typeUphold,
            DomainConst.KEY_CONTENT, content,
            DomainConst.KEY_CONTACT_PERSON, contactPerson,
            DomainConst.KEY_CONTACT_TEL, contactTel,
            DomainConst.KEY_REQUEST_TYPE, requestBy,
            DomainConst.KEY_CUSTOMER_CHAIN_STORE_ID, storeId,
            DomainConst.KEY_IS_CHAIN_STORE, isChainStore,
            DomainConst.KEY_FLAG_GAS_24H, BaseModel.shared.getAppType(),
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
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
    public static func requestCreateUphold(action: Selector,
                                           customerId: String, employeeId: String,
                                    typeUphold: String, content: String, contactPerson: String,
                                    contactTel: String, requestBy: String,
                                    view: BaseViewController,
                                    storeId: String = DomainConst.BLANK) {
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = CreateUpholdRequest(url: DomainConst.PATH_SITE_UPHOLD_CREATE, reqMethod: DomainConst.HTTP_POST_REQUEST, view: view)
        request.setData(customerId: customerId, employeeId: employeeId,
                        typeUphold: typeUphold, content: content, contactPerson: contactPerson,
                        contactTel: contactTel, requestBy: requestBy, storeId: storeId)
        //++ BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        //-- BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
        request.execute()
    }
}
