//
//  RatingUpholdRequest.swift
//  project
//
//  Created by Nixforest on 11/4/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

class RatingUpholdRequest: BaseRequest {
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
//            if model.status == DomainConst.RESPONSE_STATUS_SUCCESS {
//                // Hide overlay
//                LoadingView.shared.hideOverlayView()
//                // Clear data
//                (self.view as! G01F03VC).clearData()
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
    func setData(id: String, ratingStatusId: String,
                 listRating: [Int], content: String) {
        var rating = "{"
        for i in 0..<listRating.count {
            rating += String.init(format: "\"%@\":%d", BaseModel.shared.listRatingType[i].id, listRating[i])
            if i < (listRating.count - 1) {
                rating += ","
            }
        }
        rating += "}"
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%@,\"%@\":\"%@\"}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_UPHOLD_ID, id,
            DomainConst.KEY_RATING_STATUS, ratingStatusId,
            DomainConst.KEY_RATING_TYPE, rating,
            DomainConst.KEY_RATING_NOTE, content
        )
    }
    
    /**
     * Request create uphold reply
     * - parameter id:              Id of uphold item
     * - parameter ratingStatusId:  Id of rating status
     * - parameter listRating:      List rating type
     * - parameter content:         Content
     * - parameter view:            View controller
     */
    public static func requestRatingUphold(action: Selector,
                                           id: String, ratingStatusId: String,
                                    listRating: [Int], content: String,
                                    view: BaseViewController) {
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = RatingUpholdRequest(url: DomainConst.PATH_SITE_UPHOLD_CUSTOMER_RATING, reqMethod: DomainConst.HTTP_POST_REQUEST, view: view)
        request.setData(id: id, ratingStatusId: ratingStatusId, listRating: listRating, content: content)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
        
    }
}
