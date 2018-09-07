//
//  StockBean.swift
//  project
//
//  Created by SPJ on 7/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class StockBean: StockListBean{
    /** stock list*/
    public var stock:                   [InfogasBean] = [InfogasBean]()
    /** allow update*/
    public var allow_update   :         String        = DomainConst.BLANK
    /**
     * Default init
     */
    override public init() {
        super.init()
    }
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.allow_update                = getString(json: jsonData, key: DomainConst.KEY_ALLOW_UPDATE)
        if let dataArr = jsonData[DomainConst.KEY_STOCK] as? [[String: AnyObject]] {
            for item in dataArr {                
                self.stock.append(InfogasBean(jsonData: item))
            }
        }
    }
}

