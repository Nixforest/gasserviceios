//
//  G06F02S03.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F02S03: G08F01S01 {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init(w: w, h: h, parent: parent)
        setTitle(title: DomainConst.CONTENT00563)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Get type of target
     */
    public static func getType() -> String {
        return super._type
    }
    
    public static func getTarget() -> CustomerBean {
        return super._target
    }
    
    override func checkDone() -> Bool {
//        if G06F02S03._target.isEmpty() {
//            self.showAlert(message: DomainConst.CONTENT00563)
//            return false
//        }
        return true
    }
}
