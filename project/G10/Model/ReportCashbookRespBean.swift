//
//  ReportCashbookRespBean.swift
//  project
//
//  Created by SPJ on 5/31/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportCashbookRespBean: NSObject {
    /** Rows */
    var rows:       [ReportCashbookBean]   = [ReportCashbookBean]()
    /** Opening balance */
    var opening_balance:                  String                    = DomainConst.BLANK
    /** ending balance */
    var ending_balance:                  String                    = DomainConst.BLANK
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    public init(jsonData: [String: AnyObject]) {
        super.init()
        let list = jsonData[DomainConst.KEY_ROWS] as? [[String: AnyObject]]
        if list != nil {
            for item in list! {
                rows.append(ReportCashbookBean(jsonData: item))
            }
        }
        
        self.opening_balance         = getString(json: jsonData, key: DomainConst.KEY_OPENING_BALANCE)
        self.ending_balance         = getString(json: jsonData, key: DomainConst.KEY_ENDING_BALANCE)
    }
    override public init() {
        super.init()
    }
}
