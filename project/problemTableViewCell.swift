//
//  problemTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 9/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

protocol problemTableViewCellDelegate {
    func toRatingVC()
}

class problemTableViewCell: UITableViewCell {
    // MARK: Properties
    var delegate :problemTableViewCellDelegate?
    /** Item view */
    @IBOutlet weak var problemView: UIView!
    /** Name */
    @IBOutlet weak var lblName: UILabel!
    /** Issue content */
    @IBOutlet weak var lblIssue: UILabel!
    /** Status content */
    @IBOutlet weak var lblStatus: UILabel!
    /** Time create content */
    @IBOutlet weak var lblTimeCreate: UILabel!
    /** Rating button */
    @IBOutlet weak var ratingButton: UIButton!
    /** Label issue */
    @IBOutlet weak var lblIssueL: UILabel!
    /** Label status */
    @IBOutlet weak var lblStatusL: UILabel!
    /** Label time create */
    @IBOutlet weak var lblTimeCreateL: UILabel!
    /** Label employee */
    @IBOutlet weak var lblEmployeeL: UILabel!
    /** Employee name */
    @IBOutlet weak var lblEmployee: UILabel!
    /** Finish mark */
    @IBOutlet weak var finishMarkImg: UIImageView!
    
    @IBAction func btnRatingTapped(_ sender: AnyObject) {
        delegate?.toRatingVC()
    }
    
