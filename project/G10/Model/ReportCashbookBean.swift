//
//  ReportCashbookBean.swift
//  project
//
//  Created by SPJ on 5/31/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportCashbookBean: ConfigBean {
    /** Customer name */
    var customer_name:      String = DomainConst.BLANK
    /** Quantity */
    var qty:                String = DomainConst.BLANK
    /** In quantity */
    var inQty:              String = DomainConst.BLANK
    /** Out quantity */
    var outQty:             String = DomainConst.BLANK
    /** End quantity */
    var endQty:             String = DomainConst.BLANK
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init()
        self.name           = getString(json: jsonData, key: DomainConst.KEY_NAME)
        self.customer_name  = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_NAME)
        self.qty            = getString(json: jsonData, key: DomainConst.KEY_QUANTITY)
        self.inQty          = getString(json: jsonData, key: DomainConst.KEY_IN)
        self.outQty         = getString(json: jsonData, key: DomainConst.KEY_OUT)
        self.endQty         = getString(json: jsonData, key: DomainConst.KEY_END)
    }
}
