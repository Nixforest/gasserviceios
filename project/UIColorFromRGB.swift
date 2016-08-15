//
//  UIColorFromRGB.swift
//  project
//
//  Created by Lâm Phạm on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

//RGB color
func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}