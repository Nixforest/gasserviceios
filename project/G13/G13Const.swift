//
//  G13Const.swift
//  project
//
//  Created by SPJ on 9/27/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G13Const: NSObject {
    /** Function identifier */
    public static let FUNC_IDENTIFIER                           = DomainConst.APPNAME + "g013"
    /** Notification key: Finish Scan QR code */
    public static let NOTIFY_NAME_G13_SCAN_QR_FINISH            = G13Const.FUNC_IDENTIFIER + ".scanQRFinish"
}
