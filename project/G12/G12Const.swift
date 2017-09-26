//
//  G12Const.swift
//  project
//
//  Created by SPJ on 9/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G12Const {
    /** Function identifier */
    public static let FUNC_IDENTIFIER                           = DomainConst.APPNAME + "g012"
    /** Path to connect with PHP server */
    public static let PATH_ORDER_TRANSACTION_LIST               = "order/transactionStatus"
    /** Notification key: Finish login */
    public static let NOTIFY_NAME_G12_REQUEST_TRANSACTION_START = G12Const.FUNC_IDENTIFIER + ".requestTransactionStart"

}
