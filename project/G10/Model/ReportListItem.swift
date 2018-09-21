//
//  ReportItem.swift
//  project
//
//  Created by SPJ on 5/30/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportListItem: ConfigBean {
    /** Url */
    public var url:            String = DomainConst.BLANK
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.url            = getString(json: jsonData, key: DomainConst.KEY_DATA)
    }
}
