//
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
    /** Notification name */
    public static let NOTIFY_G07F01S01_FINISH_SELECT_PROMOTE    = FUNC_IDENTIFIER + G07F01S01VC.theClassName + "finishSelectPromotion"
}