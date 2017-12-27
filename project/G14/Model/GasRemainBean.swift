//
//  GasRemainBean.swift
//  project
//
//  Created by SPJ on 12/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class GasRemainBean: GasRemainListBean {    
    /** Empty amount */
    var amount_empty:           String      = DomainConst.BLANK
    /** Has gas amount */
    var amount_has_gas:         String      = DomainConst.BLANK
    /** Address of customer */
    var customer_address:       String      = DomainConst.BLANK
    /** Phone of customer */
    var customer_phone:         String      = DomainConst.BLANK
    /** Id of customer */
    var customer_id:            String      = DomainConst.BLANK
    /** Id of material */
    var materials_id:           String      = DomainConst.BLANK
    /** Type of material */
    var materials_type_id:      String      = DomainConst.BLANK
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init()
        self.amount_empty      = getString(json: jsonData, key: DomainConst.KEY_AMOUNT_EMPTY)
        self.amount_has_gas      = getString(json: jsonData, key: DomainConst.KEY_AMOUNT_HAS_GAS)
        self.customer_address      = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ADDRESS)
        self.customer_phone      = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_PHONE)
        self.customer_id      = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ID)
        self.materials_id      = getString(json: jsonData, key: DomainConst.KEY_MATERIALS_ID)
        self.materials_type_id      = getString(json: jsonData, key: DomainConst.KEY_MATERIALS_TYPE_ID)
    }
    
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }
    
}
