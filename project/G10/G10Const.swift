//
//  G10Const.swift
//  project
//
//  Created by SPJ on 5/30/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G10Const: NSObject {
    /** Function identifier */
    public static let FUNC_IDENTIFIER                           = DomainConst.APPNAME + "g10"
    /** Path to connect with PHP server */
    public static let PATH_REPORT_LIST                          = "user/reportList"
    /** Path to connect with PHP server */
    public static let PATH_APP_REPORT_INVENTORY                 = "appReport/inventory"
    /** Path to connect with PHP server */
    public static let PATH_APP_REPORT_ORDER_FAMILY              = "appReport/hgd"
    /** Path to connect with PHP server */
    public static let PATH_APP_REPORT_CASHBOOK                  = "appReport/cashbook"
    /** Path to connect with PHP server */
    public static let PATH_APP_REPORT_UPDATE_STORECARD          = "appReport/autoMakeStorecard"
}
