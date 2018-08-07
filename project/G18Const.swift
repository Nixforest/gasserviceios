//
//  G18Const.swift
//  project
//
//  Created by SPJ on 7/25/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class G18Const: NSObject {
    /** Function identifier */
    public static let FUNC_IDENTIFIER             = DomainConst.APPNAME + "g18"
    /** Path to connect with PHP server */
    public static let PATH_VIP_STOCK_LIST         = "boMoi/stockList"
    /** Path to connect with PHP server */
    public static let PATH_VIP_STOCK_UPDATE       = "boMoi/stockUpdate"
    /** Path to connect with PHP server */
    public static let PATH_VIP_STOCK_VIEW         = "boMoi/stockView"
    /** Path to connect with PHP server */
    public static let PATH_VIP_STOCK_REAL_VIEW    = "boMoi/stockRealView"
    /** Path to connect with PHP server */
    public static let PATH_VIP_STOCK_REAL_UPDATE  = "boMoi/stockRealUpdate"
    /** Corner Radius value */
    public static let CORNER_RADIUS_BUTTON        = 2
    /** Corner Radius Button value */
    public static let CORNER_RADIUS_BUTTON_2      = 15
    /** Estimate row height */
    public static let ESTIMATE_ROW_HEIGHT         = 200
    /** Border width */
    public static let BORDER_WIDTH                = 1
    /** String Default value of Pickerview Driver */
    public static let DEFAULT_VALUE_DRIVER        = "Chọn tài xế"
    /** String Default value of Pickerview Car */
    public static let DEFAULT_VALUE_CAR           = "Chọn xe"
}
