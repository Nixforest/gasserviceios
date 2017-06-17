//
//  CCSCodeBean.swift
//  project
//
//  Created by SPJ on 6/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class CCSCodeBean: ConfigBean {
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init()
        if let idStr = jsonData[DomainConst.KEY_ID] as? String {
            self.id = idStr
        } else {
            if let idInt = jsonData[DomainConst.KEY_ID] as? Int {
                self.id = String(idInt)
            }
        }
        if let nameStr = jsonData[DomainConst.KEY_CODE] as? String  {
            self.name = nameStr
        }
    }
}
