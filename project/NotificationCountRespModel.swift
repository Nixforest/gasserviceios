//
//  NotificationCountRespModel.swift
//  project
//
//  Created by Nixforest on 11/1/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class NotificationCountRespModel: BaseRespModel {
    /** Notification count text */
    var NotifyCountText: String = ""
    /** Version code */
    var app_version_code = ""
    /**
     * Initializer
     */
    override init(jsonString: String) {
        // Call super initializer
        super.init(jsonString: jsonString)
        
        // Start parse
        if let jsonData = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
                
                if self.status != "1" {
                    return
                }
                self.NotifyCountText = json[DomainConst.KEY_NOTIFY_COUNT_TEXT] as? String ?? ""
                self.app_version_code = json[DomainConst.KEY_APP_VERSION_CODE] as? String ?? ""
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
        } else {
            print("json is of wrong format")
        }
    }
}
