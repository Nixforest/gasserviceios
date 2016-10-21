//
//  UpholdDetailEmployeeHistoryTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdDetailEmployeeHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var lblHandleDay: UILabel!
    @IBOutlet weak var lblCreator: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblCreatedDay: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblInternal: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var tbxHandleDay: UITextView!
    @IBOutlet weak var tbxCreator: UITextView!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var tbxStatus: UITextView!
    @IBOutlet weak var tbxCreatedDay: UITextView!
    @IBOutlet weak var tbxNote: UITextView!
    @IBOutlet weak var tbxPhone: UITextView!
    @IBOutlet weak var tbxInternal: UITextView!
    
    let marginX = GlobalConst.MARGIN_CELL_X
    let marginY = GlobalConst.MARGIN_CELL_Y
    let leftWidth = (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2) / 3
    let rightWidth = (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2) * 2 / 3
    let parentWidth     = GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        parentView.translatesAutoresizingMaskIntoConstraints = true
        parentView.frame = CGRect(x: marginX, y: marginY,
                                  width: parentWidth - marginX * 2,
                                  height: self.frame.height - marginY * 2)
        parentView.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        parentView.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        parentView.clipsToBounds = true
        parentView.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        // Label Handle date
        setLayoutLeft(lbl: lblHandleDay, offset: marginY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00150)
        // Handle date value
        setLayoutRight(lbl: tbxHandleDay, offset: marginY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00150)
        
        // Label Creator
        setLayoutLeft(lbl: lblCreator, offset: lblHandleDay.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00095)
        // Creator value
        setLayoutRight(lbl: tbxCreator, offset: lblHandleDay.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00095)
        
        // Label Status
        setLayoutLeft(lbl: lblStatus, offset: lblCreator.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
        // Status value
        setLayoutRight(lbl: tbxStatus, offset: lblCreator.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
        
        // Label Created day
        setLayoutLeft(lbl: lblCreatedDay, offset: lblStatus.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00096)
        // Created day value
        setLayoutRight(lbl: tbxCreatedDay, offset: lblStatus.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00096)
        
        // Label Note
        setLayoutLeft(lbl: lblNote, offset: lblCreatedDay.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00081)
        // Note value
        setLayoutRight(lbl: tbxNote, offset: lblCreatedDay.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00081)
        
        // Label Phone
        setLayoutLeft(lbl: lblPhone, offset: lblNote.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00152)
        // Phone value
        setLayoutRight(lbl: tbxPhone, offset: lblNote.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00152)
        
        // Label Intenal
        setLayoutLeft(lbl: lblInternal, offset: lblPhone.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00151)
        // Intenal value
        setLayoutRight(lbl: tbxInternal, offset: lblPhone.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00151)
        
        // Image
        img1.translatesAutoresizingMaskIntoConstraints = true
        img1.frame = CGRect(x: marginX, y: lblInternal.frame.maxY,
                            width: img1.frame.width,
                            height: img1.frame.height)
        img2.translatesAutoresizingMaskIntoConstraints = true
        img2.frame = CGRect(x: img1.frame.maxX,
                            y: lblInternal.frame.maxY,
                            width: img2.frame.width,
                            height: img2.frame.height)
        img3.translatesAutoresizingMaskIntoConstraints = true
        img3.frame = CGRect(x: img2.frame.maxX,
                            y: lblInternal.frame.maxY,
                            width: img3.frame.width,
                            height: img3.frame.height)
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
    }
    
    func alignTextVerticalInTextView(textView :UITextView) {
        
        let size = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: CGFloat(MAXFLOAT)))
        
        var topoffset = (textView.bounds.size.height - size.height * textView.zoomScale) / 2.0
        topoffset = topoffset < 0.0 ? 0.0 : topoffset
        
        textView.contentOffset = CGPoint(x: 0, y: -topoffset)
    }
}
//extension CALayer {
//    
//    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
//        
//        let border = CALayer()
//        
//        switch edge {
//        case UIRectEdge.top:
//            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
//            break
//        case UIRectEdge.bottom:
//            border.frame = CGRect(
//                x: 0,
//                y: self.frame.height - thickness,
//                width: UIScreen.main.bounds.width,
//                height: thickness)
//            break
//        case UIRectEdge.left:
//            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
//            break
//        case UIRectEdge.right:
//            border.frame = CGRect(
//                x: self.frame.width - thickness,
//                y: 0,
//                width: thickness,
//                height: self.frame.height)
//            break
//        default:
//            break
//        }
//        
//        border.backgroundColor = color.cgColor;
//        
//        self.addSublayer(border)
//    }
//    func addBorder(edge: UIRectEdge) {
//        addBorder(edge: edge, color: GlobalConst.BACKGROUND_COLOR_GRAY, thickness: 1)
//    }
//}
