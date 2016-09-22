//
//  problemTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 9/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class problemTableViewCell: UITableViewCell {

    @IBOutlet weak var problemView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblIssue: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTimeCreate: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var ratingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        problemView.translatesAutoresizingMaskIntoConstraints = true
        problemView.backgroundColor = UIColor.white
        problemView.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH * 2 , y: GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2 , height: GlobalConst.CELL_HEIGHT_SHOW - 5 * 2)
        problemView.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        problemView.layer.borderColor = ColorFromRGB().getColorFromRGB(0xF00020).cgColor
        problemView.clipsToBounds = true
        problemView.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        lblName.translatesAutoresizingMaskIntoConstraints = true
        lblName.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH * 3, y: GlobalConst.PARENT_BORDER_WIDTH , width: GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_HEIGHT, height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblIssue.translatesAutoresizingMaskIntoConstraints = true
        lblIssue.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH * 3, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_IN_CELL_HEIGHT , width: GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_HEIGHT, height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblStatus.translatesAutoresizingMaskIntoConstraints = true
        lblStatus.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH * 3,  y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_IN_CELL_HEIGHT * 2), width: GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_HEIGHT, height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblTimeCreate.translatesAutoresizingMaskIntoConstraints = true
        lblTimeCreate.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH * 2, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_IN_CELL_HEIGHT * 3), width: GlobalConst.SCREEN_WIDTH - GlobalConst.LABEL_IN_CELL_HEIGHT, height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        
        lblName.text = "Khach hang"
        lblIssue.text = "Su co"
        lblStatus.text = "Trang thai"
        lblTimeCreate.text = "Thoi gian tao"
        
        doneButton.translatesAutoresizingMaskIntoConstraints = true
        doneButton.frame = CGRect(x: (GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_HEIGHT, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH * 2))/2, height: (GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH * 2))/2)
        doneButton.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        doneButton.layer.borderColor = UIColor.red.cgColor
        doneButton.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        doneButton.setImage(UIImage(named: "done.png"), for: UIControlState())

        ratingButton.translatesAutoresizingMaskIntoConstraints = true
        ratingButton.frame = CGRect(x: (GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_HEIGHT, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH * 2))/2, width: (GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH * 2))/2, height: (GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH * 2))/2)
        ratingButton.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        ratingButton.layer.borderColor = UIColor.red.cgColor
        ratingButton.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        ratingButton.setImage(UIImage(named: "rating.png"), for: UIControlState())
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
