//
//  LoginRespModel.swift
//  project
//
//  Created by Nixforest on 9/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation

class LoginRespModel : NSObject {
    /** Status */
    var status: String = ""
    /** Code */
    var code: String = ""
    /** Message */
    var message: String = ""
    /** User token */
    var token: String = ""
    /** List menu */
    var menu: [ConfigBean] = [ConfigBean]()
    /** List data uphold */
    var data_uphold: [ConfigBean] = [ConfigBean]()
    /** Max upload */
    var max_upload: String = ""
    /** List data issue */
    var data_issue: [ConfigBean] = [ConfigBean]()
    /** Id of role */
    var role_id: String = ""
    /** Id of user */
    var user_id: String = ""
    /** List user info */
    var user_info: [ConfigBean] = [ConfigBean]()
    /** List check menu */
    var check_menu: [ConfigBean] = [ConfigBean]()
    /** Flag need change pass */
    var need_change_pass: String = ""
    /** Flag need update app */
    var need_update_app: String = ""
    /** Name of role */
    var role_name: String = ""
    /** List streets */
    var list_street: [ConfigBean] = [ConfigBean]()
    /** List agents */
    var list_agent: [ConfigBean] = [ConfigBean]()
    /** List family type */
    var list_hgd_type: [ConfigBean] = [ConfigBean]()
    
    /**
     * Initializer
     */
    init(jsonString: String) {
        super.init()
        if let jsonData = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
                
                // Loop
                for (key, value) in json {
                    let keyName = key as String
                    if let keyValue = value as? String {
                        // If property exists
                        if (self.responds(to: NSSelectorFromString(keyName))) {
                            self.setValue(keyValue, forKey: keyName)
                        }
                    } else {
                        if let keyValueInt = value as? Int {
                            // If property exists
                            if (self.responds(to: NSSelectorFromString(keyName))) {
                                self.setValue(String(keyValueInt), forKey: keyName)
                            }
                        } else {
                            if let keyValueArr = value as? [[String: AnyObject]] {
                                var listConfig = [ConfigBean]()
                                for configItem in keyValueArr {                                    listConfig.append(ConfigBean(jsonData: configItem))
                                }
                                // If property exists
                                if (self.responds(to: NSSelectorFromString(keyName))) {
                                    self.setValue(listConfig, forKey: keyName)
                                }
                            }
                        }
                    }
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
        } else {
            print("json is of wrong format")
        }
    }
}
