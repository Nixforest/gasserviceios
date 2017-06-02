//
//  G01Const.swift
//  project
//
//  Created by SPJ on 1/12/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01Const {
    /** Function identifier */
    public static let FUNC_IDENTIFIER               = DomainConst.APPNAME + "g01"
    /** Image name: Call center phone number */
    public static let CALL_CENTER_NUMBER_IMG_NAME   = "icon63.png"
    /** Image name: Hotline phone number */
    public static let HOTLINE_NUMBER_IMG_NAME       = "icon64.png"
    
    //++ BUG0100-SPJ (NguyenPT 20170602) Add new sub-function Family uphold
    /** Path to connect with PHP server */
    public static let PATH_EMPLOYEE_FAMILY_UPHOLD_LIST      = "employee/upholdHgdList"
    /** Path to connect with PHP server */
    public static let PATH_EMPLOYEE_FAMILY_UPHOLD_VIEW      = "employee/upholdHgdView"
    /** Path to connect with PHP server */
    public static let PATH_EMPLOYEE_FAMILY_UPHOLD_ACTION    = "employee/upholdHgdSetEvent"
    //-- BUG0100-SPJ (NguyenPT 20170602) Add new sub-function Family uphold

}
