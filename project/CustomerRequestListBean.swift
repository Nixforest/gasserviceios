//
//  CustomerRequestBean.swift
//  project
//
//  Created by SPJ on 7/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerRequestListBean: ConfigBean {
    /** Code number */
    public var code_no:             String = DomainConst.BLANK
    /** Created date */
    public var created_date:        String = DomainConst.BLANK
    /** Id of customer */
    public var customer_id:         String = DomainConst.BLANK
    /** Name of customer */
    public var first_name:          String = DomainConst.BLANK
    /** Address of customer */
    public var address:             String = DomainConst.BLANK
    /** Status */
    public var status:              String = DomainConst.BLANK
    /** Note */
    public var note:                String = DomainConst.BLANK
    /** Flag allow update or not */
    public var allow_update:        String = DomainConst.BLANK
    
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    public override init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.id                 = getString(json: jsonData, key: DomainConst.KEY_ID)
        self.code_no            = getString(json: jsonData, key: DomainConst.KEY_CODE_NO)
        self.created_date       = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE)
        self.customer_id        = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ID)
        self.first_name         = getString(json: jsonData, key: DomainConst.KEY_FIRST_NAME)
        self.address            = getString(json: jsonData, key: DomainConst.KEY_ADDRESS)
        self.status             = getString(json: jsonData, key: DomainConst.KEY_STATUS)
        self.note               = getString(json: jsonData, key: DomainConst.KEY_NOTE)
        self.allow_update       = getString(json: jsonData, key: DomainConst.KEY_ALLOW_UPDATE)
    }
    
    override init() {
        super.init()
    }
}

