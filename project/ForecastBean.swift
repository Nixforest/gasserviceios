//
//  ForecastBean.swift
//  project
//
//  Created by SPJ on 10/9/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework
//++ BUG0224-SPJ (KhoiVT 20180930) Gasservice - ForeCast Amount Gas
class ForecastBean: ConfigBean {
    /** Can Notify */
    public var can_notify:                  Int = 0
    /** Gas Percent */
    public var gas_percent:                 Int = 0
    /** Date Forecast */
    public var date_forecast:               String = DomainConst.BLANK
    /** Last Order */
    public var last_order:                  String = DomainConst.BLANK
    /** Forecast Days*/
    public var days_forecast:               Int = 0
    
    /** schedule*/
    public var schedule:               TimerBean = TimerBean()
    
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    public override init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.id                 = getString(json: jsonData, key: DomainConst.KEY_ID)
        self.can_notify            = getInt(json: jsonData, key: DomainConst.KEY_CAN_NOTIFY)
        self.gas_percent            = getInt(json: jsonData, key: DomainConst.KEY_GAS_PERCENT)
        self.date_forecast            = getString(json: jsonData, key: DomainConst.KEY_DATE_FORECAST)
        self.last_order            = getString(json: jsonData, key: DomainConst.KEY_LAST_ORDER)
        self.days_forecast            = getInt(json: jsonData, key: DomainConst.KEY_DATES_FORECAST)
        // Record
        if let str = jsonData[DomainConst.KEY_SCHEDULE] as? [String: AnyObject]{
            self.schedule = TimerBean(jsonData: str)
        }
    }
    
    override init() {
        super.init()
    }
}
//-- BUG0224-SPJ (KhoiVT 20180930) Gasservice - ForeCast Amount Gas
