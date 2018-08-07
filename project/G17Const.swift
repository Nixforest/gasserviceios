//
//  G17Const.swift
//  project
//
//  Created by SPJ on 7/16/18.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G17Const: NSObject {
    /** Function identifier */
    public static let FUNC_IDENTIFIER                           = DomainConst.APPNAME + "g17"
    /** Path to connect with PHP server */
    public static let PATH_VIP_CUSTOMER_REQUEST_LIST            = "CustomerRequest/CustomerRequestList"
    /** Path to connect with PHP server */
    public static let PATH_VIP_CUSTOMER_REQUEST_CREATE          = "CustomerRequest/CustomerRequestCreate"
    /** Path to connect with PHP server */
    public static let PATH_VIP_CUSTOMER_REQUEST_VIEW            = "CustomerRequest/CustomerRequestView"
    /** Path to connect with PHP server */
    public static let PATH_VIP_CUSTOMER_REQUEST_UPDATE          = "CustomerRequest/CustomerRequestUpdate"
    /** Path to connect with PHP server */
    public static let PATH_VIP_APPDATA_CLIENT_CACHE          = "AppData/ClientCache"
    /** Estimate row height */
    public static let ESTIMATE_ROW_HEIGHT                       = 400
    /** Estimate row height */
    public static let ERROR_SAME_MATERIAL                       = "Vật tư này đã được thêm vào"
}
