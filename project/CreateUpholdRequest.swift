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
    override func completetionHandler(request: NSMutableURLRequest) -> URLSessionTask {
        let task = self.session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            // Check error
            guard error == nil else {
                self.showAlert(message: DomainConst.CONTENT00196)
                return
            }
            guard let data = data else {
                self.showAlert(message: DomainConst.CONTENT00196)
                return
            }
            // Convert to string
            let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print(dataString ?? "")
            // Convert to object
            let model: BaseRespModel = BaseRespModel(jsonString: dataString as! String)
            if model.status == "1" {
                // Hide overlay
                LoadingView.shared.hideOverlayView()
                // Clear data
                (self.view as! G01F01VC).clearData()
                // Back to home page (cross-thread)
                DispatchQueue.main.async {
                    self.view.showAlert(
                        message: model.message,
                        okHandler: {
                            (alert: UIAlertAction!) in
                            _ = self.view.navigationController?.popViewController(animated: true)
                    })
                }
            } else {
                self.showAlert(message: model.message)
                return
            }
        })
        return task
    }
    
    /**
     * Initializer
     * - parameter url: URL
     * - parameter reqMethod: Request method
     * - parameter view: Root view
     */
    override init(url: String, reqMethod: String, view: BaseViewController) {
        super.init(url: url, reqMethod: reqMethod, view: view)
    }
    
    /**
     * Set data content
     * - parameter upholdId:    Id of uphold
     * - parameter replyId:     Id of uphold
     */
    func setData(customerId: String, employeeId: String,
                 typeUphold: String, content: String, contactPerson: String,
                 contactTel: String, requestBy: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_EMPLOYEE_ID, employeeId,
            DomainConst.KEY_UPHOLD_TYPE, typeUphold,
            DomainConst.KEY_CONTENT, content,
            DomainConst.KEY_CONTACT_PERSON, contactPerson,
            DomainConst.KEY_CONTACT_TEL, contactTel,
            DomainConst.KEY_REQUEST_TYPE, requestBy
        )
    }
}
