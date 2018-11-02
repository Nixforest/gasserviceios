//
//  StockKeeperCell.swift
//  project
//
//  Created by SPJ on 7/25/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class StockKeeperCell: UITableViewCell {

    @IBOutlet weak var lblName:      UILabel!
    @IBOutlet weak var lblAddress:   UILabel!
    @IBOutlet weak var lblInfoGas:   UILabel!
    @IBOutlet weak var lblCodePrice: UILabel!
    @IBOutlet weak var imgStatus:    UIImageView!
    @IBOutlet weak var viewLayout: UIView!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewLayout.layer.borderColor  = UIColor.red.cgColor
        viewLayout.layer.borderWidth  = CGFloat(G18Const.BORDER_WIDTH)
        viewLayout.layer.cornerRadius = CGFloat(G18Const.CORNER_RADIUS_BUTTON)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
