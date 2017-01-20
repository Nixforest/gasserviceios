//
//  G04Const.swift
//  project
//
//  Created by SPJ on 12/28/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

class G04Const {
    /** Function identifier */
    public static let FUNC_IDENTIFIER = DomainConst.APPNAME + "g04"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_TRANSACTION_LIST   = "order/transactionList"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_TRANSACTION_VIEW   = "order/transactionView"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_CONFIG             = "order/getConfig"
    /** Notification key: Configuration item */
    public static let NOTIFY_NAME_G04_ORDER_LIST_CONFIG_ITEM    = G04Const.FUNC_IDENTIFIER + ".orderlist.configitem"
    /** Notification key: Configuration item */
    public static let NOTIFY_NAME_G04_ORDER_VIEW_CONFIG_ITEM    = G04Const.FUNC_IDENTIFIER + ".orderview.configitem"
    /** Notification key: Set data process */
    public static let NOTIFY_NAME_G04_ORDER_LIST_SET_DATA       = G04Const.FUNC_IDENTIFIER + ".orderlist.setdata"
    /** Notification key: Set data process */
    public static let NOTIFY_NAME_G04_ORDER_VIEW_SET_DATA       = G04Const.FUNC_IDENTIFIER + ".orderview.setdata"
    /** Notification key: Set data process */
    public static let NOTIFY_NAME_G04_ADDRESS_VIEW_SET_DATA       = G04Const.FUNC_IDENTIFIER + ".orderaddress.setdata"
    /** Name of Order detail view controller */
    public static let G04_F00_S02_VIEW_CTRL                     = "G04F00S02VC"
    /** Name of Order delivery address view controller */
    public static let G04_F01_S01_VIEW_CTRL                     = "G04F01S01VC"
}
