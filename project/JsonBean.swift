//
//  JsonBean.swift
//  project
//
//  Created by SPJ on 7/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class JsonBean: ConfigBean {
    /** materials id */
    public var materials_id:             String = DomainConst.BLANK
    /** materials type id*/
    public var materials_type_id:        String = DomainConst.BLANK
    /** qty */
    public var qty:                      String = DomainConst.BLANK
    /** materials_name */
    public var materials_name:          String = DomainConst.BLANK

    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    public override init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.materials_id                 = getString(json: jsonData, key: DomainConst.KEY_MATERIALS_ID)
        self.materials_type_id                 = getString(json: jsonData, key: DomainConst.KEY_MATERIALS_TYPE_ID)
        self.qty                 = getString(json: jsonData, key: DomainConst.KEY_QUANTITY)
        self.materials_name                 = getString(json: jsonData, key: DomainConst.KEY_MATERIALS_NAME)
    }
    
    override init() {
        super.init()
    }
}
