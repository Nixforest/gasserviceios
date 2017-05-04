//
//  G08Const.swift
//  project
//
//  Created by SPJ on 5/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G08Const: NSObject {
    /** Function identifier */
    public static let FUNC_IDENTIFIER                           = DomainConst.APPNAME + "g08"
    /** Path to connect with PHP server */
    public static let PATH_VIP_CUSTOMER_STORE_CARD_LIST         = "boMoi/storecardList"
    /** Path to connect with PHP server */
    public static let PATH_VIP_CUSTOMER_STORE_CARD_VIEW         = "boMoi/storecardView"
    /** G08S00S01 UITableViewCell identify */
    public static let G08S00S01_TABLE_VIEW_CELL_ID              = "G08S00S01Cell"
    /** Weight of table column size */
    public static let TABLE_COLUMN_WEIGHT_GAS_INFO              = (2, 5, 3)
}
