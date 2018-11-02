//
//  G05CustomerBean.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05CustomerBean: ConfigBean {
    /** Address of customer */
    var customer_address:           String = DomainConst.BLANK
    /** Phone of customer */
    var customer_phone:             String = DomainConst.BLANK
    /** Agent of customer */
    var customer_agent:             String = DomainConst.BLANK
    /** Type of customer */
    var customer_type:              String = DomainConst.BLANK
    /** Delivery agent of customer */
    var customer_delivery_agent:    String = DomainConst.BLANK
    /** Id of delivery agent of customer */
    var customer_delivery_agent_id: String = DomainConst.BLANK
    /** Id of role */
    var role_id:                    String = DomainConst.BLANK
    /** Phone of customer */
    var agent_id:                   String = DomainConst.BLANK
    /** Contact */
    var contact:                    String = DomainConst.BLANK
    /** Contact note */
    var contact_note:               String = DomainConst.BLANK
    /** Name of sale */
    var sale_name:                  String = DomainConst.BLANK
    /** Phone of sale */
    var sale_phone:                 String = DomainConst.BLANK
    /** Type of sale */
    var sale_type:                  String = DomainConst.BLANK
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init()
        if let idStr = jsonData[DomainConst.KEY_CUSTOMER_ID] as? String {
            self.id = idStr
        } else {
            if let idInt = jsonData[DomainConst.KEY_CUSTOMER_ID] as? Int {
                self.id = String(idInt)
            }
        }
        if let nameStr = jsonData[DomainConst.KEY_CUSTOMER_NAME] as? String  {
            self.name = nameStr
        }
        self.customer_address           = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ADDRESS)
        self.customer_phone             = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_PHONE)
        self.customer_agent             = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_AGENT)
        self.customer_type              = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_TYPE)
        self.customer_delivery_agent    = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_AGENT_DELIVERY)
        self.customer_delivery_agent_id = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_AGENT_DELIVERY_ID)
        self.role_id                    = getString(json: jsonData, key: DomainConst.KEY_ROLE_ID)
        self.agent_id                   = getString(json: jsonData, key: DomainConst.KEY_AGENT_ID)
        self.contact                    = getString(json: jsonData, key: DomainConst.KEY_CONTACT)
        self.contact_note               = getString(json: jsonData, key: DomainConst.KEY_CONTACT_NOTE)
        self.sale_name                  = getString(json: jsonData, key: DomainConst.KEY_SALE_NAME)
        self.sale_phone                 = getString(json: jsonData, key: DomainConst.KEY_SALE_PHONE)
        self.sale_type                  = getString(json: jsonData, key: DomainConst.KEY_SALE_TYPE)
    }
    
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }
    
    /**
     * Get active phone of customer
     * - returns: Active phone is first item in phone list
     */
    public func getActivePhone() -> String {
        var array = self.customer_phone.components(separatedBy: DomainConst.SPLITER_TYPE1)
        if array.count > 0 {
            return array[0]
        }
        return DomainConst.BLANK
    }
}