    // MARK: Methods
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
        problemView.translatesAutoresizingMaskIntoConstraints = true
        problemView.backgroundColor = UIColor.white
        problemView.frame = CGRect(x: marginX,
                                   y: marginY,
                                   width: parentWidth - marginX * 2,
                                   height: GlobalConst.CELL_HEIGHT_SHOW - marginY)
        problemView.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        problemView.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        problemView.clipsToBounds = true
        problemView.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        // Name
        lblName.translatesAutoresizingMaskIntoConstraints = true
        lblName.frame = CGRect(x: contentMarginX, y: contentMarginY,
                               width: parentWidth - (marginX + contentMarginX) * 2 - GlobalConst.CELL_HEIGHT_SHOW / 2,
                               height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        problemView.addSubview(lblName)
        
        // Issue label
        lblIssueL.translatesAutoresizingMaskIntoConstraints = true
        lblIssueL.frame = CGRect(x: contentMarginX, y: lblName.frame.maxY,
                                 width: lblIssueL.frame.width,
                                 height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblIssueL.sizeToFit()
        problemView.addSubview(lblIssueL)
        
        // Issue content
        lblIssue.translatesAutoresizingMaskIntoConstraints = true
        lblIssue.frame = CGRect(x: lblIssueL.frame.maxX,
                                y: lblName.frame.maxY,
                                width: parentWidth - contentMarginX * 2 - GlobalConst.CELL_HEIGHT_SHOW / 2 - lblIssueL.frame.width,
                                height: lblIssueL.frame.height)
        problemView.addSubview(lblIssue)
        
        // Status label
        lblStatusL.translatesAutoresizingMaskIntoConstraints = true
        lblStatusL.frame = CGRect(x: contentMarginX,
                                  y: lblIssueL.frame.maxY,
                                  width: lblStatusL.frame.width,
                                  height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblStatusL.sizeToFit()
        problemView.addSubview(lblStatusL)
        
        // Status content
        lblStatus.translatesAutoresizingMaskIntoConstraints = true
        lblStatus.frame = CGRect(x: lblStatusL.frame.maxX,
                                 y:  lblIssueL.frame.maxY,
                                 width: parentWidth - GlobalConst.PARENT_BORDER_WIDTH * 4 - GlobalConst.CELL_HEIGHT_SHOW / 2 - lblStatusL.frame.width,
                                 height: lblStatusL.frame.height)
        problemView.addSubview(lblStatus)
        
        // Finish mark
        finishMarkImg.translatesAutoresizingMaskIntoConstraints = true
        finishMarkImg.frame = CGRect(x: lblStatus.frame.maxX,
                                     y: lblStatusL.frame.minY,
                                     width: GlobalConst.LABEL_IN_CELL_HEIGHT,
                                     height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        finishMarkImg.image = UIImage(named: "done.png")
        
        // Employee label
        lblEmployeeL.translatesAutoresizingMaskIntoConstraints = true
        lblEmployeeL.frame = CGRect(x: contentMarginX, y: lblStatusL.frame.maxY,
                                    width: lblEmployeeL.frame.width,
                                    height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblEmployeeL.sizeToFit()
        problemView.addSubview(lblEmployeeL)
        
        // Employee name
        lblEmployee.translatesAutoresizingMaskIntoConstraints = true
        lblEmployee.frame = CGRect(x: lblEmployeeL.frame.maxX,
                                   y: lblStatusL.frame.maxY,
                                   width: parentWidth - contentMarginX * 2 - lblEmployeeL.frame.width - GlobalConst.CELL_HEIGHT_SHOW / 2,
                                   height: lblEmployeeL.frame.height)
        problemView.addSubview(lblEmployee)
        
        // Time create label
        lblTimeCreateL.translatesAutoresizingMaskIntoConstraints = true
        lblTimeCreateL.frame = CGRect(x: contentMarginX, y: lblEmployeeL.frame.maxY,
                                      width: lblTimeCreateL.frame.width,
                                      height: GlobalConst.LABEL_IN_CELL_HEIGHT)
        lblTimeCreateL.sizeToFit()
        problemView.addSubview(lblTimeCreateL)
        
        // Time create content
        lblTimeCreate.translatesAutoresizingMaskIntoConstraints = true
        lblTimeCreate.frame = CGRect(x: lblTimeCreateL.frame.maxX,
                                     y: lblTimeCreateL.frame.minY,
                                     width: parentWidth - contentMarginX * 2 - GlobalConst.CELL_HEIGHT_SHOW / 2 - lblTimeCreateL.frame.width,
                                     height: lblTimeCreateL.frame.height)
        problemView.addSubview(lblTimeCreate)
        
        
        lblName.text = "Khach hang"
        lblIssue.text = "Su co"
        lblStatus.text = "Trang thai"
        lblTimeCreate.text = "Thoi gian tao"

        let origImage = UIImage(named: "rating.png");
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        ratingButton.translatesAutoresizingMaskIntoConstraints = true
        ratingButton.frame = CGRect(x: lblName.frame.maxX + contentMarginX,
                                    y: 0,
                                    width: GlobalConst.CELL_HEIGHT_SHOW / 2,
                                    height: GlobalConst.CELL_HEIGHT_SHOW)
        ratingButton.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        ratingButton.layer.borderColor = UIColor.red.cgColor
        //ratingButton.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        //ratingButton.setImage(UIImage(named: "rating.png"), for: UIControlState())
        ratingButton.setImage(tintedImage, for: UIControlState.normal)
        //ratingButton.tintColor = GlobalConst.BUTTON_COLOR_RED
        problemView.addSubview(ratingButton)
    }

    /**
     * Set selected
     */
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
        lblIssue.text       = model.type_uphold
        lblStatus.text      = model.status
        lblStatus.sizeToFit()
        finishMarkImg.frame.origin.x = lblStatus.frame.maxX + GlobalConst.MARGIN_CELL_X
        finishMarkImg.frame.origin.y = lblStatus.frame.minY
        lblTimeCreate.text  = model.created_date
        lblEmployee.text    = model.employee_name
        finishMarkImg.isHidden = true
        ratingButton.isHidden = true
        if model.status_number == DomainConst.UPHOLD_STATUS_COMPLETE {
            finishMarkImg.isHidden = false
            ratingButton.isHidden = false
        }
    }
    
}
