//
//  periodTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 9/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class periodTableViewCell: UITableViewCell {
    /** Item view */
    @IBOutlet weak var periodView: UIView!
    /** Customer name */
    @IBOutlet weak var lblName: UILabel!
    /** Employee name */
    @IBOutlet weak var lblEmployee: UILabel!
    /** Type periodically content */
    @IBOutlet weak var lblType: UILabel!
    /** Created time content */
    @IBOutlet weak var lblTimeCreate: UILabel!
    /** Label employee */
    @IBOutlet weak var lblEmployeeL: UILabel!
    /** Label type periodically */
    @IBOutlet weak var lblTypeL: UILabel!
    /** Label created time */
    @IBOutlet weak var lblCreatedDateL: UILabel!
    /** Label status */
    @IBOutlet weak var lblStatusL: UILabel!
    /** Label status content */
    @IBOutlet weak var lblStatus: UILabel!
    /** Finish mark */
    @IBOutlet weak var finishMarkImg: UIImageView!
    
    /**
     * Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Item view
        periodView.translatesAutoresizingMaskIntoConstraints = true
        periodView.backgroundColor = UIColor.white
        periodView.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH * 2,
                                  y: GlobalConst.PARENT_BORDER_WIDTH / 2,
                                  width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4,
                                  height: GlobalConst.CELL_HEIGHT_SHOW - GlobalConst.PARENT_BORDER_WIDTH)
        periodView.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        periodView.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        periodView.clipsToBounds = true
        periodView.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        // Name
        lblName.translatesAutoresizingMaskIntoConstraints = true
        lblName.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                               y: GlobalConst.MARGIN_CELL,
                               width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4 - GlobalConst.PARENT_BORDER_WIDTH,
                               height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblName)
        
        // Type periodically label
        lblTypeL.translatesAutoresizingMaskIntoConstraints = true
        lblTypeL.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                y: lblName.frame.maxY,
                                width: 98,
                                height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblName)
        
        // Type periodically content
        lblType.translatesAutoresizingMaskIntoConstraints = true
        lblType.frame = CGRect(x: lblTypeL.frame.maxX,
                               y: lblName.frame.maxY,
                               width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4 - lblTypeL.frame.width,
                               height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblType)
        
        // Status label
        lblStatusL.translatesAutoresizingMaskIntoConstraints = true
        lblStatusL.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblTypeL.frame.maxY,
                                  width: 82,
                                  height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblStatusL)
        
        // Status content
        lblStatus.translatesAutoresizingMaskIntoConstraints = true
        lblStatus.frame = CGRect(x: lblStatusL.frame.maxX,
                                 y:  lblTypeL.frame.maxY,
                                 width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4 - lblStatusL.frame.width,
                                 height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblStatus)
        
        // Finish mark
        finishMarkImg.translatesAutoresizingMaskIntoConstraints = true
        finishMarkImg.frame = CGRect(x: lblStatusL.frame.maxX + 90,
                                     y: lblTypeL.frame.maxY,
                                     width: GlobalConst.LABEL_IN_CELL_HEIGHT,
                                     height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        finishMarkImg.image = UIImage(named: "done.png")
        
        // Employee label
        lblEmployeeL.translatesAutoresizingMaskIntoConstraints = true
        lblEmployeeL.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                 y: lblStatusL.frame.maxY,
                                 width: 80,
                                 height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblEmployeeL)
        
        // Employee name
        lblEmployee.translatesAutoresizingMaskIntoConstraints = true
        lblEmployee.frame = CGRect(x: lblEmployeeL.frame.maxX,
                                   y: lblStatusL.frame.maxY,
                                   width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4 - lblEmployeeL.frame.width,
                                   height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblEmployee)
        
        // Time created label
        lblCreatedDateL.translatesAutoresizingMaskIntoConstraints = true
        lblCreatedDateL.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                y: lblEmployeeL.frame.maxY,
                                width: 100,
                                height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblCreatedDateL)
        
        // Time created content
        lblTimeCreate.translatesAutoresizingMaskIntoConstraints = true
        lblTimeCreate.frame = CGRect(x: lblCreatedDateL.frame.maxX,
                                     y: lblEmployeeL.frame.maxY,
                                     width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4 - lblCreatedDateL.frame.width,
                                     height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblTimeCreate)
        
        lblName.text = "Khach hang"
        lblType.text = "1 thang 1 lan"
        lblStatus.text = "Hoàn thành"
        lblEmployee.text = "Nguyen Duy Truong"
        lblTimeCreate.text = "Thoi gian tao"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     * Set data for item.
     * - parameter model: UpholdBean model
     */
    func setData(model: UpholdBean) {
        lblName.text        = model.customer_name
        lblType.text        = model.schedule_type
        lblStatus.text      = model.status
        lblTimeCreate.text  = model.created_date
        lblEmployee.text    = model.employee_name
        finishMarkImg.isHidden = true
        if model.status_number == DomainConst.UPHOLD_STATUS_COMPLETE {
            finishMarkImg.isHidden = false
        }
    }
}
