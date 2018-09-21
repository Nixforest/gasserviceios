//
//  IssueReplyBean.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class IssueReplyBean: ConfigBean {
    /** Created by */
    var created_by:                         String = DomainConst.BLANK
    /** Created date */
    var created_date:                       String = DomainConst.BLANK
    /** List images */
    public var images:      [UpholdImageInfoItem]  = [UpholdImageInfoItem]()
    
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init()
        if let idStr = jsonData[DomainConst.KEY_ID] as? String {
            self.id = idStr
        } else {
            if let idInt = jsonData[DomainConst.KEY_ID] as? Int {
                self.id = String(idInt)
            }
        }
        if let nameStr = jsonData[DomainConst.KEY_MESSAGE] as? String  {
            self.name = nameStr
        }
        self.created_by         = getString(json: jsonData, key: DomainConst.KEY_CREATED_BY)
        self.created_date       = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE)
        if let dataArr = jsonData[DomainConst.KEY_IMAGES] as? [[String: AnyObject]] {
            for listItem in dataArr {
                self.images.append(UpholdImageInfoItem(jsonData: listItem))
            }
        }
    }
}
