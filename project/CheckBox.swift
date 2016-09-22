//
//  CheckBox.swift
//  project
//
//  Created by Lâm Phạm on 7/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    //Image
    let imgUnchecked = UIImage(named: "checkbox-unchecked.png")
    let imgChecked = UIImage(named: "checkbox-checked.png")
    //Bool value to show Image
    var bChecked:Bool = false {
        didSet {
            if (bChecked == true) {
                self.setImage(imgChecked, for: UIControlState())
            }else {
                self.setImage(imgUnchecked, for: UIControlState())
            }
        }
    }
    //Initial Value bChecked == false
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(CheckBox.buttonClicked(_:)), for: UIControlEvents.touchUpInside)
        self.bChecked = false
        
    }
    
    //click event
    func buttonClicked(_ sender: UIButton) {
        if (sender == self) {
            if (bChecked == false) {
                bChecked = true
            }else {
                bChecked = false
            }
        }
    }
        
}
