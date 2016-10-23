//
//  UpholdDetailEmployeeView.swift
//  project
//
//  Created by Lâm Phạm on 9/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdDetailEmployeeInfoView: UIView, UITextFieldDelegate {
    /** Label Status */
    @IBOutlet weak var lblStatus: UILabel!
    /** Label Customer name */
    @IBOutlet weak var lblCustomerName: UILabel!
    /** Label Sale */
    @IBOutlet weak var lblSale: UILabel!
    /** Label Employee */
    @IBOutlet weak var lblEmployee: UILabel!
    /** Label Address */
    @IBOutlet weak var lblAddress: UILabel!
    /** Label Contact */
    @IBOutlet weak var lblContact: UILabel!
    /** Label Problem */
    @IBOutlet weak var lblProblem: UILabel!
    /** Label Content */
    @IBOutlet weak var lblContent: UILabel!
    /** Label Creator */
    @IBOutlet weak var lblCreator: UILabel!
    /** Label CreateTime */
    @IBOutlet weak var lblCreateTime: UILabel!
    /** Label Code */
    @IBOutlet weak var lblCode: UILabel!
    /** Status value */
    @IBOutlet weak var tbxStatusValue: UITextView!
    /** Customer Name value */
    @IBOutlet weak var tbxCustomerName: UITextView!
    /** Sale value */
    @IBOutlet weak var tbxSale: UITextView!
    /** Employee value */
    @IBOutlet weak var tbxEmployee: UITextView!
    /** Adress value */
    @IBOutlet weak var tbxAddress: UITextView!
    /** Contact value */
    @IBOutlet weak var tbxContact: UITextView!
    /** Problem value */
    @IBOutlet weak var tbxProblem: UITextView!
    /** Contet value */
    @IBOutlet weak var tbxContent: UITextView!
    /** Creator value */
    @IBOutlet weak var tbxCreator: UITextView!
    /** Create time value */
    @IBOutlet weak var tbxCreateTime: UITextView!
    /** Code value */
    @IBOutlet weak var tbxCode: UITextView!
    /** Height of view */
    static var VIEW_HEIGHT = GlobalConst.LABEL_HEIGHT * 15
    
    /** X margin */
    let marginX = GlobalConst.MARGIN_CELL_X
    /** Y margin */
    let marginY = GlobalConst.MARGIN_CELL_Y
    /** Width of left column */
    let leftWidth = (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2) / 3
    /** Width of right column */
    let rightWidth = (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2) * 2 / 3
   
    /**
     * Awake from nib
     */
    override func awakeFromNib() {
//        // Label Status
//        setLayoutLeft(lbl: lblStatus, offset: marginY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092, isDrawTopBorder: false)
//        // Status value
//        setLayoutRight(lbl: tbxStatusValue, offset: marginY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092, isDrawTopBorder: false)
//        
//        // Label Customer name
//        setLayoutLeft(lbl: lblCustomerName, offset: lblStatus.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00079)
//        // Customer name
//        setLayoutRight(lbl: tbxCustomerName, offset: lblStatus.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00092)
//        
//        // Label Sale
//        setLayoutLeft(lbl: lblSale, offset: lblCustomerName.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00144)
//        // Sale value
//        setLayoutRight(lbl: tbxSale, offset: lblCustomerName.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
//        
//        // Label Employee
//        setLayoutLeft(lbl: lblEmployee, offset: lblSale.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00145)
//        // Employee value
//        setLayoutRight(lbl: tbxEmployee, offset: lblSale.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
//        
//        // Label Address
//        setLayoutLeft(lbl: lblAddress, offset: lblEmployee.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00088)
//        // Address value
//        setLayoutRight(lbl: tbxAddress, offset: lblEmployee.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00092)
//        
//        // Label Contact
//        setLayoutLeft(lbl: lblContact, offset: lblAddress.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00146)
//        // Contact value
//        setLayoutRight(lbl: tbxContact, offset: lblAddress.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
//        
//        // Label Problem
//        setLayoutLeft(lbl: lblProblem, offset: lblContact.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00147)
//        // Problem value
//        setLayoutRight(lbl: tbxProblem, offset: lblContact.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
//        
//        // Label Content
//        setLayoutLeft(lbl: lblContent, offset: lblProblem.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00063)
//        // Content value
//        setLayoutRight(lbl: tbxContent, offset: lblProblem.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00092)
//        
//        // Label Creator
//        setLayoutLeft(lbl: lblCreator, offset: lblContent.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00095)
//        // Creator value
//        setLayoutRight(lbl: tbxCreator, offset: lblContent.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
//        
//        // Label CreateTime
//        setLayoutLeft(lbl: lblCreateTime, offset: lblCreator.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00096)
//        // CreateTime value
//        setLayoutRight(lbl: tbxCreateTime, offset: lblCreator.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
//        
//        // Label Code
//        setLayoutLeft(lbl: lblCode, offset: lblCreateTime.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00148)
//        // Code value
//        setLayoutRight(lbl: tbxCode, offset: lblCreateTime.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
        
        // Set data
        if Singleton.sharedInstance.sharedInt != -1 {
            // Check data is existed
            if Singleton.sharedInstance.upholdList.record.count > Singleton.sharedInstance.sharedInt {
                setData(model: Singleton.sharedInstance.upholdList.record[Singleton.sharedInstance.sharedInt])
            }
        }
    }
    
    /**
     * Set layout for left controls
     * - parameter lbl:     Label control
     * - parameter offset:  Y offset
     * - parameter height:  Height of layout
     * - parameter text:    Control's text
     */
    func setLayoutLeft(lbl: UILabel, offset: CGFloat, height: CGFloat, text: String, isDrawTopBorder: Bool = true) {
        lbl.translatesAutoresizingMaskIntoConstraints = true
        lbl.frame = CGRect(x: marginX, y: offset, width: leftWidth, height: height)
        lbl.text = text
        if isDrawTopBorder {
            lbl.layer.addBorder(edge: UIRectEdge.top)
        }
        lbl.layer.addBorder(edge: UIRectEdge.right)
    }
    
    /**
     * Set layout for right controls
     * - parameter lbl:     TextView control
     * - parameter offset:  Y offset
     * - parameter height:  Height of layout
     * - parameter text:    Control's text
     */
    func setLayoutRight(lbl: UITextView, offset: CGFloat, height: CGFloat, text: String, isDrawTopBorder: Bool = true) {
        lbl.translatesAutoresizingMaskIntoConstraints = true
        lbl.text = text
        alignTextVerticalInTextView(textView: lbl)
        lbl.frame = CGRect(x: marginX + leftWidth, y: offset, width: rightWidth, height: height)
        if isDrawTopBorder {
            lbl.layer.addBorder(edge: UIRectEdge.top)
        }
        lbl.isEditable = false
    }
    
    func alignTextVerticalInTextView(textView :UITextView) {
        
        let size = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: CGFloat(MAXFLOAT)))
        
        var topoffset = (textView.bounds.size.height - size.height * textView.zoomScale) / 2.0
        topoffset = topoffset < 0.0 ? 0.0 : topoffset
        
        textView.contentOffset = CGPoint(x: 0, y: -topoffset)
    }
    
    /**
     * Set data
     * - parameter model: Model data
     */
    func setData(model: UpholdBean) {
        var offset: CGFloat = marginY
        if model.uphold_type != DomainConst.UPHOLD_TYPE_PERIODICALLY {
            // Label Status
            setLayoutLeft(lbl: lblStatus, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092, isDrawTopBorder: false)
            // Status value
            setLayoutRight(lbl: tbxStatusValue, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092, isDrawTopBorder: false)
            offset += GlobalConst.LABEL_HEIGHT
            
            // Label Customer name
            setLayoutLeft(lbl: lblCustomerName, offset: offset, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00079)
            // Customer name
            setLayoutRight(lbl: tbxCustomerName, offset: offset, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00092)
        } else {
            lblStatus.isHidden = true
            tbxStatusValue.isHidden = true
            
            // Label Customer name
            setLayoutLeft(lbl: lblCustomerName, offset: offset, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00079, isDrawTopBorder: false)
            // Customer name
            setLayoutRight(lbl: tbxCustomerName, offset: offset, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00092, isDrawTopBorder: false)
        }
        
        // Label Sale
        setLayoutLeft(lbl: lblSale, offset: lblCustomerName.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00144)
        // Sale value
        setLayoutRight(lbl: tbxSale, offset: lblCustomerName.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
        
        // Label Employee
        setLayoutLeft(lbl: lblEmployee, offset: lblSale.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00145)
        // Employee value
        setLayoutRight(lbl: tbxEmployee, offset: lblSale.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
        
        // Label Address
        setLayoutLeft(lbl: lblAddress, offset: lblEmployee.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00088)
        // Address value
        setLayoutRight(lbl: tbxAddress, offset: lblEmployee.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00092)
        
        // Label Contact
        setLayoutLeft(lbl: lblContact, offset: lblAddress.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00146)
        // Contact value
        setLayoutRight(lbl: tbxContact, offset: lblAddress.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00092)
        
        if model.uphold_type != DomainConst.UPHOLD_TYPE_PERIODICALLY {
            // Label Problem
            setLayoutLeft(lbl: lblProblem, offset: lblContact.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00147)
            // Problem value
            setLayoutRight(lbl: tbxProblem, offset: lblContact.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
            
            // Label Content
            setLayoutLeft(lbl: lblContent, offset: lblProblem.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00063)
            // Content value
            setLayoutRight(lbl: tbxContent, offset: lblProblem.frame.maxY, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00092)
        } else {
            // Label Problem
            setLayoutLeft(lbl: lblProblem, offset: lblContact.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00177)
            // Problem value
            setLayoutRight(lbl: tbxProblem, offset: lblContact.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00177)
            
            // Label Content
            setLayoutLeft(lbl: lblContent, offset: lblProblem.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00161)
            // Content value
            setLayoutRight(lbl: tbxContent, offset: lblProblem.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00161)
        }
        
        // Label Creator
        setLayoutLeft(lbl: lblCreator, offset: lblContent.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00095)
        // Creator value
        setLayoutRight(lbl: tbxCreator, offset: lblContent.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
        
        // Label CreateTime
        setLayoutLeft(lbl: lblCreateTime, offset: lblCreator.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00096)
        // CreateTime value
        setLayoutRight(lbl: tbxCreateTime, offset: lblCreator.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
        
        // Label Code
        setLayoutLeft(lbl: lblCode, offset: lblCreateTime.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00148)
        // Code value
        setLayoutRight(lbl: tbxCode, offset: lblCreateTime.frame.maxY, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
        
        tbxStatusValue.text     = model.status
        tbxCustomerName.text    = model.customer_name
        tbxSale.text            = model.sale_name
        tbxEmployee.text        = model.employee_name
        tbxAddress.text         = model.customer_address
        tbxContact.text         = model.contact_person + " - " + model.contact_tel
        if model.uphold_type != DomainConst.UPHOLD_TYPE_PERIODICALLY {
            tbxProblem.text         = model.type_uphold
            tbxContent.text         = model.content
        } else {
            tbxProblem.text         = model.schedule_month
            tbxContent.text         = model.schedule_type
        }
        tbxCreator.text         = model.created_by
        tbxCreateTime.text      = model.created_date
        tbxCode.text            = model.code_no
    }
}
