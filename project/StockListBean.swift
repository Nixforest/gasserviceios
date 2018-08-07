//
//  StockListBean.swift
//  project
//
//  Created by SPJ on 7/25/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

open class StockListBean: OrderVIPListBean {
    /** total gas */
    public var total_gas:             String = DomainConst.BLANK
    /** total gas du */
    public var total_gas_du:             String = DomainConst.BLANK
    /** total gas du kg */
    public var total_gas_du_kg:             String = DomainConst.BLANK
    /** customer id */
    public var customer_id:             String = DomainConst.BLANK
    /** type */
    public var type:             String = DomainConst.BLANK
    
    
    override public init() {
        super.init()
    }
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    public override init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.total_gas                = getString(json: jsonData, key: DomainConst.KEY_TOTAL_GAS)
        self.total_gas_du          = getString(json: jsonData, key: DomainConst.KEY_TOTAL_GAS_DU)
        self.total_gas_du_kg          = getString(json: jsonData, key: DomainConst.KEY_TOTAL_GAS_DU_KG)
        self.customer_id          = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ID)
        self.type          = getString(json: jsonData, key: DomainConst.KEY_TYPE)
    }
    
    

}
