//
//  LoginRespModel.swift
//  project
//
//  Created by Nixforest on 9/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation

class LoginRespModel : BaseRespModel {
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
    /** List family type */
    var list_hgd_invest: [ConfigBean] = [ConfigBean]()
    
    
    /**
     * Initializer
     */
    override init(jsonString: String) {
        super.init(jsonString: jsonString)
        if let jsonData = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
                
                // Loop
//                for (key, value) in json {
//                    let keyName = key as String
//                    if let keyValue = value as? String {
//                        // If property exists
//                        if (self.responds(to: NSSelectorFromString(keyName))) {
//                            self.setValue(keyValue, forKey: keyName)
//                        }
//                    } else {
//                        if let keyValueInt = value as? Int {
//                            // If property exists
//                            if (self.responds(to: NSSelectorFromString(keyName))) {
//                                self.setValue(String(keyValueInt), forKey: keyName)
//                            }
//                        } else {
//                            if let keyValueArr = value as? [[String: AnyObject]] {
//                                var listConfig = [ConfigBean]()
//                                for configItem in keyValueArr {                                    listConfig.append(ConfigBean(jsonData: configItem))
//                                }
//                                // If property exists
//                                if (self.responds(to: NSSelectorFromString(keyName))) {
//                                    self.setValue(listConfig, forKey: keyName)
//                                }
//                            }
//                        }
//                    }
//                }
                // Menu
                let menuList = json["menu"] as? [[String: AnyObject]]
                for menu in menuList! {
                    self.menu.append(ConfigBean(jsonData: menu))
                }
                // Data uphold
                let dataUpholdList = json["data_uphold"] as? [[String: AnyObject]]
                for uphold in dataUpholdList! {
                    self.data_uphold.append(ConfigBean(jsonData: uphold))
                }
                
                // Max upload
                let maxUpload = json["max_upload"] as? Int ?? 0
                if maxUpload != 0 {
                    self.max_upload = String(maxUpload)
                }
                // Data issue
                let dataIssueList = json["data_issue"] as? [[String: AnyObject]]
                for issue in dataIssueList! {
                    self.data_issue.append(ConfigBean(jsonData: issue))
                }
                
                // Role id
                self.role_id = json["role_id"] as? String ?? ""
                
                // User id
                self.user_id = json["user_id"] as? String ?? ""
                
                // User information
                let userInfoList = json["user_info"] as? [[String: AnyObject]]
                for info in userInfoList! {
                    self.user_info.append(ConfigBean(jsonData: info))
                }
                
                
                // Check menu
                let checkMenuList = json["check_menu"] as? [[String: AnyObject]]
                for checkMenu in checkMenuList! {
                    self.check_menu.append(ConfigBean(jsonData: checkMenu))
                }
                
                // Flag need change password
                self.need_change_pass = json["need_change_pass"] as? String ?? ""
                
                // Flag need update application
                let needUpdateApp = json["need_update_app"] as? Int ?? 0
                if needUpdateApp != 0 {
                    self.need_update_app = String(needUpdateApp)
                }
                
                // Role name
                self.role_name = json["role_name"] as? String ?? ""
                
                // List streets
                let streetList = json["list_street"] as? [[String: AnyObject]]
                for street in streetList! {
                    self.list_street.append(ConfigBean(jsonData: street))
                }
                
                // List agents
                let agentList = json["list_agent"] as? [[String: AnyObject]]
                for agent in agentList! {
                    self.list_agent.append(ConfigBean(jsonData: agent))
                }
                
                // List agentd family
                let agentFList = json["list_hgd_type"] as? [[String: AnyObject]]
                for agent in agentFList! {
                    self.list_hgd_type.append(ConfigBean(jsonData: agent))
                }
                
                // List agentd family invest
                let agentFIList = json["list_hgd_invest"] as? [[String: AnyObject]]
                for agent in agentFIList! {
                    self.list_hgd_invest.append(ConfigBean(jsonData: agent))
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
        } else {
            print("json is of wrong format")
        }
    }
}
