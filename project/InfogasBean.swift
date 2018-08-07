//
//  InfogasBean.swift
//  project
//
//  Created by SPJ on 7/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

public class InfogasBean: MaterialBean {
    /** seri */
    public var seri                     : String = DomainConst.BLANK
    /** app order id */
    public var app_order_id             : String = DomainConst.BLANK
    /** id */
    public var id                       : String = DomainConst.BLANK
    /** id */
    public var seri_real                : String = DomainConst.BLANK
    /** code no */
    public var code_no                  : String = DomainConst.BLANK
    /** grand_total */
    public var grand_total              : String = DomainConst.BLANK
    /** total_gas_du */
    public var total_gas_du             : String = DomainConst.BLANK
    /** total_gas_du */
    public var total_gas_du_kg          : String = DomainConst.BLANK
    
    
    
        /**
     * Initializer
     * - parameter jsonData: List of data
     */
    public override init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.seri                   = getString(json: jsonData, key: DomainConst.KEY_SERI)
        self.app_order_id           = getString(json: jsonData, key: DomainConst.KEY_APP_ORDER_ID)
        self.id                     = getString(json: jsonData, key: DomainConst.KEY_ID)
        self.seri_real              = getString(json: jsonData, key: DomainConst.KEY_SERI_REAL)
        self.code_no                = getString(json: jsonData, key: DomainConst.KEY_CODE_NO)
        self.grand_total            = getString(json: jsonData, key: DomainConst.KEY_GRAND_TOTAL)
        self.total_gas_du           = getString(json: jsonData, key: DomainConst.KEY_TOTAL_GAS_DU)
        self.total_gas_du_kg        = getString(json: jsonData, key: DomainConst.KEY_TOTAL_GAS_DU_KG)
        
        
    }
    
    /**
     * Create json data from object
     * - returns: Json string from object data
     */
    public func createJsonData() -> String {
        var retVal = DomainConst.BLANK
        retVal = String.init(format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\"}",
                             DomainConst.KEY_SERI, self.seri,
                             DomainConst.KEY_MATERIALS_ID,      self.material_id,
                             DomainConst.KEY_MATERIALS_TYPE_ID, self.materials_type_id)
        return retVal
    }
    
    /**
     * Create json data from object for update real
     * - returns: Json string from object data
     */
    public func createJsonDataForReal() -> String {
        var retVal = DomainConst.BLANK
        retVal = String.init(format: "{\"%@\":\"%@\",\"%@\":\"%@\"}",
                             DomainConst.KEY_ID, self.id,
                             DomainConst.KEY_SERI_REAL, self.seri_real
                             )
        return retVal
    }
    
    
    //public init(data: MaterialBean) {
    public init(data: MaterialBean, seri: String = DomainConst.BLANK, app_order_id: String = DomainConst.BLANK) {
        super.init()
        self.material_id        = data.material_id
        self.materials_type_id  = data.materials_type_id
        self.material_name      = data.material_name
        self.material_price     = data.material_price
        self.price              = data.price
        self.material_image     = data.material_image
        self.seri               = seri
        self.app_order_id       = app_order_id
    }
    
    public override init() {
        super.init()
        
    }
    //-- BUG0054-SPJ (NguyenPT 20170411) Add new function G07 - Get new data
    
    //++ BUG0071-SPJ (NguyenPT 20170426) Handle save data to UserDefault
    required public init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //-- BUG0071-SPJ (NguyenPT 20170426) Handle save data to UserDefault
}
