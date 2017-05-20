//
//  CashBookCell.swift
//  project
//
//  Created by SPJ on 5/19/17.
//  Copyright © 2017 admin. All rights reserved.
//


import UIKit
import harpyframework

class CashBookCell: UITableViewCell {
    // MARK: Properties
    private var topView:            UIView = UIView()
    private var leftView:           UIView = UIView()
    
    // Top control
    private var customerLabel:      UILabel = UILabel()
    
    // Left controls
    private var dateTime:           CustomeDateTimeView = CustomeDateTimeView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
