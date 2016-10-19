//
//  SearchBarTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class SearchBarTableViewCell: UITableViewCell {

    @IBOutlet weak var result: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        result.translatesAutoresizingMaskIntoConstraints = true
        result.backgroundColor = UIColor.white
        result.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                  y: GlobalConst.MARGIN_CELL_X,
                                  width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2 - GlobalConst.MARGIN_CELL_X * 2,
                                  height: self.frame.height - 1)
        //result.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //periodView.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        //periodView.clipsToBounds = true
        //periodView.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
