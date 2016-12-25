//
//  step5TableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 10/8/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

protocol ImageTableViewCellDelegate {
    func removeAtRow(row :Int)
}

class ImageTableViewCell: UITableViewCell {

    var indexRow  = Int()
    
    var delegate :ImageTableViewCellDelegate?
    
    
    @IBOutlet weak var imgPicker: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBAction func btnDeleteTapped(_ sender: AnyObject) {
        delegate?.removeAtRow(row: indexRow)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
