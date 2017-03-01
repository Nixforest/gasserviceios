//
//  G05Const.swift
//  project
//
//  Created by SPJ on 2/15/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import harpyframework

class G05Const {
    /** Function identifier */
    public static let FUNC_IDENTIFIER                           = DomainConst.APPNAME + "g05"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_CONFIG                         = "order/getConfig"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_VIP_CREATE                     = "boMoi/boMoiCreate"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_VIP_LIST                       = "boMoi/boMoiList"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_VIP_VIEW                       = "boMoi/boMoiView"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_VIP_DRIVER_UPDATE              = "boMoi/boMoiDriverUpdate"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_VIP_SET_EVENT                  = "boMoi/boMoiSetEvent"
    /** Name of Order delivery address view controller */
    public static let G05_F01_S01_VIEW_CTRL                     = "G05F01S01VC"
    /** Name of Order delivery address view controller */
    public static let G05_F01_S02_VIEW_CTRL                     = "G05F01S02VC"
    /** Name of Order detail view controller */
    public static let G05_F00_S02_VIEW_CTRL                     = "G05F00S02VC"
    /** Notification key: Configuration item */
    public static let NOTIFY_NAME_G05_ORDER_LIST_CONFIG_ITEM    = G05Const.FUNC_IDENTIFIER + ".orderlist.configitem"
    
}
