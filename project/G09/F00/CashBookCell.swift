//
//  CashBookCell.swift
//  project
//
//  Created by SPJ on 5/19/17.
//  Copyright © 2017 admin. All rights reserved.
//


import UIKit
import harpyframework

class CashBookCell: UITableViewCell {
    // MARK: Properties
    private var topView:            UIView = UIView()
    private var leftView:           UIView = UIView()
    private var centerView:         UIView = UIView()
    private var rightView:          UIView = UIView()
    private var bottomView:         UIView = UIView()
    
    // Top control
    private var customerLabel:      UILabel = UILabel()
    
    // Left controls
    private var dateTime:           CustomeDateTimeView = CustomeDateTimeView()
    
    // Center controls
    private var typeLabel:          UILabel = UILabel()
    private var totalLabel:         UILabel = UILabel()
    
    // Right control
    private var statusIcon:         UIImageView = UIImageView()
    /** Height of cell */
    public static var CELL_HEIGHT:  CGFloat = 0.0
    
    // Bottom control
    private var lookupIcon:         UIImageView = UIImageView()
    private var lookupLabel:        UILabel = UILabel()
    /** Height of top */
    private let topHeight: CGFloat = GlobalConst.CONFIGURATION_ITEM_HEIGHT - GlobalConst.MARGIN_CELL_X * 3
    /** Long press gesture */
    private var longPress:          UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    /** Data */
    private var _data:              CashBookBean = CashBookBean()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let contentHeight       = GlobalConst.CELL_HEIGHT_SHOW / 3 * 2
        let contentWidthLeft    = GlobalConst.SCREEN_WIDTH / 3
        let contentWidthRight   = GlobalConst.SCREEN_WIDTH / 6
        let contentWidthMid     = GlobalConst.SCREEN_WIDTH / 2
        let verticalMargin      = GlobalConst.MARGIN_CELL_X * 2
        var offset: CGFloat     = 0.0
        
