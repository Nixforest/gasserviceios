//
//  IssueBean.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class IssueBean: IssueListBean {
    /** Reply items */
    public var reply_item: [IssueReplyBean] = [IssueReplyBean]()
    
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
    override init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        var retVal = [IssueReplyBean]()
        let list = jsonData[DomainConst.KEY_REPLY_ITEM] as? [[String: AnyObject]]
        if list != nil {
            for item in list! {
                retVal.append(IssueReplyBean(jsonData: item))
            }
        }
        self.reply_item.append(contentsOf: retVal)
    }
}
