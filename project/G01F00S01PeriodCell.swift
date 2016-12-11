//
//  G01F00S01PeriodCell.swift
//  project
//
//  Created by Lâm Phạm on 9/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F00S01PeriodCell: UITableViewCell {
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
        let marginX         = GlobalConst.MARGIN_CELL_X
        let marginY         = GlobalConst.MARGIN_CELL_X
        let contentMarginX  = GlobalConst.MARGIN_CELL_X
        let contentMarginY  = GlobalConst.MARGIN_CELL_Y
        let parentWidth     = GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2
        // Item view
        periodView.translatesAutoresizingMaskIntoConstraints = true
        periodView.backgroundColor = UIColor.white
        periodView.frame = CGRect(x: marginX, y: marginY,
                                  width: parentWidth - marginX * 2,
                                  height: GlobalConst.CELL_HEIGHT_SHOW - marginY)
        periodView.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        periodView.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        periodView.clipsToBounds = true
        periodView.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        // Name
        lblName.translatesAutoresizingMaskIntoConstraints = true
        lblName.frame = CGRect(x: contentMarginX, y: contentMarginY,
                               width: parentWidth - (marginX + contentMarginX) * 2,
                               height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        periodView.addSubview(lblName)
        
        // Type periodically label
        lblTypeL.translatesAutoresizingMaskIntoConstraints = true
        lblTypeL.frame = CGRect(x: contentMarginX, y: lblName.frame.maxY,
                               width: lblTypeL.frame.width,
                               height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblTypeL.sizeToFit()
        periodView.addSubview(lblTypeL)
        
        // Type periodically content
        lblType.translatesAutoresizingMaskIntoConstraints = true
        lblType.frame = CGRect(x: lblTypeL.frame.maxX,
                               y: lblTypeL.frame.minY,
                               width: parentWidth - contentMarginX * 2 - lblTypeL.frame.width,
                               height: lblTypeL.frame.height)
        periodView.addSubview(lblType)

        // Status label
        lblStatusL.translatesAutoresizingMaskIntoConstraints = true
        lblStatusL.frame = CGRect(x: contentMarginX, y: lblTypeL.frame.maxY,
                                width: lblStatusL.frame.width,
                                height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblStatusL.sizeToFit()
        periodView.addSubview(lblStatusL)
        
        // Status content
        lblStatus.translatesAutoresizingMaskIntoConstraints = true
        lblStatus.frame = CGRect(x: lblStatusL.frame.maxX,
                                 y:  lblStatusL.frame.minY,
                                 width: parentWidth - GlobalConst.PARENT_BORDER_WIDTH * 4 - lblStatusL.frame.width,
                                 height: lblStatusL.frame.height)
        periodView.addSubview(lblStatus)
        
        // Finish mark
        finishMarkImg.translatesAutoresizingMaskIntoConstraints = true
        finishMarkImg.frame = CGRect(x: lblStatus.frame.maxX,
                                     y: lblStatusL.frame.minY,
                                     width: GlobalConst.LABEL_IN_CELL_HEIGHT,
                                     height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        finishMarkImg.image = UIImage(named: GlobalConst.DONE_IMG_NAME)
        
        // Employee label
        lblEmployeeL.translatesAutoresizingMaskIntoConstraints = true
        lblEmployeeL.frame = CGRect(x: contentMarginX, y: lblStatusL.frame.maxY,
                                 width: lblEmployeeL.frame.width,
                                 height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblEmployeeL.sizeToFit()
        periodView.addSubview(lblEmployeeL)
        
        // Employee name
        lblEmployee.translatesAutoresizingMaskIntoConstraints = true
        lblEmployee.frame = CGRect(x: lblEmployeeL.frame.maxX,
                                   y: lblEmployeeL.frame.minY,
                                   width: parentWidth - contentMarginX * 2 - lblEmployeeL.frame.width,
                                   height: lblEmployeeL.frame.height)
        periodView.addSubview(lblEmployee)

        // Time created label
        lblCreatedDateL.translatesAutoresizingMaskIntoConstraints = true
        lblCreatedDateL.frame = CGRect(x: contentMarginX, y: lblEmployeeL.frame.maxY,
                                width: lblCreatedDateL.frame.width,
                                height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblCreatedDateL.sizeToFit()
        periodView.addSubview(lblCreatedDateL)

        // Time created content
        lblTimeCreate.translatesAutoresizingMaskIntoConstraints = true
        lblTimeCreate.frame = CGRect(x: lblCreatedDateL.frame.maxX,
                                     y: lblCreatedDateL.frame.minY,
                                     width: parentWidth - contentMarginX * 2 - lblCreatedDateL.frame.width,
                                     height: lblCreatedDateL.frame.height)
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
        lblStatus.sizeToFit()
        finishMarkImg.frame.origin.x = lblStatus.frame.maxX + GlobalConst.MARGIN_CELL_X
        finishMarkImg.frame.origin.y = lblStatus.frame.minY
        lblTimeCreate.text  = model.created_date
        lblEmployee.text    = model.employee_name
        finishMarkImg.isHidden = true
        if model.status_number == DomainConst.UPHOLD_STATUS_COMPLETE {
            finishMarkImg.isHidden = false
        }
    }
}
