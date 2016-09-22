//
//  Singleton.swift
//  project
//
//  Created by HungHa on 9/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    class var sharedInstance: Singleton {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: Singleton? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Singleton()
        }
        return Static.instance!
    }
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var isLogin = Bool()
    var isTrainningMode = Bool()
    
    // Call When Login Success
    func loginSuccess()  {
        self.isLogin = true
        defaults.setObject(isLogin, forKey: "isLogin")
        defaults.synchronize()
    }
    
    // Call When Logout Success
    func logoutSuccess()  {
        self.isLogin = false
        defaults.setObject(isLogin, forKey: "isLogin")
        defaults.synchronize()
    }
    
    // Check Login
    func checkIsLogin() -> (Bool) {
        self.isLogin = false
        if defaults.objectForKey("isLogin") != nil {
            self.isLogin = defaults.objectForKey("isLogin") as! Bool
        }
        
        return self.isLogin
        
    }
    
    // Set Trainning Mode
    func setTrainningMode(isTrainningValue :Bool)  {
        self.isTrainningMode = isTrainningValue
        defaults.setObject(isTrainningMode, forKey: "trainningMode")
        defaults.synchronize()
    }
    
    // Get Trainning Mode
    func checkTrainningMode() -> (Bool) {
        self.isTrainningMode = false
        if defaults.objectForKey("trainningMode") != nil {
            self.isTrainningMode = defaults.objectForKey("trainningMode") as! Bool
        }
        return self.isTrainningMode
        
    }
    
}
