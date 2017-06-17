//
//  NotifyBean.swift
//  project
//
//  Created by SPJ on 6/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class NotifyBean: ConfigBean {
    /** Status */
    var status:                     String = DomainConst.BLANK
    /** Type */
    var type:                       String = DomainConst.BLANK
    /** Object id */
    var obj_id:                     String = DomainConst.BLANK
    /** Time sent */
    var time_send:                  String = DomainConst.BLANK
    /** Created date */
    var created_date:               String = DomainConst.BLANK
    /** Created date on history */
    var created_date_on_history:    String = DomainConst.BLANK
    /** Reply id */
    var reply_id:                   String = DomainConst.BLANK
    
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
        self.status                 = getString(json: jsonData, key: DomainConst.KEY_STATUS)
        self.type                   = getString(json: jsonData, key: DomainConst.KEY_TYPE)
        self.obj_id                 = getString(json: jsonData, key: DomainConst.KEY_OBJECT_ID)
        self.time_send              = getString(json: jsonData, key: DomainConst.KEY_TIME_SEND)
        self.created_date           = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE)
        self.created_date_on_history = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE_ON_HISTORY)
        self.reply_id               = getString(json: jsonData, key: DomainConst.KEY_REPLY_ID)
    }
}
