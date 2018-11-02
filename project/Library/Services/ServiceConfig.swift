//
//  ServiceConfig.swift
//  dental
//
//  Created by Lâm Phạm on 1/11/18.
//  Copyright © 2018 SPJ. All rights reserved.
//

import UIKit


let  serviceConfig = ServiceConfig.sharedInstance()


class ServiceConfig: NSObject {
    
    let url = "http://vietmy.immortal.vn/index.php/api/"
    var token = ""
    
    static var instance: ServiceConfig!
    
    class func sharedInstance() -> ServiceConfig {
        if(self.instance == nil) {
            self.instance = (self.instance ?? ServiceConfig())
        }
        return self.instance
    }
    
}


