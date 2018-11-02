//
//  ReportInventoryBean.swift
//  project
//
//  Created by SPJ on 5/30/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportInventoryBean: ConfigBean {
    /** Begin quantity */
    var beginQty:           String = DomainConst.BLANK
    /** In quantity */
    var inQty:              String = DomainConst.BLANK
    /** Out quantity */
    var outQty:             String = DomainConst.BLANK
    /** End quantity */
    var endQty:             String = DomainConst.BLANK
    /** Data */
    var children:           [ReportInventoryBean] = [ReportInventoryBean]()
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init()
        self.name       = getString(json: jsonData, key: DomainConst.KEY_NAME)
        self.beginQty       = getString(json: jsonData, key: DomainConst.KEY_BEGIN)
        self.inQty          = getString(json: jsonData, key: DomainConst.KEY_IN)
        self.outQty         = getString(json: jsonData, key: DomainConst.KEY_OUT)
        self.endQty         = getString(json: jsonData, key: DomainConst.KEY_END)
        let list = jsonData[DomainConst.KEY_DATA] as? [[String: AnyObject]]
        if list != nil {
            for item in list! {
                children.append(ReportInventoryBean(jsonData: item))
            }
        }
    }
    
    /**
     * Check if quantity is changed
     * - returns: True if begin quantity is not equal end quantity, False otherwise
     */
    public func isChanged() -> Bool {
        return (inQty != DomainConst.NUMBER_ZERO_VALUE) || (outQty != DomainConst.NUMBER_ZERO_VALUE)
    }
}
