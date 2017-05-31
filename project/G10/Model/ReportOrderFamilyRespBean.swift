//
//  ReportOrderFamilyRespBean.swift
//  project
//
//  Created by SPJ on 5/31/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportOrderFamilyRespBean: NSObject {
    /** Rows */
    var rows:                           [ReportOrderFamilyBean]   = [ReportOrderFamilyBean]()
    /** Sum alls */
    var sum_all:                        [ReportOrderFamilyBean]   = [ReportOrderFamilyBean]()
    /** Sum order types */
    var sum_order_type:                 [ReportOrderFamilyBean]   = [ReportOrderFamilyBean]()
    /** Total revenue */
    var total_revenue:                  String                    = DomainConst.BLANK
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    public init(jsonData: [String: AnyObject]) {
        super.init()
        let list = jsonData[DomainConst.KEY_ROWS] as? [[String: AnyObject]]
        if list != nil {
            for item in list! {
                rows.append(ReportOrderFamilyBean(jsonData: item))
            }
        }
        let listSumAll = jsonData[DomainConst.KEY_SUM_ALL] as? [[String: AnyObject]]
        if listSumAll != nil {
            for item in listSumAll! {
                sum_all.append(ReportOrderFamilyBean(jsonData: item))
            }
        }
        let listSumOrder = jsonData[DomainConst.KEY_SUM_ORDER_TYPE] as? [[String: AnyObject]]
        if listSumOrder != nil {
            for item in listSumOrder! {
                sum_order_type.append(ReportOrderFamilyBean(jsonData: item))
            }
        }
        
        self.total_revenue         = getString(json: jsonData, key: DomainConst.KEY_TOTAL_REVENUE)
    }
    override public init() {
        super.init()
    }
}
