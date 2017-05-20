//
//  TempDataModel.swift
//  project
//
//  Created by SPJ on 5/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class TempDataModel: ConfigBean {
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    override public init(jsonData: [String: AnyObject]) {
        super.init()
        if let idStr = jsonData[DomainConst.KEY_AGENT_ID] as? String {
            self.id = idStr
        } else {
            if let idInt = jsonData[DomainConst.KEY_AGENT_ID] as? Int {
                self.id = String(idInt)
            }
        }
        if let nameStr = jsonData[DomainConst.KEY_AGENT_NAME] as? String  {
            self.name = nameStr
        }
        self.data           = getListConfig(json: jsonData, key: DomainConst.KEY_AGENT_LIST)
    }
    
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }
}
