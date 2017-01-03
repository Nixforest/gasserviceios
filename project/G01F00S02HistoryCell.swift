//
//  UpholdDetailEmployeeHistoryTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F00S02HistoryCell: UITableViewCell {
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
    /** Images collection */
    var cltImg: UICollectionView! = nil
    
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
     * Set collection view data source and data delegate
     * - parameter dataSourceDelegate: data source delegate
     * - parameter foRow row: Index of row
     */
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(dataSourceDelegate: D, forRow row: Int) {
        self.cltImg.delegate    = dataSourceDelegate
        self.cltImg.dataSource  = dataSourceDelegate
        self.cltImg.tag         = row
        self.cltImg.isHidden    = false
        self.cltImg.reloadData()
    }
    
    /**
     * Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: GlobalConst.ACCOUNT_AVATAR_W / 2,
                                 height: GlobalConst.ACCOUNT_AVATAR_W / 2)
        self.cltImg = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        self.cltImg.register(UINib(nibName: DomainConst.COLLECTION_IMAGE_VIEW_CELL, bundle: nil),
                             forCellWithReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL)
        self.cltImg.alwaysBounceHorizontal = true
        self.cltImg.bounces = true
        if let layout = self.cltImg.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        self.addSubview(self.cltImg)
    }
    
    /**
     * Hide image collection.
     */
    func hideImageCollection() {
        self.cltImg.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     * Set data for cell.
     * - parameter model: Data model
     */
    func setData(model: UpholdReplyBean, row: Int, view: BaseViewController) {
        self.data = model
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
        CommonProcess.setLayoutLeft(lbl: lblHandleDay, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00150)
        // Handle date value
        CommonProcess.setLayoutRight(lbl: tbxHandleDay, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00150)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Creator
        CommonProcess.setLayoutLeft(lbl: lblCreator, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00095)
        // Creator value
        CommonProcess.setLayoutRight(lbl: tbxCreator, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00095)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Status
        CommonProcess.setLayoutLeft(lbl: lblStatus, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00092)
        // Status value
        CommonProcess.setLayoutRight(lbl: tbxStatus, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00092)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Created day
        CommonProcess.setLayoutLeft(lbl: lblCreatedDay, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00096)
        // Created day value
        CommonProcess.setLayoutRight(lbl: tbxCreatedDay, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00096)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Note
        CommonProcess.setLayoutLeft(lbl: lblNote, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00195)
        // Note value
        CommonProcess.setLayoutRight(lbl: tbxNote, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00195)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Phone
        CommonProcess.setLayoutLeft(lbl: lblPhone, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00152)
        // Phone value
        CommonProcess.setLayoutRight(lbl: tbxPhone, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00152)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Intenal
        CommonProcess.setLayoutLeft(lbl: lblInternal, offset: offset, height: GlobalConst.LABEL_HEIGHT * 2, text: DomainConst.CONTENT00151)
        // Intenal value
        CommonProcess.setLayoutRight(lbl: tbxInternal, offset: offset, height: GlobalConst.LABEL_HEIGHT * 2, text: DomainConst.CONTENT00151)
        offset += GlobalConst.LABEL_HEIGHT * 2
        
        // Image
        if cltImg != nil {
            cltImg.translatesAutoresizingMaskIntoConstraints = true
            cltImg.frame = CGRect(x: marginX * 2,
                                  y: offset,
                                  width: self.frame.width - 4 * marginX,
                                  height: GlobalConst.ACCOUNT_AVATAR_H / 2)
            cltImg.backgroundColor = UIColor.white
            cltImg.contentSize = CGSize(
                width: GlobalConst.ACCOUNT_AVATAR_H / 2 * (CGFloat)(model.images.count),
                height: GlobalConst.ACCOUNT_AVATAR_H / 2)
            cltImg.reloadData()
        }
        
        if model.images.count != 0 {
            offset += GlobalConst.ACCOUNT_AVATAR_H / 2
        }
        offset += marginY
        
        G01F00S02HistoryCell.VIEW_HEIGHT = offset + marginY
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
    
    /**
     * Get table cell height
     * - parameter model: Data model
     * - returns: Height of cell
     */
    static func getTableCellHeight(model: UpholdReplyBean) -> CGFloat {
        var offset: CGFloat = GlobalConst.MARGIN_CELL_Y
        if !model.report_wrong.isEmpty {
            // Label Report wrong
            offset += GlobalConst.LABEL_HEIGHT
        }
        // Label Handle date
        offset += GlobalConst.LABEL_HEIGHT
        // Label Creator
        offset += GlobalConst.LABEL_HEIGHT
        // Label Status
        offset += GlobalConst.LABEL_HEIGHT
        // Label Created day
        offset += GlobalConst.LABEL_HEIGHT
        // Label Note
        offset += GlobalConst.LABEL_HEIGHT
        // Label Phone
        offset += GlobalConst.LABEL_HEIGHT
        // Label Intenal
        offset += GlobalConst.LABEL_HEIGHT * 2
        
        if model.images.count != 0 {
            offset += GlobalConst.ACCOUNT_AVATAR_H / 2 + GlobalConst.MARGIN_CELL_Y
        } else {
            offset += GlobalConst.MARGIN_CELL_Y
        }
        return offset + GlobalConst.MARGIN_CELL_Y
    }
}
