//
//  G02Const.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class G02Const: NSObject {
    /** Function identifier */
    public static let FUNC_IDENTIFIER                           = DomainConst.APPNAME + "g02"
    /** Path to connect with PHP server */
    public static let PATH_ISSUE_CREATE                         = "site/issueCreate"
    /** Message Create Success */
    public static let MESSAGE_CREATE_SUCCESS                    = "Tạo phản ánh thành công"
    /** Message Create Success */
    public static let MESSAGE_ERROR_ISSUE_BLANK                 = "Chưa chọn nguyên nhân"
    /** Message Create Success */
    public static let MESSAGE_ERROR_TITLE_BLANK                 = "Chưa nhập tiêu đề"
    /** Message Create Success */
    public static let MESSAGE_ERROR_CONTENT_BLANK               = "Chưa nhập nội dung"
    

}
