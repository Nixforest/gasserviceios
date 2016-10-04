//
//  UserInfoBean.swift
//  project
//
//  Created by Nixforest on 9/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class UserInfoBean: NSObject {
    /** First name */
    var first_name: String = ""
    /** Phone */
    var phone: String = ""
    /** Address */
    var address: String = ""
    /** Avatar image */
    var image_avatar: String = ""
    /**
     * Initializer
     */
    override init() {
        
    }
    /**
     * Initializer
     * - parameter userInfo: List user information
     * - parameter userId: Id of user
     * - parameter roleId: Id of role
     */
//    init(userInfo: [ConfigBean], userId: String, roleId: String) {
//        for config in userInfo {
//            if config.id == "first_name" {
//                self.name = config.name
//            }
//            if config.id == "province_id" {
//                self.province_id = config.name
//            }
//            if config.id == "district_id" {
//                self.district_id = config.name
//            }
//            if config.id == "ward_id" {
//                self.ward_id = config.name
//            }
//        }
//        self.user_id = userId
//        self.role_id = roleId
//    }
    init(jsonString: [String: AnyObject]) {
        super.init()
//        if let jsonData = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
//            do {
//                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
//                
//                // Loop
////                for (key, value) in json {
////                    let keyName = key as String
////                    if let keyValue = value as? String {
////                        // If property exists
////                        if (self.responds(to: NSSelectorFromString(keyName))) {
////                            self.setValue(keyValue, forKey: keyName)
////                        }
////                    } else {
////                        if let keyValueInt = value as? Int {
////                            // If property exists
////                            if (self.responds(to: NSSelectorFromString(keyName))) {
////                                self.setValue(String(keyValueInt), forKey: keyName)
////                            }
////                        }
////                    }
////                }
//                self.first_name = json["first_name"] as? String ?? ""
//                self.phone = json["phone"] as? String ?? ""
//                self.address = json["address"] as? String ?? ""
//                self.image_avatar = json["image_avatar"] as? String ?? ""
//            } catch let error as NSError {
//                print("Failed to load: \(error.localizedDescription)")
//            }
//            
//        } else {
//            print("json is of wrong format")
//        }
        self.first_name = jsonString["first_name"] as? String ?? ""
        self.phone = jsonString["phone"] as? String ?? ""
        self.address = jsonString["address"] as? String ?? ""
        self.image_avatar = jsonString["image_avatar"] as? String ?? ""
    }
}
