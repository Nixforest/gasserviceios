//
//  Singleton.swift
//  project
//
//  Created by HungHa on 9/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    static let sharedInstance: Singleton = {
        let instance = Singleton()
        
        return instance
        

    }()
    /*private static var __once: () = {
            Static.instance = Singleton()
        }()
    class var sharedInstance: Singleton {
        struct Static {
            static var onceToken: Int = 0
            static var instance: Singleton? = nil
        }
        _ = Singleton.__once
        return Static.instance!
    }*/
    let defaults = UserDefaults.standard
    
    var isLogin = Bool()
    var isTrainningMode = Bool()
    
    // Call When Login Success
    func loginSuccess()  {
        self.isLogin = true
        defaults.set(isLogin, forKey: "isLogin")
        defaults.synchronize()
    }
    
    // Call When Logout Success
    func logoutSuccess()  {
        self.isLogin = false
        defaults.set(isLogin, forKey: "isLogin")
        defaults.synchronize()
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
    
}
