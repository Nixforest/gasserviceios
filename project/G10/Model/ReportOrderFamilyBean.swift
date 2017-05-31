//
//  ReportOrderFamilyBean.swift
//  project
//
//  Created by SPJ on 5/31/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportOrderFamilyBean: ConfigBean {
    /** Quantity */
    var qty:                String = DomainConst.BLANK
    /** Price */
    var price:              String = DomainConst.BLANK
    /** Amount */
    var amount:             String = DomainConst.BLANK
    /** Discount */
    var discount:           String = DomainConst.BLANK
    /** Bu vo */
    var bu_vo:              String = DomainConst.BLANK
    /** Revenue */
    var revenue:            String = DomainConst.BLANK
    /** Data */
    var children:           [ReportOrderFamilyBean] = [ReportOrderFamilyBean]()
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init()
        self.name       = getString(json: jsonData, key: DomainConst.KEY_NAME)
        self.qty        = getString(json: jsonData, key: DomainConst.KEY_QUANTITY)
        self.price      = getString(json: jsonData, key: DomainConst.KEY_PRICE)
        self.amount     = getString(json: jsonData, key: DomainConst.KEY_AMOUNT)
        self.discount   = getString(json: jsonData, key: DomainConst.KEY_DISCOUNT)
        self.bu_vo      = getString(json: jsonData, key: DomainConst.KEY_BU_VO)
        self.revenue    = getString(json: jsonData, key: DomainConst.KEY_REVENUE)
        let list = jsonData[DomainConst.KEY_DATA] as? [[String: AnyObject]]
        if list != nil {
            for item in list! {
                children.append(ReportOrderFamilyBean(jsonData: item))
            }
        }
    }
}
