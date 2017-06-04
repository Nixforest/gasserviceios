//
//  TicketReplyBean.swift
//  project
//
//  Created by SPJ on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class TicketReplyBean: ConfigBean {
    /** User position */
    var position:                   String = DomainConst.BLANK
    /** Content */
    var content:                    String = DomainConst.BLANK
    /** Created date */
    var created_date:               String = DomainConst.BLANK
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.name           = getString(json: jsonData, key: DomainConst.KEY_NAME_USER_REPLY)
        self.position       = getString(json: jsonData, key: DomainConst.KEY_POSITION)
        self.content        = getString(json: jsonData, key: DomainConst.KEY_CONTENT)
        self.created_date   = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE)
    }
    
    override public init() {
        super.init()
    }
}
