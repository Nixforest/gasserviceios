//
//  ConfigurationTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 9/12/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ConfigurationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var mySw: UISwitch!
    
    @IBOutlet weak var rightImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mySw.setOn(GlobalConst.TRAINING_MODE_FLAG, animated:true)
        self.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configurine the view for the selected state
    }
    
    
    @IBAction func changeValue(_ sender: AnyObject) {
        if mySw.isOn {
            GlobalConst.TRAINING_MODE_FLAG = true
            print(GlobalConst.TRAINING_MODE_FLAG)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TrainingModeOn"), object: nil)
        } else {
            GlobalConst.TRAINING_MODE_FLAG = false
            print(GlobalConst.TRAINING_MODE_FLAG)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TrainingModeOff"), object: nil)
        }
        
    }
    

}
