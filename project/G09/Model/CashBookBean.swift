//
//  CashBookBean.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class CashBookBean: ConfigBean {
    /** Input date */
    var date_input:             String = DomainConst.BLANK
    /** Name of customer */
    var customer_name:          String = DomainConst.BLANK
    /** Address of customer */
    var customer_address:       String = DomainConst.BLANK
    /** Phone of customer */
    var customer_phone:         String = DomainConst.BLANK
    /** Note */
    var note:                   String = DomainConst.BLANK
    /** Amount */
    var amount:                 String = DomainConst.BLANK
    /** Master lookup id */
    var master_lookup_id:       String = DomainConst.BLANK
    /** Id of customer */
    var customer_id:            String = DomainConst.BLANK
    /** Master lookup text */
    var master_lookup_text:     String = DomainConst.BLANK
    /** Created date */
    var created_date:           String = DomainConst.BLANK
    /** Flag allow update */
    var allow_update:           String = DomainConst.BLANK
    
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
        if let nameStr = jsonData[DomainConst.KEY_CODE_NO] as? String  {
            self.name = nameStr
        }
        self.date_input         = getString(json: jsonData, key: DomainConst.KEY_DATE_INPUT)
        self.customer_name      = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_NAME)
        self.customer_address   = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ADDRESS)
        self.customer_phone     = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_PHONE)
        self.customer_id        = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ID)
        self.note               = getString(json: jsonData, key: DomainConst.KEY_NOTE)
        self.amount             = getString(json: jsonData, key: DomainConst.KEY_AMOUNT)
        self.master_lookup_id   = getString(json: jsonData, key: DomainConst.KEY_MASTER_LOOKUP_ID)
        self.master_lookup_text = getString(json: jsonData, key: DomainConst.KEY_MASTER_LOOKUP_TEXT)
        self.created_date       = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE)
        self.allow_update       = getString(json: jsonData, key: DomainConst.KEY_ALLOW_UPDATE)
    }
    
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }

}
