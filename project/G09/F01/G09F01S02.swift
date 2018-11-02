//
//  G09F01S02.swift
//  project
//
//  Created by SPJ on 5/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G09F01S02: G08F01S01 {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init(w: w, h: h, parent: parent)
        setTitle(title: DomainConst.CONTENT00391)
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
        if G09F01S02._target.isEmpty() {
            self.showAlert(message: DomainConst.CONTENT00391)
            return false
        }
        return true
    }
}
