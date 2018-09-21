//
//  G01F00S04Cell.swift
//  project
//
//  Created by SPJ on 6/3/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F00S04Cell: UITableViewCell {
    // MARK: Properties
    private var topView:    UIView = UIView()
    private var leftView:   UIView = UIView()
    private var centerView: UIView = UIView()
    private var rightView:  UIView = UIView()
    private var bottomView: UIView = UIView()
    
    // Top control
    private var customerLabel: UILabel = UILabel()
    
    // Center controls
    private var codeLabel: UILabel = UILabel()
    
    // Right control
    private var statusIcon: UIImageView = UIImageView()
    public static var CELL_HEIGHT: CGFloat = 0.0
    
    // Bottom control
    private var noteIcon:       UIImageView         = UIImageView()
    private var noteLabel:      UILabel             = UILabel()
    private var addressIcon:    UIImageView         = UIImageView()
    private var addressLabel:   UILabel             = UILabel()
    private var btnAction:      UIButton            = UIButton()
    private var btnCancel:      UIButton            = UIButton()
    
    // Left controls
    private var dateTime: CustomeDateTimeView = CustomeDateTimeView()
    /** Delegate */
    public var delegate: OrderConfirmDelegate?
    private let topHeight: CGFloat = GlobalConst.LABEL_H//GlobalConst.CONFIGURATION_ITEM_HEIGHT - GlobalConst.MARGIN_CELL_X * 3
    
    // MARK: Methods
    /**
     * Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let contentHeight       = GlobalConst.CELL_HEIGHT_SHOW / 3 * 2
        let contentWidthLeft    = GlobalConst.SCREEN_WIDTH / 4
        let contentWidthRight   = GlobalConst.SCREEN_WIDTH / 4
        let contentWidthMid     = GlobalConst.SCREEN_WIDTH / 2
        let verticalMargin      = GlobalConst.MARGIN_CELL_X * 2
        var offset: CGFloat     = 0.0
        
        /** ---- Left view ------ */
        self.dateTime.setup(x: 0, y: 0, w: contentWidthLeft, h: contentHeight)
        offset += self.dateTime.frame.height
        G01F00S04Cell.CELL_HEIGHT = topHeight + contentHeight + GlobalConst.CELL_HEIGHT_SHOW / 4 + GlobalConst.BUTTON_H + GlobalConst.LABEL_H
        
        
        self.topView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: GlobalConst.SCREEN_WIDTH,
                                    height: topHeight)
        self.leftView.frame = CGRect(x: 0,
                                     y: topView.frame.maxY,
                                     width: GlobalConst.SCREEN_WIDTH / 4,
                                     height: offset)
        self.centerView.frame = CGRect(x: self.leftView.frame.maxX,
                                       y: topView.frame.maxY,
                                       width: GlobalConst.SCREEN_WIDTH / 2,
                                       height: offset)
        self.rightView.frame = CGRect(x: self.centerView.frame.maxX,
                                      y: 0,
                                      width: GlobalConst.SCREEN_WIDTH / 4,
                                      height: G01F00S04Cell.CELL_HEIGHT - GlobalConst.CELL_HEIGHT_SHOW / 4 - GlobalConst.LABEL_H)
        self.bottomView.frame = CGRect(x: 0,
                                       y: self.leftView.frame.maxY - verticalMargin * 2,
                                       width: GlobalConst.SCREEN_WIDTH - GlobalConst.CELL_HEIGHT_SHOW / 5,
                                       height: GlobalConst.LABEL_H * 2 + GlobalConst.BUTTON_H + verticalMargin)
        
        /** ----- Top view ----- */
        // Customer label
        self.customerLabel.frame = CGRect(x: GlobalConst.MARGIN_CELL_X, y: GlobalConst.MARGIN_CELL_X,
                                          width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN_CELL_X,
                                          height: topHeight)
        self.customerLabel.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        self.customerLabel.textColor = GlobalConst.MAIN_COLOR
        self.customerLabel.text = DomainConst.BLANK
        self.customerLabel.numberOfLines = 0
        self.customerLabel.lineBreakMode = .byWordWrapping
        
        /** ---- Center view ------ */
        offset = verticalMargin
        // Code label
        self.codeLabel.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                      y: offset,
                                      width: contentWidthMid / 3 * 2 - GlobalConst.MARGIN_CELL_X,
                                      height: contentHeight / 3)
        self.codeLabel.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        self.codeLabel.text = DomainConst.BLANK
        
        /** ---- Right view ------ */
        // Status icon
        self.statusIcon.frame = CGRect(x: (contentWidthRight - contentHeight / 3) / 2,
                                       y: (rightView.frame.height - GlobalConst.ICON_SIZE) / 2,
                                       width: GlobalConst.ICON_SIZE,
                                       height: GlobalConst.ICON_SIZE)
        self.statusIcon.image = ImageManager.getImage(named: DomainConst.BLANK)
        
        /** ---- Bottom view ------ */
        var botOffset: CGFloat = 0
        // Address icon
        self.addressIcon.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                        y: GlobalConst.CELL_HEIGHT_SHOW / 40,
                                        width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                        height: GlobalConst.CELL_HEIGHT_SHOW / 5)
        self.addressIcon.image = ImageManager.getImage(named: DomainConst.ADDRESS_ICON_IMG_NAME)
        self.addressIcon.contentMode = .scaleAspectFit
        
        // Address label
        self.addressLabel.frame = CGRect(x: self.addressIcon.frame.maxX,
                                         y: 0,
                                         width: GlobalConst.SCREEN_WIDTH - GlobalConst.MARGIN_CELL_X * 2 - self.addressIcon.frame.width,
                                         height: GlobalConst.LABEL_H)
        self.addressLabel.font = UIFont.systemFont(ofSize: GlobalConst.SMALL_FONT_SIZE_LIST)
        self.addressLabel.textColor = GlobalConst.TEXT_COLOR_GRAY
        self.addressLabel.text = DomainConst.BLANK
        
        botOffset += GlobalConst.LABEL_H
        // Note icon
        self.noteIcon.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                        y: botOffset,
                                        width: GlobalConst.ICON_SIZE,
                                        height: GlobalConst.ICON_SIZE)
        self.noteIcon.image = ImageManager.getImage(named: DomainConst.PROBLEM_TYPE_IMG_NAME)
        self.noteIcon.contentMode = .scaleAspectFit
        
        // Note label
        self.noteLabel.frame = CGRect(x: self.noteIcon.frame.maxX,
                                         y: botOffset,
                                         width: GlobalConst.SCREEN_WIDTH - GlobalConst.MARGIN_CELL_X * 2 - self.noteIcon.frame.width,
                                         height: GlobalConst.LABEL_H)
        self.noteLabel.font = UIFont.systemFont(ofSize: GlobalConst.SMALL_FONT_SIZE_LIST)
        self.noteLabel.textColor = GlobalConst.TEXT_COLOR_GRAY
        self.noteLabel.text = DomainConst.BLANK
        botOffset += noteLabel.frame.height + verticalMargin
        
        // Button action
        setupButton(button: btnAction,
                    x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                    y: botOffset, title: DomainConst.CONTENT00217,
                    icon: DomainConst.CONFIRM_IMG_NAME,
                    color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnActionHandler(_:)))
        setupButton(button: btnCancel,
                    x: GlobalConst.SCREEN_WIDTH / 2,
                    y: botOffset, title: DomainConst.CONTENT00220,
                    icon: DomainConst.CANCEL_IMG_NAME,
                    color: GlobalConst.BUTTON_COLOR_YELLOW,
                    action: #selector(btnCancelHandler(_:)))
        botOffset += btnCancel.frame.height + GlobalConst.MARGIN
        
        self.topView.addSubview(self.customerLabel)
        self.leftView.addSubview(dateTime)
        self.centerView.addSubview(self.codeLabel)
        self.rightView.addSubview(self.statusIcon)
        
        self.bottomView.addSubview(self.addressIcon)
        self.bottomView.addSubview(self.addressLabel)
        self.bottomView.addSubview(self.noteIcon)
        self.bottomView.addSubview(self.noteLabel)
        self.bottomView.addSubview(self.btnAction)
        self.bottomView.addSubview(self.btnCancel)
        self.addSubview(self.topView)
        self.addSubview(self.leftView)
        self.addSubview(self.centerView)
        self.addSubview(self.rightView)
        self.addSubview(self.bottomView)
        self.makeComponentsColor()
    }
    /**
     * Setup button for this view
     * - parameter button:  Button to setup
     * - parameter x:       X position of button
     * - parameter y:       Y position of button
     * - parameter title:   Title of button
     * - parameter icon:    Icon of button
     * - parameter color:   Color of button
     * - parameter action:  Action of button
     */
    private func setupButton(button: UIButton, x: CGFloat, y: CGFloat, title: String,
                             icon: String, color: UIColor, action: Selector) {
        button.frame = CGRect(x: x,
                              y: y,
                              width: GlobalConst.BUTTON_W / 2,
                              height: GlobalConst.BUTTON_H)
        button.clipsToBounds = true
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.setBackgroundColor(color: color, forState: .normal)
        button.setBackgroundColor(color: GlobalConst.BUTTON_COLOR_GRAY, forState: .disabled)
        button.titleLabel?.font         = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        button.layer.cornerRadius       = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        button.imageView?.contentMode   = .scaleAspectFit
        button.setImage(ImageManager.getImage(named: icon), for: UIControlState())
        button.addTarget(self, action: action, for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                              left: GlobalConst.MARGIN,
                                              bottom: GlobalConst.MARGIN,
                                              right: GlobalConst.MARGIN)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     * Set data for cell
     * - parameter data: FamilyUpholdBean object
     */
    open func setData(data: FamilyUpholdBean) {
        self.dateTime.setValue(dateTime: data.created_date)
        self.customerLabel.text = String.init(format: "%@ - %@",
                                              data.customer_name, data.customer_phone)
        self.codeLabel.text = data.name
        self.addressLabel.text = data.customer_address
        self.noteLabel.text = data.note_create
        self.statusIcon.image = ImageManager.getImage(named: getStatusIcon(status: data.status_number))
        btnAction.isEnabled = (data.show_confirm == DomainConst.NUMBER_ONE_VALUE)
        btnCancel.isEnabled = (data.show_cancel == DomainConst.NUMBER_ONE_VALUE)
        self.btnAction.accessibilityIdentifier = data.id
        self.btnCancel.accessibilityIdentifier = data.id
        let isHidden = ((data.show_confirm == DomainConst.NUMBER_ZERO_VALUE)
            && (data.show_cancel == DomainConst.NUMBER_ZERO_VALUE))
        btnAction.isHidden = isHidden
        btnCancel.isHidden = isHidden
        if isHidden {
            G01F00S04Cell.CELL_HEIGHT = topHeight + GlobalConst.CELL_HEIGHT_SHOW / 3 * 2 + GlobalConst.CELL_HEIGHT_SHOW / 4 + GlobalConst.LABEL_H
        } else {
            G01F00S04Cell.CELL_HEIGHT = topHeight + GlobalConst.CELL_HEIGHT_SHOW / 3 * 2 + GlobalConst.CELL_HEIGHT_SHOW / 4 + GlobalConst.BUTTON_H + GlobalConst.LABEL_H
        }
    }
    
    /**
     * Get status icon from status string
     * - parameter status: Status string
     * - returns: Status icon path
     */
    private func getStatusIcon(status: String) -> String {
        var retVal = DomainConst.BLANK
        switch status {
        case String(FamilyUpholdStatusEnum.STATUS_NEW.rawValue):
            retVal = DomainConst.ORDER_STATUS_NEW_ICON_IMG_NAME
            break
        case String(FamilyUpholdStatusEnum.STATUS_NEW.rawValue):
            retVal = DomainConst.ORDER_STATUS_NEW_ICON_IMG_NAME
            break
        case String(FamilyUpholdStatusEnum.STATUS_COMPLETE.rawValue):
            retVal = DomainConst.FINISH_STATUS_IMG_NAME
            break
        case String(FamilyUpholdStatusEnum.STATUS_CANCEL.rawValue):
            retVal = DomainConst.ORDER_STATUS_CANCEL_ICON_IMG_NAME
            break
        default:
            break
        }
        return retVal
    }
    
    /**
     * Handle when tap action button
     */
    internal func btnActionHandler(_ sender: AnyObject) {
        delegate?.btnActionTapped(sender)
    }
    
    /**
     * Handle when tap action button
     */
    internal func btnCancelHandler(_ sender: AnyObject) {
        delegate?.btnCancelTapped(sender)
    }
}
