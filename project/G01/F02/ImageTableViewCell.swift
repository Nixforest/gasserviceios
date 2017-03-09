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
    /** Index of row */
    var indexRow  = Int()
    /** Delegate */
    var delegate :ImageTableViewCellDelegate?
    /** Image picker */
    @IBOutlet weak var imgPicker: UIImageView!
    /** Delete button */
    @IBOutlet weak var btnDelete: UIButton!
    
    /**
     * Handle tap delete button
     */
    @IBAction func btnDeleteTapped(_ sender: AnyObject) {
        delegate?.removeAtRow(row: indexRow)
    }
    
    /**
     * Awake from nib
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
