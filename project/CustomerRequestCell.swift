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
    
    @IBOutlet weak var viewlayout: UIView!

    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    //@IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewlayout.layer.borderColor = UIColor.red.cgColor
        viewlayout.layer.borderWidth = 1
        viewlayout.layer.cornerRadius = 5
        
        lblCode.text = "SP18VH1UFF"
        lblName.text = "Vịt chiên"
        lblDate.text = "🗓2018-07-05 17:20:09"
        lblAddress.text = "🏚622, Bình Trường, Bình Khánh, Cần Giờ, TP.HCM"
        lblNote.text = "📔Đây chỉ là test"
        imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_NEW_ICON_IMG_NAME)
            
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
