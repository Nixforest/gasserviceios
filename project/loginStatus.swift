//
//  loginStatus.swift
//  project
//
//  Created by Lâm Phạm on 8/30/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

internal class loginStatus: NSObject {
    
   internal class var sharedInstance: loginStatus {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: loginStatus? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = loginStatus()
        }
        return Static.instance!
    }

    internal var status:Bool!
    
}
