//
//  G14F01S01.swift
//  project
//
//  Created by SPJ on 12/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G14F01S01: G09F01S01 {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     */
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
//        G14F01S01._selectedValue = _datePicker.getValue().replacingOccurrences(
//            of: DomainConst.SPLITER_TYPE1,
//            with: DomainConst.SPLITER_TYPE3)
        return true
    }

}
