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
    /** json */
    public var json:                    [OrderDetailBean] = [OrderDetailBean]()
    /** List images */
    public var images:                  [UpholdImageInfoItem] = [UpholdImageInfoItem]()
    /** action_invest */
    public var action_invest:                     String = DomainConst.BLANK
    
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
        if let dataArr = jsonData[DomainConst.KEY_LIST_IMAGE] as? [[String: AnyObject]] {
            for listItem in dataArr {
                self.images.append(UpholdImageInfoItem(jsonData: listItem))
            }
        }
        self.action_invest = getString(json: jsonData, key: DomainConst.KEY_ACTION_INVEST)
        
        
    }
    
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }

}
