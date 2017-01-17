//
//  CreateUpholdStep3ViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F01S03: StepSummary {
    // MARK: Properties
    /** Label status */
    var lblProblem: UILabel = UILabel()
    /** Status value */
    var tbxProblem: UITextView = UITextView()
    /** Label Time */
    var lblContent: UILabel = UILabel()
    /** Time value */
    var tbxContent: UITextView = UITextView()
    /** Label Reviewer */
    var lblContact: UILabel = UILabel()
    /** Reviewer value */
    var tbxContact: UITextView = UITextView()
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    /**
     * Default initializer.
     */
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        // Update layout of content view
        let offset: CGFloat = updateLayout(w: w, h: h)
        // Set parent
        self.setParentView(parent: parent)
        
        contentView.addSubview(lblProblem)
        contentView.addSubview(tbxProblem)
        contentView.addSubview(lblContent)
        contentView.addSubview(tbxContent)
        contentView.addSubview(lblContact)
        contentView.addSubview(tbxContact)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00205, contentHeight: offset,
                   width: w, height: h)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateData),
                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F01),
                                               object: nil)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Update data of content view
     */
    func updateData() {
        tbxProblem.text     = G01F01S01._selectedValue.name
        tbxContent.text     = G01F01S01._otherProblem
        tbxContact.text     = G01F01S02._name + DomainConst.CONTACT_SPLITER + G01F01S02._phone
        var offset: CGFloat = GlobalConst.LABEL_HEIGHT
        lblContent.isHidden = true
        tbxContent.isHidden = true
        if G01F01S01._selectedValue.name == DomainConst.OPTION_OTHER {
            lblContent.isHidden = false
            tbxContent.isHidden = false
            offset += GlobalConst.LABEL_HEIGHT
        }
        updateLayout(view: lblContact, offset: offset)
        updateLayout(view: tbxContact, offset: offset)
        offset += GlobalConst.LABEL_HEIGHT * 1.5
        self.updateLayout(contentHeight: offset)
    }
    
    /**
     * Update layout of content view
     * - parameter view:    Content view
     * - parameter offset:  Offset value
     */
    func updateLayout(view: UIView, offset: CGFloat) {
        view.frame = CGRect(x: view.frame.origin.x, y: offset,
                            width: view.frame.width,
                            height: view.frame.height)
    }
    
    /**
     * Update layout of content view
     * - parameter w:   Width of view
     * - parameter h:   Height of view
     */
    func updateLayout(w: CGFloat, h: CGFloat) -> CGFloat {
        var offset: CGFloat = 0
        
        // Label Problem
        CommonProcess.setLayoutLeft(lbl: lblProblem, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00147)
        lblProblem.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Problem value
        CommonProcess.setLayoutRight(lbl: tbxProblem, x: lblProblem.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT, text: G01F01S01._selectedValue.name)
        tbxProblem.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Content
        CommonProcess.setLayoutLeft(lbl: lblContent, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00063)
        lblContent.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Content value
        CommonProcess.setLayoutRight(lbl: tbxContent, x: lblContent.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT, text: G01F01S01._otherProblem)
        tbxContent.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Contact
        CommonProcess.setLayoutLeft(lbl: lblContact, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT * 1.5, text: DomainConst.CONTENT00146)
        lblContact.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Contact value
        CommonProcess.setLayoutRight(lbl: tbxContact, x: lblContact.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT * 1.5,
                                     text: G01F02S04._selectedValue.name + DomainConst.CONTACT_SPLITER + G01F02S04._selectedValue.phone)
        tbxContact.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT * 1.5
        
        return offset
    }
}
