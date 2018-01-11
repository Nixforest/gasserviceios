//
//  G14Const.swift
//  project
//
//  Created by SPJ on 12/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G14Const: NSObject {
    /** Function identifier */
    public static let FUNC_IDENTIFIER                           = DomainConst.APPNAME + "g14"
    /** Path to connect with PHP server */
    public static let PATH_VIP_CUSTOMER_GAS_REMAIN_LIST         = "boMoi/gasRemainList"
    /** Path to connect with PHP server */
    public static let PATH_VIP_CUSTOMER_GAS_REMAIN_VIEW         = "boMoi/gasRemainView"
    /** Path to connect with PHP server */
    public static let PATH_VIP_CUSTOMER_GAS_REMAIN_CREATE       = "boMoi/gasRemainCreate"
    /** Path to connect with PHP server */
    public static let PATH_VIP_CUSTOMER_GAS_REMAIN_UPDATE       = "boMoi/gasRemainUpdate"
    /** Path to connect with PHP server */
    public static let PATH_VIP_CUSTOMER_GAS_REMAIN_EXPORT       = "boMoi/gasRemainSetExport"
    /** Weight of table column size */
    public static let TABLE_COLUMN_WEIGHT_GAS_INFO              = (4, 1, 1, 1, 1)
}
