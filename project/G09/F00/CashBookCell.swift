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
        self.lookupIcon.image = ImageManager.getImage(named: DomainConst.CASH_TYPE_ICON_IMG_NAME)
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
        if G09F00S01VC._cashBookType == DomainConst.CASHBOOK_TYPE_SCHEDULE {
            //&& (_data.allow_update == DomainConst.NUMBER_ONE_VALUE) {
            // Show collect money item when cashbook type is Schedule and allow update flag is ON
            alert.addAction(collectMoney)
        }
        
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = self
            /*presenter.sourceRect = self.bounds*/
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
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.requestCashBook(action: #selector(finishRequestCacheData(_:)),
                                     view: self)
        } else {
            // Start create ticket
            startCreateTicket()
        }
    }
    
    /**
     * Handle when finish request cache data
     */
    internal func finishRequestCacheData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            // Start create ticket
            startCreateTicket()
        } else {
            if self.parentViewController != nil {
                (self.parentViewController as! BaseViewController).showAlert(message: model.message)
            }
        }
    }
    
    /**
     * Start create ticket
     */
    private func startCreateTicket() {
        // Show alert
        //++ BUG0202-SPJ (KhoiVT 20180818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
        /*let alert = UIAlertController(title: DomainConst.CONTENT00433,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
        for item in CacheDataRespModel.record.getListTicketHandler() {
            let action = UIAlertAction(title: item.name,
                                       style: .default, handler: {
                                        action in
                                        self.handleCreateTicket(id: item.id)
            })
            alert.addAction(action)
        }
        
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = self
            //presenter.sourceRect = self.bounds
        }
        
        if self.parentViewController != nil {
            (self.parentViewController as! BaseViewController).present(alert, animated: true, completion: nil)
        }*/
        handleCreateTicket()
        //-- BUG0202-SPJ (KhoiVT 20180818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
    }
    
    /**
     * Open create ticket view controller
     * - parameter id: Id of ticket handler
     */
    internal func handleCreateTicket() {
        //++ BUG0202-SPJ (KhoiVT 201780818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
        //G11F01VC._handlerId = id
        G11F00S03VC._selectedValue.content = String.init(
            format: "Quỹ tiền mặt - %@ - %@\n",
            _data.created_date,
            _data.customer_name)
        if self.parentViewController != nil {
            (self.parentViewController as! BaseViewController).pushToView(name: G11F00S03VC.theClassName)
        }
        //-- BUG0202-SPJ (KhoiVT 20180818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
    }
    
    /**
     * Handle create cashbook
     */
    private func createCashBook() {
        //++ BUG0153-SPJ (NguyenPT 20170904) Fix bug create Cashbook schedule
//        openUpdateCashBookScreen()
        G09F01VC._typeId    = _data.master_lookup_id
        G09F01VC._mode      = DomainConst.NUMBER_ZERO_VALUE         // Create
        G09F01VC._id        = _data.id
        G09F01VC._updateData        = _data
        //++ BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
        G09F01VC._appOrderId = DomainConst.BLANK
        //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
        G09F01S01._selectedValue   = _data.date_input.replacingOccurrences(
            of: DomainConst.SPLITER_TYPE3,
            with: DomainConst.SPLITER_TYPE1)
        
        G09F01S02._target   = CustomerBean(id: _data.customer_id,
                                           name: _data.customer_name,
                                           phone: _data.customer_phone,
                                           address: _data.customer_address)
        G09F01S03._selectedValue = self._data.amount
        G09F01S04._selectedValue = _data.note
        if self.parentViewController != nil {
            (self.parentViewController as! BaseViewController).pushToView(name: G09F01VC.theClassName)
        }
        //-- BUG0153-SPJ (NguyenPT 20170904) Fix bug create Cashbook schedule
    }
    
    /**
     * Handle start create cashbook
     */
    private func openUpdateCashBookScreen() {
        if self.parentViewController != nil {
            EmployeeCashBookViewRequest.requestView(
                action: #selector(finishRequestCashBookViewCell(_:)),
                view: self,// (self.parentViewController as! BaseViewController),
                id: _data.id)
        }
    }
    
    /**
     * Finish request cashbook view
     */
    internal func finishRequestCashBookViewCell(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = EmployeeCashBookViewRespModel(jsonString: data)
        if model.isSuccess() {
            G09F01VC._typeId    = model.record.master_lookup_id
            //G09F01VC._mode      = DomainConst.NUMBER_ONE_VALUE
            G09F01VC._mode      = DomainConst.NUMBER_ZERO_VALUE         // Create
            G09F01VC._id        = model.record.id
            G09F01VC._updateData        = model.record
            //++ BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
            G09F01VC._appOrderId = DomainConst.BLANK
            //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
            G09F01S01._selectedValue   = model.record.date_input.replacingOccurrences(
                of: DomainConst.SPLITER_TYPE3,
                with: DomainConst.SPLITER_TYPE1)
            
            G09F01S02._target   = CustomerBean(id: model.record.customer_id,
                                               name: model.record.customer_name,
                                               phone: model.record.customer_phone,
                                               address: model.record.customer_address)
            G09F01S03._selectedValue = self._data.amount
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
