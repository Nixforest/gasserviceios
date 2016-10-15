//
//  periodTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 9/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class periodTableViewCell: UITableViewCell {

    @IBOutlet weak var periodView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblIssue: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTimeCreate: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        periodView.translatesAutoresizingMaskIntoConstraints = true
        periodView.backgroundColor = UIColor.white
        periodView.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH * 2,y: GlobalConst.PARENT_BORDER_WIDTH,width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4 ,height: GlobalConst.CELL_HEIGHT_SHOW - GlobalConst.PARENT_BORDER_WIDTH)
        periodView.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        periodView.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        periodView.clipsToBounds = true
        periodView.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        lblName.translatesAutoresizingMaskIntoConstraints = true
        lblName.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH ,y: GlobalConst.PARENT_BORDER_WIDTH ,width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4 - GlobalConst.BUTTON_HEIGHT,height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblName)
        lblName.font = UIFont.boldSystemFont(ofSize: 15)
        
        lblIssue.translatesAutoresizingMaskIntoConstraints = true
        lblIssue.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH ,y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_IN_CELL_HEIGHT ,width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4 - GlobalConst.BUTTON_HEIGHT,height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblIssue)
        
        lblStatus.translatesAutoresizingMaskIntoConstraints = true
        lblStatus.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH ,y:  GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_IN_CELL_HEIGHT * 2),width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4 - GlobalConst.BUTTON_HEIGHT,height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblStatus)
        
        lblTimeCreate.translatesAutoresizingMaskIntoConstraints = true
        lblTimeCreate.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH , y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_IN_CELL_HEIGHT * 3),width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4 - GlobalConst.BUTTON_HEIGHT, height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblTimeCreate)
        
        lblName.text = "Khach hang"
        lblIssue.text = "Su co"
        lblStatus.text = "Trang thai"
        lblTimeCreate.text = "Thoi gian tao"
        
        doneButton.translatesAutoresizingMaskIntoConstraints = true
        doneButton.frame = CGRect(x: lblName.frame.size.width, y: GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        doneButton.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        doneButton.layer.borderColor = UIColor.red.cgColor
        doneButton.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        doneButton.setImage(UIImage(named: "done.png"), for: .normal)
        doneButton.backgroundColor = UIColor.clear
        periodView.addSubview(doneButton)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
