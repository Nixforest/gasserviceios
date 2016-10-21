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
    var listUpholdStatus: [ConfigBean] = [ConfigBean]()
    /** Id of role */
    var role_id: String = ""
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
    /** Uphold list data */
    var upholdList: UpholdListRespModel = UpholdListRespModel()
    /** Search customer result */
    var searchCustomerResult: SearchCustomerRespModel = SearchCustomerRespModel()
    /** Shared string */
    var sharedString = ""
    /** Shared int */
    var sharedInt = -1
    /** Current uphold detail */
    var currentUpholdDetail: UpholdBean = UpholdBean()
    
    // MARK - Methods
    /**
     * Call When Login Success
     * - parameter token: User token
     */
    func loginSuccess(_ token: String)  {
        isLogin = true
        userToken = token
        defaults.set(isLogin, forKey: DomainConst.KEY_SETTING_IS_LOGGING)
        defaults.set(userToken, forKey: DomainConst.KEY_SETTING_USER_TOKEN)
        defaults.synchronize()
    }
    
    /**
     * Call When Logout Success
     */
    func logoutSuccess()  {
        isLogin = false
        userToken = ""
        self.user_info = nil
        defaults.set(isLogin, forKey: DomainConst.KEY_SETTING_IS_LOGGING)
        defaults.set(userToken, forKey: DomainConst.KEY_SETTING_USER_TOKEN)
        defaults.synchronize()
    }
    
    /**
     * Get user token			
     * - returns: User token string
     */
    func getUserToken() -> String {
        return userToken
    }
    
    /**
     * Check login
     * - returns: True if login is success, False otherwise
     */
    func checkIsLogin() -> (Bool) {
        self.isLogin = false
        if defaults.object(forKey: DomainConst.KEY_SETTING_IS_LOGGING) != nil {
            self.isLogin = defaults.object(forKey: DomainConst.KEY_SETTING_IS_LOGGING) as! Bool
        }
        
        return self.isLogin
    }
    
    /**
     * Set training mode
     * - parameter isTrainingValue: Training mode value
     */
    func setTrainningMode(_ isTrainningValue :Bool)  {
        self.isTrainningMode = isTrainningValue
        defaults.set(isTrainningMode, forKey: DomainConst.KEY_SETTING_TRAINING_MODE)
        defaults.synchronize()
    }
    
    /**
     * Get Trainning Mode
     * - returns: True if training mode is ON, False otherwise
     */
    func checkTrainningMode() -> (Bool) {
        self.isTrainningMode = false
        if defaults.object(forKey: DomainConst.KEY_SETTING_TRAINING_MODE) != nil {
            self.isTrainningMode = defaults.object(forKey: DomainConst.KEY_SETTING_TRAINING_MODE) as! Bool
        }
        return self.isTrainningMode
    }
    
    /**
     * Get server ULR
     * - returns: Server URL
     */
    func getServerURL() -> String {
//        if !checkTrainningMode() {
//            return DomainConst.SERVER_URL
//        }
        return DomainConst.SERVER_URL_TRAINING
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
    
    /**
     * Save temp data.
     * - parameter loginModel: LoginRespModel
     */
    func saveTempData(loginModel: LoginRespModel) {
        // Uphold status data
        for item in loginModel.data_uphold {
            if item.id == DomainConst.KEY_STATUS {
                for status in item.data {
                    self.listUpholdStatus.append(status)
                }
            }
        }
        // Role id
        self.role_id = loginModel.role_id
        
        // Role name
        self.role_name = loginModel.role_name
    }
    
    /**
     * Check if current user is a customer.
     * returns: True if user is a customer, False otherwise
     */
    func isCustomerUser() -> Bool {
        return (self.role_id == DomainConst.ROLE_CUSTOMER)
    }
    
    /**
     * Save uphold list.
     * - parameter upholdListModel: Sata to save
     */
    func saveUpholdList(upholdListModel: UpholdListRespModel) {
        if self.upholdList.record.count == 0{
            self.upholdList = upholdListModel
        } else {
            self.upholdList.record.append(contentsOf: upholdListModel.record)
        }
    }
    
    /**
     * Clear uphold list
     */
    func clearUpholdList() {
        self.upholdList = UpholdListRespModel()
    }
    
    /**
     * Search customer result
     * - parameter result: Search result model
     */
    func saveSearchCustomerResult(result: SearchCustomerRespModel) {
        self.searchCustomerResult = result
    }
    
    /**
     * Save current uphold detail
     * - parameter model: Search result model
     */
    func saveCurrentUpholdDetail(model: UpholdBean) {
        self.currentUpholdDetail = model
    }
}
