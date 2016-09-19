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
        problemView.backgroundColor = UIColor.whiteColor()
        problemView.frame = CGRectMake(GlobalConst.PARENT_BORDER_WIDTH * 2 , GlobalConst.PARENT_BORDER_WIDTH, GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2 , GlobalConst.CELL_HEIGHT_SHOW - 5 * 2)
        problemView.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        problemView.layer.borderColor = ColorFromRGB().getColorFromRGB(0xF00020).CGColor
        problemView.clipsToBounds = true
        problemView.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        lblName.translatesAutoresizingMaskIntoConstraints = true
        lblName.frame = CGRectMake(GlobalConst.PARENT_BORDER_WIDTH * 3, GlobalConst.PARENT_BORDER_WIDTH , GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_HEIGHT, GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblIssue.translatesAutoresizingMaskIntoConstraints = true
        lblIssue.frame = CGRectMake(GlobalConst.PARENT_BORDER_WIDTH * 3, GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_IN_CELL_HEIGHT , GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_HEIGHT, GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblStatus.translatesAutoresizingMaskIntoConstraints = true
        lblStatus.frame = CGRectMake(GlobalConst.PARENT_BORDER_WIDTH * 3,  GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_IN_CELL_HEIGHT * 2), GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_HEIGHT, GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblTimeCreate.translatesAutoresizingMaskIntoConstraints = true
        lblTimeCreate.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH * 2, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_IN_CELL_HEIGHT * 3), width: GlobalConst.SCREEN_WIDTH - GlobalConst.LABEL_IN_CELL_HEIGHT, height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        
        lblName.text = "Khach hang"
        lblIssue.text = "Su co"
        lblStatus.text = "Trang thai"
        lblTimeCreate.text = "Thoi gian tao"
        
        doneButton.translatesAutoresizingMaskIntoConstraints = true
        doneButton.frame = CGRectMake((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_HEIGHT, GlobalConst.PARENT_BORDER_WIDTH, (GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH * 2))/2, (GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH * 2))/2)
        doneButton.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        doneButton.layer.borderColor = UIColor.redColor().CGColor
        doneButton.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        doneButton.setImage(UIImage(named: "done.png"), forState: .Normal)

        ratingButton.translatesAutoresizingMaskIntoConstraints = true
        ratingButton.frame = CGRectMake((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_HEIGHT, GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH * 2))/2, (GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH * 2))/2, (GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH * 2))/2)
        ratingButton.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        ratingButton.layer.borderColor = UIColor.redColor().CGColor
        ratingButton.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        ratingButton.setImage(UIImage(named: "rating.png"), forState: .Normal)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
