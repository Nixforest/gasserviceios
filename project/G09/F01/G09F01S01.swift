//
//  G09F01S01.swift
//  project
//
//  Created by SPJ on 5/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class G09F01S01: G08F01S02 {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    public static func getSelectValue() -> String {
        return G08F01S02._selectedValue
    }
}
