//
//  CustomerRequestCell.swift
//  project
//
//  Created by SPJ on 7/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerRequestCell: UITableViewCell {
    
    @IBOutlet weak var viewlayout:  UIView!
    @IBOutlet weak var imgStatus:   UIImageView!
    @IBOutlet weak var lblCode:     UILabel!
    @IBOutlet weak var lblName:     UILabel!
    @IBOutlet weak var lblDate:     UILabel!
    @IBOutlet weak var lblAddress:  UILabel!
    @IBOutlet weak var lblNote:     UILabel!
    //@IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewlayout.layer.borderColor  = UIColor.red.cgColor
        viewlayout.layer.borderWidth  = CGFloat(G18Const.BORDER_WIDTH)
        viewlayout.layer.cornerRadius = CGFloat(G18Const.CORNER_RADIUS_BUTTON)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
