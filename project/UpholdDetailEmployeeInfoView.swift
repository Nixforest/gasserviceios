//
//  UpholdDetailEmployeeView.swift
//  project
//
//  Created by Lâm Phạm on 9/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdDetailEmployeeView: UIView {

   
    
    override func awakeFromNib() {

//        lblStatus.translatesAutoresizingMaskIntoConstraints = true
//        lblStatus.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH / 3, height: GlobalConst.LABEL_HEIGHT)
//        lblStatus.layer.borderWidth = GlobalConst.CELL_BORDER_WIDTH
//        lblStatus.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
//        lblStatus.text = GlobalConst.CONTENT00019

        
    }
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("UpholdDetailEmployeeInfoView", owner: self, options: nil)
    }

}
