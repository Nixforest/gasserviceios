//
//  FamilyUpholdBean.swift
//  project
//
//  Created by SPJ on 6/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class FamilyUpholdBean: ConfigBean {
    /** Id of customer */
    var customer_id:                String = DomainConst.BLANK
    /** Name of customer */
    var customer_name:              String = DomainConst.BLANK
    /** Address of customer */
    var customer_address:           String = DomainConst.BLANK
    /** Phone of customer */
    var customer_phone:             String = DomainConst.BLANK
    /** Note create */
    var note_create:                String = DomainConst.BLANK
    /** Note of employee */
    var note_employee:              String = DomainConst.BLANK
    /** Flag show confirm button */
    var show_confirm:               String = DomainConst.BLANK
    /** Flag show cancel button */
    var show_cancel:                String = DomainConst.BLANK
    /** Created date */
    var created_date:               String = DomainConst.BLANK
    /** Status number */
    var status_number:              String = DomainConst.BLANK
    /** Flag allow update */
    var allow_update:               String = DomainConst.BLANK
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.name               = getString(json: jsonData, key: DomainConst.KEY_CODE_NO)
        self.customer_name      = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_NAME)
        self.customer_id        = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ID)
        self.customer_address   = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ADDRESS)
        self.customer_phone     = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_PHONE)
        self.note_create        = getString(json: jsonData, key: DomainConst.KEY_NOTE_CREATE)
        self.note_employee      = getString(json: jsonData, key: DomainConst.KEY_NOTE_EMPLOYEE)
        self.show_confirm       = getString(json: jsonData, key: DomainConst.KEY_SHOW_CONFIRM)
        self.show_cancel        = getString(json: jsonData, key: DomainConst.KEY_SHOW_CANCEL)
        self.created_date       = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE)
        self.status_number      = getString(json: jsonData, key: DomainConst.KEY_STATUS_NUMBER)
        self.allow_update       = getString(json: jsonData, key: DomainConst.KEY_ALLOW_UPDATE)
    }
    override public init() {
        super.init()
    }
}
