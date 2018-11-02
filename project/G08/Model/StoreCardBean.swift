//
//  StoreCardBean.swift
//  project
//
//  Created by SPJ on 5/3/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class StoreCardBean: ConfigBean {
    /** Code number */
    public var code_no:             String = DomainConst.BLANK
    /** Delivery date */
    public var date_delivery:       String = DomainConst.BLANK
    /** Id of customer */
    public var customer_id:         String = DomainConst.BLANK
    /** Name of customer */
    public var customer_name:       String = DomainConst.BLANK
    /** Address of customer */
    public var customer_address:    String = DomainConst.BLANK
    /** Note */
    public var note:                String = DomainConst.BLANK
    /** Created date */
    public var created_date:        String = DomainConst.BLANK
    /** Flag allow update or not */
    public var allow_update:        String = DomainConst.BLANK
    /** Type of store card */
    public var type_in_out:         String = DomainConst.BLANK
    /** Total quantity */
    public var total_qty:           String = DomainConst.BLANK
    /** Order detail */
    public var order_detail:        [OrderDetailBean] = [OrderDetailBean]()
    /** List images */
    public var images:              [UpholdImageInfoItem] = [UpholdImageInfoItem]()
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    public override init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.code_no            = getString(json: jsonData, key: DomainConst.KEY_CODE_NO)
        self.date_delivery      = getString(json: jsonData, key: DomainConst.KEY_DATE_DELIVERY)
        self.customer_id        = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ID)
        self.customer_name      = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_NAME)
        self.customer_address   = getString(json: jsonData, key: DomainConst.KEY_CUSTOMER_ADDRESS)
        self.note               = getString(json: jsonData, key: DomainConst.KEY_NOTE)
        self.created_date       = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE)
        self.allow_update       = getString(json: jsonData, key: DomainConst.KEY_ALLOW_UPDATE)
        self.type_in_out        = getString(json: jsonData, key: DomainConst.KEY_TYPE_IN_OUT)
        self.total_qty          = getString(json: jsonData, key: DomainConst.KEY_TOTAL_QTY)
        if let dataArr = jsonData[DomainConst.KEY_ORDER_DETAIL] as? [[String: AnyObject]] {
            for item in dataArr {
                self.order_detail.append(OrderDetailBean(jsonData: item))
            }
        }
        if let dataArr = jsonData[DomainConst.KEY_LIST_IMAGE] as? [[String: AnyObject]] {
            for listItem in dataArr {
                self.images.append(UpholdImageInfoItem(jsonData: listItem))
            }
        }
    }
    
    override init() {
        super.init()
    }
}
