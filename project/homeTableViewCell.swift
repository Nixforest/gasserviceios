//
//  HomeTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var homeCellImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
