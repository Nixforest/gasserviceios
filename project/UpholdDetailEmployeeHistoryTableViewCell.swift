//
//  UpholdDetailEmployeeHistoryTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdDetailEmployeeHistoryTableViewCell: UITableViewCell {
    // MARK: Properties
    /** Label handle day */
    @IBOutlet weak var lblHandleDay: UILabel!
    /** Label creator */
    @IBOutlet weak var lblCreator: UILabel!
    /** Label status */
    @IBOutlet weak var lblStatus: UILabel!
    /** Label created day */
    @IBOutlet weak var lblCreatedDay: UILabel!
    /** Label Note */
    @IBOutlet weak var lblNote: UILabel!
    /** Label Phone */
    @IBOutlet weak var lblPhone: UILabel!
    /** Label Internal note */
    @IBOutlet weak var lblInternal: UILabel!
    /** Image view */
    @IBOutlet weak var img1: UIImageView!
    /** Image view */
    @IBOutlet weak var img2: UIImageView!
    /** Image view */
    @IBOutlet weak var img3: UIImageView!
    /** Handle day value */
    @IBOutlet weak var tbxHandleDay: UITextView!
    /** Creator value */
    @IBOutlet weak var tbxCreator: UITextView!
    /** Parent view */
    @IBOutlet weak var parentView: UIView!
    /** Status value */
    @IBOutlet weak var tbxStatus: UITextView!
    /** Created day value */
    @IBOutlet weak var tbxCreatedDay: UITextView!
    /** Note value */
    @IBOutlet weak var tbxNote: UITextView!
    /** Phone value */
    @IBOutlet weak var tbxPhone: UITextView!
    /** Internal value */
    @IBOutlet weak var tbxInternal: UITextView!
    /** Report wrong value */
    @IBOutlet weak var lblReportWrong: UILabel!
    /** Height of view */
    static var VIEW_HEIGHT = GlobalConst.LABEL_HEIGHT * 14
    /** Current data */
    var data: UpholdReplyBean = UpholdReplyBean()
    
    /** Margin X value */
    let marginX     = GlobalConst.MARGIN_CELL_X
    /** Margin Y value */
    let marginY     = GlobalConst.MARGIN_CELL_Y
    /** Width of left column */
    let leftWidth   = (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2) / 3
    /** Width of right column */
    let rightWidth  = (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2) * 2 / 3
    /** Width of parent view */
    let parentWidth = GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2
    
    // MARK: Methods
    /**
     * Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }    
    
    /**
     * Set layout for left controls
     * - parameter lbl:     Label control
     * - parameter offset:  Y offset
     * - parameter height:  Height of layout
     * - parameter text:    Control's text
     */
    func setLayoutLeft(lbl: UILabel, offset: CGFloat, height: CGFloat, text: String) {
        lbl.translatesAutoresizingMaskIntoConstraints = true
        lbl.frame = CGRect(x: marginX, y: offset, width: leftWidth, height: height)
        lbl.text = text
        lbl.layer.addBorder(edge: UIRectEdge.top)
        lbl.layer.addBorder(edge: UIRectEdge.right)
    }
    
    /**
     * Set layout for right controls
     * - parameter lbl:     TextView control
     * - parameter offset:  Y offset
     * - parameter height:  Height of layout
     * - parameter text:    Control's text
     */
    func setLayoutRight(lbl: UITextView, offset: CGFloat, height: CGFloat, text: String) {
        lbl.translatesAutoresizingMaskIntoConstraints = true
        lbl.text = text
        alignTextVerticalInTextView(textView: lbl)
        lbl.frame = CGRect(x: marginX + leftWidth, y: offset, width: rightWidth, height: height)
        lbl.layer.addBorder(edge: UIRectEdge.top)
        lbl.isEditable = false
    }
    
    /**
     * Alignment text vertical.
     * - parameter textView: Text view to align
     */
    func alignTextVerticalInTextView(textView :UITextView) {
        
        let size = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: CGFloat(MAXFLOAT)))
        
        var topoffset = (textView.bounds.size.height - size.height * textView.zoomScale) / 2.0
        topoffset = topoffset < 0.0 ? 0.0 : topoffset
        
        textView.contentOffset = CGPoint(x: 0, y: -topoffset)
    }
    
    /**
     * Set data for cell.
     * - parameter model: Data model
     */
    func setData(model: UpholdReplyBean) {
        data = model
        var offset: CGFloat = marginY
        lblReportWrong.isHidden = true
        if !model.report_wrong.isEmpty {
            // Label Report wrong
            lblReportWrong.isHidden = false
            lblReportWrong.translatesAutoresizingMaskIntoConstraints = true
            lblReportWrong.frame = CGRect(
                x: marginX,
                y: offset,
                width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2,
                height: GlobalConst.LABEL_HEIGHT
            )
            offset += GlobalConst.LABEL_HEIGHT
        }
        
        // Label Handle date
        setLayoutLeft(lbl: lblHandleDay, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00150)
        // Handle date value
        setLayoutRight(lbl: tbxHandleDay, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00150)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Creator
        setLayoutLeft(lbl: lblCreator, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00095)
        // Creator value
        setLayoutRight(lbl: tbxCreator, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00095)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Status
        setLayoutLeft(lbl: lblStatus, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
        // Status value
        setLayoutRight(lbl: tbxStatus, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Created day
        setLayoutLeft(lbl: lblCreatedDay, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00096)
        // Created day value
        setLayoutRight(lbl: tbxCreatedDay, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00096)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Note
        setLayoutLeft(lbl: lblNote, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00081)
        // Note value
        setLayoutRight(lbl: tbxNote, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00081)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Phone
        setLayoutLeft(lbl: lblPhone, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00152)
        // Phone value
        setLayoutRight(lbl: tbxPhone, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00152)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Intenal
        setLayoutLeft(lbl: lblInternal, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00151)
        // Intenal value
        setLayoutRight(lbl: tbxInternal, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00151)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Image
        if model.images.count >= 1 {
            img1.isHidden = false
            img1.translatesAutoresizingMaskIntoConstraints = true
            img1.frame = CGRect(x: marginX, y: offset,
                                width: img1.frame.width,
                                height: img1.frame.height)
            img1.getImgFromUrl(link: model.images[0].thumb, contentMode: img1.contentMode)
        }
        if model.images.count >= 2 {
            img2.isHidden = false
            img2.translatesAutoresizingMaskIntoConstraints = true
            img2.frame = CGRect(x: img1.frame.maxX,
                                y: offset,
                                width: img2.frame.width,
                                height: img2.frame.height)
            img2.getImgFromUrl(link: model.images[1].thumb, contentMode: img2.contentMode)
        }
        if model.images.count >= 3 {
            img3.isHidden = false
            img3.translatesAutoresizingMaskIntoConstraints = true
            img3.frame = CGRect(x: img2.frame.maxX,
                                y: offset,
                                width: img3.frame.width,
                                height: img3.frame.height)
            img3.getImgFromUrl(link: model.images[2].thumb, contentMode: img3.contentMode)
        }
        if model.images.count != 0 {
            offset += img1.frame.height + marginY
        } else {
            offset += marginY
        }
        UpholdDetailEmployeeHistoryTableViewCell.VIEW_HEIGHT = offset + marginY
        // Parent view
        parentView.translatesAutoresizingMaskIntoConstraints = true
        parentView.frame = CGRect(x: marginX, y: marginY,
                                  width: parentWidth - marginX * 2,
                                  height: offset)
        CommonProcess.setBorder(view: parentView)
        
        tbxHandleDay.text   = model.date_time_handle
        tbxCreator.text     = model.uid_login
        tbxStatus.text      = model.status
        tbxCreatedDay.text  = model.created_date
        tbxNote.text        = model.note
        tbxPhone.text       = model.contact_phone
        tbxInternal.text    = model.note_internal
        lblReportWrong.text = model.report_wrong
    }
}
