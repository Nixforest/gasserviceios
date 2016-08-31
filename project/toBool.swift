//
//  toBool.swift
//  project
//
//  Created by Lâm Phạm on 8/30/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
