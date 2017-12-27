//
//  GasRemainListBean.swift
//  project
//
//  Created by SPJ on 12/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class GasRemainListBean: ConfigBean {
    /** Input date */
    var date_input:             String      = DomainConst.BLANK
    /** Export flag */
    var has_export:             String      = DomainConst.BLANK
    /** Gas amount */
    var amount_gas:             String      = DomainConst.BLANK 
    /** Information of weight */
    var weight_info:            String      = DomainConst.BLANK    
    /** Name of material */
    var materials_name:         String      = DomainConst.BLANK    
    /** Update flag */
    var allow_update:           Int         = 0
    /** Swipe flag */
    var allow_swipe:            Int         = 0
    /** Name of customer */
    var customer_name:          String      = DomainConst.BLANK
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init()
        if let idStr = jsonData[DomainConst.KEY_CUSTOMER_ID] as? String {
            self.id = idStr
        } else {
            if let idInt = jsonData[DomainConst.KEY_CUSTOMER_ID] as? Int {
                self.id = String(idInt)
            }
        }
        if let nameStr = jsonData[DomainConst.KEY_SERI] as? String  {
            self.name = nameStr
        }
        self.date_input         = getString(json: jsonData, key: DomainConst.KEY_DATE_INPUT)
        self.has_export         = getString(json: jsonData, key: DomainConst.KEY_HAS_EXPORT)
        self.amount_gas         = getString(json: jsonData, key: DomainConst.KEY_AMOUNT_GAS)
        self.weight_info        = getString(json: jsonData, key: DomainConst.KEY_WEIGHT_INFO)
        self.materials_name     = getString(json: jsonData, key: DomainConst.KEY_MATERIALS_NAME)
        self.customer_name      = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_NAME)
        self.allow_update       = getInt(json: jsonData,
                                         key: DomainConst.KEY_ALLOW_UPDATE)
        self.allow_swipe       = getInt(json: jsonData,
                                         key: DomainConst.KEY_ALLOW_SWIPE)
    }
    
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }
}
