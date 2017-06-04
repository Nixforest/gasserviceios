//
//  TicketBean.swift
//  project
//
//  Created by SPJ on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class TicketBean: ConfigBean {
    /** Title */
    var title:                      String = DomainConst.BLANK
    /** Created date */
    var created_date:               String = DomainConst.BLANK
    /** Name user to */
    var name_user_to:               String = DomainConst.BLANK
    /** Name user reply */
    var name_user_reply:            String = DomainConst.BLANK
    /** Time reply */
    var time_reply:                 String = DomainConst.BLANK
    /** Flag can close */
    var can_close:                  String = DomainConst.BLANK
    /** Flag can reply */
    var can_reply:                  String = DomainConst.BLANK
    /** Time reply */
    var list_reply:                 [TicketReplyBean] = [TicketReplyBean]()
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.name               = getString(json: jsonData, key: DomainConst.KEY_CODE_NO)
        self.title              = getString(json: jsonData, key: DomainConst.KEY_TITLE)
        self.created_date       = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE)
        self.name_user_to       = getString(json: jsonData, key: DomainConst.KEY_NAME_USER_TO)
        self.name_user_reply    = getString(json: jsonData, key: DomainConst.KEY_NAME_USER_REPLY)
        self.time_reply         = getString(json: jsonData, key: DomainConst.KEY_TIME_REPLY)
        self.can_close          = getString(json: jsonData, key: DomainConst.KEY_CAN_CLOSE)
        self.can_reply          = getString(json: jsonData, key: DomainConst.KEY_CAN_REPLY)
        if let list = jsonData[DomainConst.KEY_LIST_REPLY] as? [[String: AnyObject]] {
            for item in list {
                self.list_reply.append(TicketReplyBean(jsonData: item))
            }
        }
    }
    override public init() {
        super.init()
    }
}