        /** ---- Left view ------ */
        self.dateTime.setup(x: 0, y: 0, w: contentWidthLeft, h: contentHeight / 3, type: DomainConst.NUMBER_ONE_VALUE)
        offset += self.dateTime.frame.height
        CashBookCell.CELL_HEIGHT = topHeight + offset + GlobalConst.LABEL_H + verticalMargin * 2
        self.topView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: GlobalConst.SCREEN_WIDTH,
                                    height: topHeight)
        self.leftView.frame = CGRect(x: 0,
                                     y: topView.frame.maxY,
                                     width: contentWidthLeft,
                                     height: offset)
        self.centerView.frame = CGRect(x: self.leftView.frame.maxX,
                                       y: topView.frame.maxY,
                                       width: contentWidthMid,
                                       height: offset)
        self.rightView.frame = CGRect(x: self.centerView.frame.maxX,
                                      y: 0,
                                      width: contentWidthRight,
                                      height: CashBookCell.CELL_HEIGHT)
        self.bottomView.frame = CGRect(x: 0,
                                       y: self.leftView.frame.maxY + verticalMargin,
                                       width: GlobalConst.SCREEN_WIDTH - GlobalConst.CELL_HEIGHT_SHOW / 5,
                                       height: GlobalConst.LABEL_H + verticalMargin)
        
        /** ----- Top view ----- */
        // Customer label
        self.customerLabel.frame = CGRect(x: GlobalConst.MARGIN_CELL_X, y: 0,
                                          width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN_CELL_X,
                                          height: topHeight)
        self.customerLabel.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        self.customerLabel.textColor = GlobalConst.MAIN_COLOR
        self.customerLabel.text = DomainConst.BLANK
        self.customerLabel.numberOfLines = 0
        self.customerLabel.lineBreakMode = .byWordWrapping
        
        /** ---- Center view ------ */
        offset = GlobalConst.MARGIN_CELL_X
        // Code label
        self.typeLabel.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                      y: offset,
                                      width: contentWidthMid / 3 - GlobalConst.MARGIN_CELL_X,
                                      height: contentHeight / 3)
        self.typeLabel.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        self.typeLabel.text = DomainConst.BLANK
        // Total label
        self.totalLabel.frame = CGRect(x: self.typeLabel.frame.maxX,
                                       y: offset,
                                       width: contentWidthMid / 3 * 2 + GlobalConst.MARGIN_CELL_X,
                                       height: contentHeight / 3)
        self.totalLabel.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
        self.totalLabel.text = DomainConst.BLANK
        self.totalLabel.textColor = GlobalConst.MONEY_COLOR
        offset += self.typeLabel.frame.height
        
        /** ---- Right view ------ */
        // Status icon
        self.statusIcon.frame = CGRect(x: (contentWidthRight - contentHeight / 3) / 2,
                                       y: (rightView.frame.height - GlobalConst.ICON_SIZE) / 2,
                                       width: GlobalConst.ICON_SIZE,
                                       height: GlobalConst.ICON_SIZE)
        self.statusIcon.image = ImageManager.getImage(named: DomainConst.BLANK)
        
        /** ---- Bottom view ------ */
        // Lookup icon
        self.lookupIcon.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                        y: GlobalConst.CELL_HEIGHT_SHOW / 40,
                                        width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                        height: GlobalConst.CELL_HEIGHT_SHOW / 5)
        self.lookupIcon.image = ImageManager.getImage(named: DomainConst.ADDRESS_ICON_IMG_NAME)
        self.lookupIcon.contentMode = .scaleAspectFit
        // Lookup label
        self.lookupLabel.frame = CGRect(x: self.lookupIcon.frame.maxX,
                                         y: GlobalConst.CELL_HEIGHT_SHOW / 40,
                                         width: GlobalConst.SCREEN_WIDTH - GlobalConst.MARGIN_CELL_X - self.lookupIcon.frame.width,
                                         height: GlobalConst.LABEL_H)
        self.lookupLabel.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
        self.lookupLabel.textColor = GlobalConst.TEXT_COLOR_GRAY
        self.lookupLabel.text = DomainConst.BLANK
        self.lookupLabel.numberOfLines = 0
        self.lookupLabel.lineBreakMode = .byWordWrapping
        
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler(_:)))
        self.addGestureRecognizer(longPress)
        
        
        self.topView.addSubview(self.customerLabel)
        
        self.leftView.addSubview(dateTime)
        
        self.centerView.addSubview(self.typeLabel)
        self.centerView.addSubview(self.totalLabel)
        
        self.rightView.addSubview(self.statusIcon)
        
        self.bottomView.addSubview(self.lookupIcon)
        self.bottomView.addSubview(self.lookupLabel)
        
        self.addSubview(self.topView)
        self.addSubview(self.leftView)
        self.addSubview(self.centerView)
        self.addSubview(self.rightView)
        self.addSubview(self.bottomView)
        self.makeComponentsColor()
    }
    
    /**
     * Handle swipe gesture
     */
    func longPressHandler(_ sender: UIGestureRecognizer) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00401,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        
        let ticket = UIAlertAction(title: DomainConst.CONTENT00402,
                                   style: .default,
                                   handler: {
                                    action in
                                    self.createTicket()
        })
        
        let collectMoney = UIAlertAction(title: DomainConst.CONTENT00318,
                                         style: .default,
                                         handler: {
                                            action in
                                            self.createCashBook()
        })
        
        alert.addAction(cancel)
        alert.addAction(ticket)
        if G09F00S01VC._cashBookType == DomainConst.CASHBOOK_TYPE_SCHEDULE
            && (_data.allow_update == DomainConst.NUMBER_ONE_VALUE) {
            // Show collect money item when cashbook type is Schedule and allow update flag is ON
            alert.addAction(collectMoney)
        }
        // Show alert
        if self.parentViewController != nil {
            self.parentViewController?.present(alert, animated: true, completion: nil)
        }        
    }
    
    /**
     * Handle create ticket
     */
    private func createTicket() {
        if self.parentViewController != nil {
            (self.parentViewController as! BaseViewController).showAlert(message: DomainConst.CONTENT00362)
        }
    }
    
    /**
     * Handle create cashbook
     */
    private func createCashBook() {
        openUpdateCashBookScreen()
    }
    
    /**
     * Handle start create cashbook
     */
    private func openUpdateCashBookScreen() {
        if self.parentViewController != nil {
            EmployeeCashBookViewRequest.request(
                action: #selector(finishRequestCashBookView(_:)),
                view: (self.parentViewController as! BaseViewController),
                id: _data.id)
        }
    }
    
    /**
     * Finish request cashbook view
     */
    internal func finishRequestCashBookView(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = EmployeeCashBookViewRespModel(jsonString: data)
        if model.isSuccess() {
            G09F01VC._typeId    = model.record.master_lookup_id
            G09F01VC._mode      = DomainConst.NUMBER_ONE_VALUE
            G09F01VC._updateData        = model.record
            G09F01S01._selectedValue   = model.record.date_input
            
            G09F01S02._target   = CustomerBean(id: model.record.customer_id,
                                               name: model.record.customer_name,
                                               phone: model.record.customer_phone,
                                               address: model.record.customer_address)
            G09F01S03._selectedValue = model.record.amount
            G09F01S04._selectedValue = model.record.note
            if self.parentViewController != nil {
                (self.parentViewController as! BaseViewController).pushToView(name: G09F01VC.theClassName)
            }
        } else {
            if self.parentViewController != nil {
                (self.parentViewController as! BaseViewController).showAlert(message: model.message)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     * Set data for Cashbook
     * - parameter data: Cashbook
     */
    open func setData(data: CashBookBean) {
        _data = data
        self.dateTime.setValue(dateTime: data.date_input)
        self.customerLabel.text = data.customer_name
        self.typeLabel.text     = data.lookup_type_text
        
        // Lookup type text
        if data.lookup_type_text == DomainConst.CONTENT00372 {
            self.totalLabel.text    = DomainConst.PLUS_SPLITER + data.amount
        } else if data.lookup_type_text == DomainConst.CONTENT00373 {
            self.totalLabel.text    = DomainConst.SPLITER_TYPE1 + data.amount
        }
        
        self.lookupLabel.text   = data.master_lookup_text
        if data.allow_update == DomainConst.NUMBER_ONE_VALUE {
            self.statusIcon.image   = ImageManager.getImage(named: DomainConst.EDIT_ICON_IMG_NAME)
        } else {
            self.statusIcon.image   = ImageManager.getImage(named: DomainConst.BLANK)
        }
    }
}