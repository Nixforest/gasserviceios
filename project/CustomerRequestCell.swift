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
    /** cell View*/
    @IBOutlet weak var viewlayout:  UIView!
    /** status Image */
    @IBOutlet weak var imgStatus:   UIImageView!
    /** code Label */
    @IBOutlet weak var lblCode:     UILabel!
    /** name Label */
    @IBOutlet weak var lblName:     UILabel!
    /** date Label */
    @IBOutlet weak var lblDate:     UILabel!
    /** address Label */
    @IBOutlet weak var lblAddress:  UILabel!
    /** note Label */
    @IBOutlet weak var lblNote:     UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // custom Cell
        viewlayout.layer.borderColor  = UIColor.red.cgColor
        viewlayout.layer.borderWidth  = CGFloat(G18Const.BORDER_WIDTH)
        viewlayout.layer.cornerRadius = CGFloat(G18Const.CORNER_RADIUS_BUTTON)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
