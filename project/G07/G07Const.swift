// Order Customer Family (For Employee)
//  G07Const.swift
//  project
//
//  Created by SPJ on 4/7/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G07Const: NSObject {
    /** Function identifier */
    public static let FUNC_IDENTIFIER                           = DomainConst.APPNAME + "g07"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_TRANSACTION_CREATE             = "order/transactionCreate"
    /** Path to connect with PHP server */
    public static let PATH_EVENT_CLICK_CALL                     = "support/eventClickCall"
    /** Path to connect with PHP server */
    public static let TYPE_HGD                                  = "1"
    /** Path to connect with PHP server */
    public static let TYPE_BOMOI                                = "2"
}
