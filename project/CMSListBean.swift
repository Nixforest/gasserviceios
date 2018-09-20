//
//  CMSListBean.swift
//  project
//
//  Created by SPJ on 9/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CMSListBean: ConfigBean {
    /** Category type */
    public var category_type:             String = DomainConst.BLANK
    /** Created date */
    public var created_date:        String = DomainConst.BLANK
    /** Id of role */
    public var role_id:         String = DomainConst.BLANK
    /** Title */
    public var title:          String = DomainConst.BLANK
    /** Link web */
    public var link_web:             String = DomainConst.BLANK
    /** Link web text */
    public var link_web_text:              String = DomainConst.BLANK
    /** Short content */
    public var short_content:                String = DomainConst.BLANK
    /** Cms content */
    public var cms_content:        String = DomainConst.BLANK
    
    
    /**
     * Initializer
     * - parameter jsonData: List of data
     */
    public override init(jsonData: [String: AnyObject]) {
        super.init(jsonData: jsonData)
        self.id                 = getString(json: jsonData, key: DomainConst.KEY_ID)
        self.category_type            = getString(json: jsonData, key: DomainConst.KEY_CATEGORY_TYPE)
        self.role_id       = getString(json: jsonData, key: DomainConst.KEY_ROLE_ID)
        self.title        = getString(json: jsonData, key: DomainConst.KEY_TITLE)
        self.link_web         = getString(json: jsonData, key: DomainConst.KEY_LINK_WEB)
        self.link_web_text            = getString(json: jsonData, key: DomainConst.KEY_LINK_WEB_TEXT)
        self.created_date             = getString(json: jsonData, key: DomainConst.KEY_CREATED_DATE)
        self.short_content               = getString(json: jsonData, key: DomainConst.KEY_SHORT_CONTENT)
        self.cms_content       = getString(json: jsonData, key: DomainConst.KEY_CMS_CONTENT)
    }
    
    override init() {
        super.init()
    }
}
