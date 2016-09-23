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
    var userToken : String = ""
    
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
}
