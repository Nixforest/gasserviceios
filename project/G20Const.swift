//
//  G20Const.swift
//  project
//
//  Created by SPJ on 10/9/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework
//++ BUG0224-SPJ (KhoiVT 20180930) Gasservice - ForeCast Amount Gas
class G20Const: NSObject {
    /** Function identifier */
    public static let FUNC_IDENTIFIER                           = DomainConst.APPNAME + "g020"
    /** Path to connect with PHP server */
    public static let PATH_FORECAST_VIEW                            = "Forecast/forecastView"
    /** Path to connect with PHP server */
    public static let PATH_SET_TIMER                            = "Order/SetTimer"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_VIEW_TIME                            = "Order/ViewTimer"
    /** Path to connect with PHP server */
    public static let PATH_DELETE_ORDER                            = "Order/DeleteTimer"
}
//-- BUG0224-SPJ (KhoiVT 20180930) Gasservice - ForeCast Amount Gas
