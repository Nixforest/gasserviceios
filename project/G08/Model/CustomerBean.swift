//
//  CustomerBean.swift
//  project
//
//  Created by SPJ on 5/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerBean: ConfigBean {
    /** Phone */
    var phone:      String = DomainConst.BLANK
    /** Address */
    var address:    String = DomainConst.BLANK
    
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
        if let nameStr = jsonData[DomainConst.KEY_FIRST_NAME] as? String  {
            self.name = nameStr
        }
        
        self.phone      = getString(json: jsonData, key: DomainConst.KEY_PHONE)
        self.address    = getString(json: jsonData, key: DomainConst.KEY_ADDRESS)
    }
    
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }
    
    /**
     * Initialize
     * - parameter id: Id
     * - parameter name: Name
     * - parameter phone: Phone
     * - parameter address: Address
     * - parameter id: Id
     */
    public init(id: String, name: String, phone: String, address: String) {
        super.init()
        self.id = id
        self.name = name
        self.phone = phone
        self.address = address
    }
}
