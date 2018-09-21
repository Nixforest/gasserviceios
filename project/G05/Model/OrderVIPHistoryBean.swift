//
//  OrderVIPHistoryBean.swift
//  project
//
//  Created by SPJ on 7/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderVIPHistoryBean: ConfigBean {
    /** Id of Agent */
    var agent_id:                       String = DomainConst.BLANK
    /** Created date */
    var created_date:                   String = DomainConst.BLANK
    /** Id of customer */
    var customer_id:                    String = DomainConst.BLANK
    /** Id of Employee maintain */
    var employee_maintain_id:           String = DomainConst.BLANK
    /** Id of CCS */
    var monitor_market_development_id:  String = DomainConst.BLANK
    /** Note */
    var note:                           String = DomainConst.BLANK
    /** Type of order */
    var order_type:                     String = DomainConst.BLANK
    /** Amount type */
    var type_amount:                    String = DomainConst.BLANK
    /** Order detail */
    var order_detail:                   [OrderVIPDetailBean] = [OrderVIPDetailBean]()
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init()
        self.agent_id           = getString(json: jsonData, key: DomainConst.KEY_AGENT_ID)
        self.created_date           = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE)
        self.customer_id           = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ID)
        self.employee_maintain_id           = getString(json: jsonData, key: DomainConst.KEY_EMPLOYEE_MAINTAIN_ID)
        self.monitor_market_development_id           = getString(json: jsonData, key: DomainConst.KEY_MONITOR_MARKET_DEV_ID)
        self.note           = getString(json: jsonData, key: DomainConst.KEY_NOTE)
        self.order_type           = String(getInt(json: jsonData, key: DomainConst.KEY_ORDER_TYPE))
        self.type_amount           = String(getInt(json: jsonData, key: DomainConst.KEY_TYPE_AMOUNT))
        if let dataArr = jsonData[DomainConst.KEY_ORDER_DETAIL] as? [[String: AnyObject]] {
            for item in dataArr {
                self.order_detail.append(OrderVIPDetailBean(jsonData: item))
            }
        }
    }
    
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }
}
