//
//  RatingUpholdRequest.swift
//  project
//
//  Created by Nixforest on 11/4/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class RatingUpholdRequest: BaseRequest {
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
            print(dataString)
            // Convert to object
            let model: BaseRespModel = BaseRespModel(jsonString: dataString as! String)
            if model.status == "1" {
                // Hide overlay
                LoadingView.shared.hideOverlayView()
                // Clear data
                (self.view as! G01F03VC).clearData()
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
    override init(url: String, reqMethod: String, view: CommonViewController) {
        super.init(url: url, reqMethod: reqMethod, view: view)
    }
    
    /**
     * Set data content
     * - parameter upholdId:    Id of uphold
     * - parameter replyId:     Id of uphold
     */
    func setData(id: String, ratingStatusId: String,
                 listRating: [Int], content: String) {
        var rating = "{"
        for i in 0..<listRating.count {
            rating += String.init(format: "\"%@\":%d", Singleton.sharedInstance.listRatingType[i].id, listRating[i])
            if i < (listRating.count - 1) {
                rating += ","
            }
        }
        rating += "}"
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%@,\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, Singleton.sharedInstance.getUserToken(),
            DomainConst.KEY_UPHOLD_ID, id,
            DomainConst.KEY_RATING_STATUS, ratingStatusId,
            DomainConst.KEY_RATING_TYPE, rating,
            DomainConst.KEY_RATING_NOTE, content
        )
    }
}
