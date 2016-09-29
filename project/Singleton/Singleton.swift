//
//  Singleton.swift
//  project
//
//  Created by HungHa on 9/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    /**
     * Object instance
     */
    static let sharedInstance: Singleton = {
        let instance = Singleton()
        return instance
    }()
    /** Default Setting */
    let defaults = UserDefaults.standard
    /** Flag login */
    var isLogin = Bool()
    /** Flag training mode */
    var isTrainningMode = Bool()
    /** User token */
    var userToken : String = ""
    /** List menu */
    var menu: [ConfigBean] = [ConfigBean]()
    /** List data uphold */
    var data_uphold: [ConfigBean] = [ConfigBean]()
    /** Max upload */
    var max_upload: String = ""
    /** List data issue */
    var data_issue: [ConfigBean] = [ConfigBean]()
    /** List user info */
    var user_info: UserInfoBean? = nil
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
    
    // MARK - Methods
    // Call When Login Success
    func loginSuccess(_ token: String)  {
        isLogin = true
        userToken = token
        defaults.set(isLogin, forKey: "isLogin")
        defaults.set(userToken, forKey: "user.token")
        defaults.synchronize()
    }
    
    // Call When Logout Success
    func logoutSuccess()  {
        isLogin = false
        userToken = ""
        self.user_info = nil
        defaults.set(isLogin, forKey: "isLogin")
        defaults.set(userToken, forKey: "user.token")
        defaults.synchronize()
    }
    /**
     * Get user token			
     * - return: User token string
     */
    func getUserToken() -> String {
        return userToken
    }
    
    // Check Login
    func checkIsLogin() -> (Bool) {
        self.isLogin = false
        if defaults.object(forKey: "isLogin") != nil {
            self.isLogin = defaults.object(forKey: "isLogin") as! Bool
        }
        
        return self.isLogin
        
    }
    
    // Set Trainning Mode
    func setTrainningMode(_ isTrainningValue :Bool)  {
        self.isTrainningMode = isTrainningValue
        defaults.set(isTrainningMode, forKey: "trainningMode")
        defaults.synchronize()
    }
    
    // Get Trainning Mode
    func checkTrainningMode() -> (Bool) {
        self.isTrainningMode = false
        if defaults.object(forKey: "trainningMode") != nil {
            self.isTrainningMode = defaults.object(forKey: "trainningMode") as! Bool
        }
        return self.isTrainningMode
        
    }
    /**
     * Get server ULR
     * - return: Server URL
     */
    func getServerURL() -> String {
//        if !checkTrainningMode() {
//            return GlobalConst.SERVER_RUNNING_URL
//        }
        return GlobalConst.SERVER_TRAINING_URL
    }
    /**
     * Set user information
     * - parameter userInfo: List user information
     * - parameter userId: Id of user
     * - parameter roleId: Id of role
     */
    func setUserInfo(userInfo: UserInfoBean) {
        self.user_info = userInfo
    }
    /**
     * Set list streets.
     * parameter listStreets: List streets
     */
    func setListStreets(listStreets: [ConfigBean]) {
        for item in listStreets {
            self.list_street.append(item)
        }
    }
}
