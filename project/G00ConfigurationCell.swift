//
//  ConfigurationTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 9/12/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G00ConfigurationCell: UITableViewCell {
    /** Image in the left */
    @IBOutlet weak var leftImg: UIImageView!
    /** Label name of item */
    @IBOutlet weak var nameLbl: UILabel!
    /** Switch control */
    @IBOutlet weak var mySw: UISwitch!
    /** Image in the right */
    @IBOutlet weak var rightImg: UIImageView!
    
    /**
     * Awake from nib
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mySw.setOn(Singleton.shared.checkTrainningMode(), animated:true)
        self.backgroundColor = UIColor.white
    }

    /**
     * Handle select item
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     * Handle when change value of switch
     * - parameter sender: Control sent event
     */
    @IBAction func changeValue(_ sender: AnyObject) {
        if mySw.isOn {
            Singleton.shared.setTrainningMode(true)
        } else {
            Singleton.shared.setTrainningMode(false)
        }
    }
}
