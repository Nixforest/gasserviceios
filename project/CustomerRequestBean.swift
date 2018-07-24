//
//  CustomerRequestBean.swift
//  project
//
//  Created by SPJ on 7/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerRequestBean: CustomerRequestListBean{
    /** type customer */
    public var type_customer:           String = DomainConst.BLANK
    /** sale id */
    public var sale_id:                 String = DomainConst.BLANK
    /** agent id */
    public var agent_id:                String = DomainConst.BLANK
    /** created by*/
    public var created_by:              String = DomainConst.BLANK
    /** last update by */
    public var last_update_by:          String = DomainConst.BLANK
    /** last update time */
    public var last_update_time:        String = DomainConst.BLANK
    /** image */
    public var img:                     String = DomainConst.BLANK
    
    public var json:                    [OrderDetailBean] = [OrderDetailBean]()
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)        
        self.type_customer      = getString(json: jsonData, key: DomainConst.KEY_TYPE_CUSTOMER)
        self.sale_id = getString(json: jsonData, key: DomainConst.KEY_SALE_ID)
        self.agent_id = getString(json: jsonData, key: DomainConst.KEY_AGENT_ID)
        self.created_by = getString(json: jsonData, key: DomainConst.KEY_CREATED_BY)
        self.last_update_by = getString(json: jsonData, key: DomainConst.KEY_LAST_UPDATE_BY)
        self.last_update_time = getString(json: jsonData, key: DomainConst.KEY_LAST_UPDATE_TIME)
        self.img = getString(json: jsonData, key: DomainConst.KEY_IMAGE)
        if let dataArr = jsonData[DomainConst.KEY_JSON] as? [[String: AnyObject]] {
            
            for item in dataArr {
                
                self.json.append(OrderDetailBean(jsonData: item))
            }
            
        }
        
    }
    
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }

}
