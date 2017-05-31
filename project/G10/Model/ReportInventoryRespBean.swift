//
//  ReportInventoryRespBean.swift
//  project
//
//  Created by SPJ on 5/30/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportInventoryRespBean: NSObject {
    /** Rows */
    var rows:                           [ReportInventoryBean]   = [ReportInventoryBean]()
    /** Flag allow update */
    var allow_update_storecard_hgd:     String                  = DomainConst.BLANK
    /** Time update */
    var next_time_update_storecard_hgd: String                  = DomainConst.BLANK
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    public init(jsonData: [String: AnyObject]) {
        super.init()
        let list = jsonData[DomainConst.KEY_ROWS] as? [[String: AnyObject]]
        if list != nil {
            for item in list! {
                rows.append(ReportInventoryBean(jsonData: item))
            }
        }
        
        self.allow_update_storecard_hgd         = getString(json: jsonData, key: DomainConst.KEY_ALLOW_UPDATE_STORECARD_HGD)
        self.next_time_update_storecard_hgd         = getString(json: jsonData, key: DomainConst.KEY_NEXT_UPDATE_STORECARD_HGD)
    }
    override public init() {
        super.init()
    }
}
