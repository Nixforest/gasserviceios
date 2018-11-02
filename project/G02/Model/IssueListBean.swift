//
//  IssueListBean.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class IssueListBean: ConfigBean {
    /** Code no */
    var code_no:                            String = DomainConst.BLANK
    /** Customer name */
    var customer_name:                      String = DomainConst.BLANK
    /** Customer address */
    var customer_address:                   String = DomainConst.BLANK
    /** Name of sale */
    var sale_name:                          String = DomainConst.BLANK
    /** Created by */
    var created_by:                         String = DomainConst.BLANK
    /** Created date */
    var created_date:                       String = DomainConst.BLANK
    /** Flag can reply */
    var can_reply:                          String = DomainConst.BLANK
    /** Flag can close */
    var can_close:                          String = DomainConst.BLANK
    /** Flag can reopen */
    var can_reopen:                         String = DomainConst.BLANK
    /** Status text */
    var status_text:                        String = DomainConst.BLANK
    /** Problem text */
    var problem_text:                       String = DomainConst.BLANK
    /** Id of problem */
    var problem_id:                         String = DomainConst.BLANK
    /** Required message */
    var required_message:                   String = DomainConst.BLANK
    /** Customer phone */
    var customer_phone:                     String = DomainConst.BLANK
    /** Contact person */
    var contact_person:                     String = DomainConst.BLANK
    
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
        if let nameStr = jsonData[DomainConst.KEY_TITLE] as? String  {
            self.name = nameStr
        }
        self.code_no            = getString(json: jsonData, key: DomainConst.KEY_CODE_NO)
        self.customer_name      = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_NAME)
        self.customer_address   = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ADDRESS)
        self.sale_name          = getString(json: jsonData, key: DomainConst.KEY_SALE_NAME)
        self.created_by         = getString(json: jsonData, key: DomainConst.KEY_CREATED_BY)
        self.created_date       = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE)
        self.can_reply          = getString(json: jsonData, key: DomainConst.KEY_CAN_REPLY)
        self.can_close          = getString(json: jsonData, key: DomainConst.KEY_CAN_CLOSE)
        self.can_reopen         = getString(json: jsonData, key: DomainConst.KEY_CAN_REOPEN)
        self.status_text        = getString(json: jsonData, key: DomainConst.KEY_STATUS_TEXT)
        self.problem_id         = getString(json: jsonData, key: DomainConst.KEY_PROBLEM_ID)
        self.problem_text       = getString(json: jsonData, key: DomainConst.KEY_PROBLEM_TEXT)
        self.required_message   = getString(json: jsonData, key: DomainConst.KEY_REQUIRED_MESSAGE)
        self.customer_phone     = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_PHONE)
        self.contact_person     = getString(json: jsonData, key: DomainConst.KEY_CONTACT_PERSON)
    }
}
