//
//  OrderPreview.swift
//  project
//
//  Created by SPJ on 10/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderPreview: UIView {
    // MARK: Properties
    /** Title label */
    var lblTitle:           UILabel                 = UILabel()
    /** Delivery info label */
    var lblDeliveryInfo:    UILabel                 = UILabel()
    /** Button update delivery info */
    var btnUpdateInfo:      UIButton                = UIButton()
    /** Delivery info table view */
    var tblDeliveryInfo:    UITableView             = UITableView()
    /** Data */
    var deliveryInfo:      [ConfigurationModel]     = [ConfigurationModel]()
    /** Information table view */
    var tblInfo:            UITableView             = UITableView()
    /** List of information data */
    var listInfo:           [ConfigurationModel]    = [ConfigurationModel]()
    /** Gas select image */
    var imgGas:             UIImageView             = UIImageView()
    /** Gas select button */
    var btnGas:             UIButton                = UIButton()
    /** Promote label */
    var lblPromote:         UILabel                 = UILabel()
    /** Promote value label */
    var lblPromoteValue:    UILabel                 = UILabel()
    /** Promote select image */
    var imgPromote:         UIImageView             = UIImageView()
    /** Promote select button */
    var btnPromote:         UIButton                = UIButton()
    /** Cancel button */
    var btnCancel:          UIButton                = UIButton()
    /** Next button */
    var btnNext:            UIButton                = UIButton()
    
    /** Delegate */
    public var delegate:    OrderPreviewDelegate?
    
    // MARK: Constants
    var tblCellHeight:      CGFloat                 = 0.0
    let TITLE_LABEL_HEIGH:          CGFloat             = GlobalConst.LABEL_H * 2
    let FIRST_COLUMN_WIDTH_RATE:    CGFloat             = 4 / 5
    let SECOND_COLUMN_WIDTH_RATE:   CGFloat             = 1 / 5
    let TABLE_VIEW_HEIGHT_RATE:     CGFloat             = 1 / 3
    let GAS_SELECT_IMG_RATE:        CGFloat             = 3 / 4
    let GAS_SELECT_LBL_RATE:        CGFloat             = 1 / 4
    let BACKGROUND_COLOR:           UIColor             = UIColor.white
    let TEXT_COLOR:                 UIColor             = UIColor.black
    let TEXT_ACTIVE_COLOR:          UIColor             = GlobalConst.MAIN_COLOR_GAS_24H
    /**
     * Initializer
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Setup view
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    public func setup(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        var offset:             CGFloat = 0.0
        let firstColumnWidth:   CGFloat = w * FIRST_COLUMN_WIDTH_RATE
        let secondColumnWidth:  CGFloat = w * SECOND_COLUMN_WIDTH_RATE
        // Title label
        lblTitle.frame = CGRect(
            x: offset, y: 0,
            width: w,
            height: TITLE_LABEL_HEIGH)
        lblTitle.text            = DomainConst.CONTENT00516.uppercased()
        lblTitle.textColor       = UIColor.white
        lblTitle.textAlignment   = .center
        lblTitle.backgroundColor = GlobalConst.TEXT_COLOR_GRAY
        lblTitle.font            = GlobalConst.BASE_BOLD_FONT
        offset += lblTitle.frame.height
        // Calculate
        let actionButtonHeight: CGFloat = lblTitle.frame.height - 2 * GlobalConst.MARGIN_CELL_X
        let tblHeight:          CGFloat = (h - actionButtonHeight) * TABLE_VIEW_HEIGHT_RATE
        self.tblCellHeight = tblHeight / 3
//        let corner = actionButtonHeight / 2
//        let btnYPos = lblTitle.frame.minY + GlobalConst.MARGIN_CELL_X
        let cancelLeft = lblTitle.frame.minX + GlobalConst.MARGIN_CELL_X
        
        // Delivery info label
        lblDeliveryInfo.frame = CGRect(
            x: 0,
            y: offset,
            width: firstColumnWidth,
            height: GlobalConst.LABEL_H)
        lblDeliveryInfo.text            = DomainConst.CONTENT00518
        lblDeliveryInfo.textColor       = TEXT_COLOR
        lblDeliveryInfo.textAlignment   = .center
//        lblDeliveryInfo.backgroundColor = BACKGROUND_COLOR
        lblDeliveryInfo.font            = GlobalConst.BASE_FONT
        
        // Delivery infor update button
        btnUpdateInfo.frame = CGRect(x: lblDeliveryInfo.frame.maxX,
                              y: offset,
                              width: secondColumnWidth,
                              height: lblDeliveryInfo.frame.height)
        btnUpdateInfo.setTitle(DomainConst.CONTENT00517, for: UIControlState())
        btnUpdateInfo.titleLabel?.font = UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)
        btnUpdateInfo.addTarget(self, action: #selector(btnDeliveryInfoUpdateTapped), for: .touchUpInside)
        btnUpdateInfo.setTitleColor(TEXT_ACTIVE_COLOR, for: .normal)
        btnUpdateInfo.setTitleColor(TEXT_COLOR, for: .selected)
        btnUpdateInfo.setBackgroundColor(color: BACKGROUND_COLOR, forState: UIControlState())
        offset += lblDeliveryInfo.frame.height
        
        // Delivery table view
        tblDeliveryInfo.frame = CGRect(x: 0,
                               y: offset,
                               width: w,
                               height: tblHeight)
        tblDeliveryInfo.dataSource  = self
        tblDeliveryInfo.delegate    = self
        offset += tblDeliveryInfo.frame.height
        
        // Table view
        tblInfo.frame = CGRect(x: 0,
                               y: offset,
                               width: firstColumnWidth,
                               height: tblHeight)
        tblInfo.dataSource  = self
        tblInfo.delegate    = self
        
        // Gas select button
        let tappedRecogGas = UITapGestureRecognizer(
            target: self,
            action: #selector(btnGasTapped(_:)))
        imgGas.frame = CGRect(x: tblInfo.frame.maxX,
                              y: tblInfo.frame.minY,
                              width: secondColumnWidth,
                              height: tblHeight * GAS_SELECT_IMG_RATE)
        imgGas.contentMode = .scaleAspectFit
        imgGas.isUserInteractionEnabled = true
        imgGas.addGestureRecognizer(tappedRecogGas)
//        imgGas.backgroundColor = BACKGROUND_COLOR
        
        // Button gas
        btnGas.frame = CGRect(x: imgGas.frame.minX,
                              y: imgGas.frame.maxY,
                              width: imgGas.frame.width,
                              height: tblHeight * GAS_SELECT_LBL_RATE)
        btnGas.setTitle(DomainConst.CONTENT00517, for: UIControlState())
        btnGas.titleLabel?.font = UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)
        btnGas.addTarget(self, action: #selector(btnGasTapped), for: .touchUpInside)
        btnGas.setTitleColor(TEXT_ACTIVE_COLOR, for: .normal)
        btnGas.setTitleColor(TEXT_COLOR, for: .selected)
        btnGas.setBackgroundColor(color: BACKGROUND_COLOR, forState: UIControlState())
        offset += tblInfo.frame.height
        
        // Promote label
        lblPromote.frame = CGRect(
            x: 0,
            y: offset,
            width: firstColumnWidth / 2,
            height: tblHeight)
        lblPromote.text            = DomainConst.CONTENT00531 + " :"
        lblPromote.textColor       = TEXT_COLOR
        lblPromote.textAlignment   = .center
//        lblPromote.backgroundColor = BACKGROUND_COLOR
        lblPromote.font            = GlobalConst.BASE_FONT
        
        // Promote value label
        let tappedRecog = UITapGestureRecognizer(
            target: self,
            action: #selector(imgPromoteTapped(_:)))
        let tappedRecogLbl = UITapGestureRecognizer(
            target: self,
            action: #selector(imgPromoteTapped(_:)))
        lblPromoteValue.frame = CGRect(
            x: lblPromote.frame.maxX,
            y: offset,
            width: firstColumnWidth / 2,
            height: tblHeight)
        lblPromoteValue.text            = DomainConst.BLANK
        lblPromoteValue.textColor       = TEXT_ACTIVE_COLOR
        lblPromoteValue.textAlignment   = .left
//        lblPromoteValue.backgroundColor = BACKGROUND_COLOR
        lblPromoteValue.font            = GlobalConst.BASE_FONT
        lblPromoteValue.isUserInteractionEnabled = true
        lblPromoteValue.addGestureRecognizer(tappedRecogLbl)
        
        // Promote select button
        imgPromote.frame = CGRect(x: tblInfo.frame.maxX,
                              y: offset,
                              width: secondColumnWidth,
                              height: tblHeight * GAS_SELECT_IMG_RATE)
        imgPromote.contentMode = .scaleAspectFit
//        imgPromote.backgroundColor = BACKGROUND_COLOR
        imgPromote.isUserInteractionEnabled = true
        imgPromote.addGestureRecognizer(tappedRecog)
        
        // Button promote
        btnPromote.frame = CGRect(x: imgPromote.frame.minX,
                              y: imgPromote.frame.maxY,
                              width: imgPromote.frame.width,
                              height: tblHeight * GAS_SELECT_LBL_RATE)
        btnPromote.setTitle(DomainConst.CONTENT00517, for: UIControlState())
        btnPromote.titleLabel?.font = UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)
        btnPromote.addTarget(self, action: #selector(btnPromoteTapped(_:)), for: .touchUpInside)
        btnPromote.setTitleColor(TEXT_ACTIVE_COLOR, for: .normal)
        btnPromote.setTitleColor(TEXT_COLOR, for: .selected)
        btnPromote.setBackgroundColor(color: BACKGROUND_COLOR, forState: UIControlState())
        
        offset += lblPromote.frame.height
        
        // Action buttons
        btnCancel.frame = CGRect(x: cancelLeft,
                                 y: offset,
                                 width: w / 3,
                                 height: actionButtonHeight)
        let img = ImageManager.getImage(named: DomainConst.CANCEL_ORDER_BUTTON_ICON_IMG_NAME)
        btnCancel.tintColor = GlobalConst.TEXT_COLOR_GRAY
        btnCancel.setImage(img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        btnCancel.setImage(img, for: .highlighted)
        btnCancel.imageView?.contentMode = .scaleAspectFit
        btnCancel.setTitle(DomainConst.CONTENT00202, for: UIControlState())
        btnCancel.setTitleColor(GlobalConst.TEXT_COLOR_GRAY, for: UIControlState())
        btnCancel.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        btnCancel.backgroundColor = BACKGROUND_COLOR
//        btnCancel.layer.cornerRadius = corner
        btnCancel.addTarget(self, action: #selector(btnCancelTapped(_:)), for: .touchUpInside)
        
        btnNext.frame = CGRect(x: w / 3,
                               y: offset,
                               width: 2 * w / 3,
                               height: actionButtonHeight)
//        btnNext.layer.cornerRadius = corner
        btnNext.setImage(ImageManager.getImage(named: DomainConst.NEXT_BUTTON_ICON_IMG_NAME),
                         for: .normal)
        btnNext.imageView?.contentMode = .scaleAspectFit
        btnNext.setTitle(DomainConst.CONTENT00519, for: UIControlState())
        btnNext.setTitleColor(TEXT_ACTIVE_COLOR, for: UIControlState())
        btnNext.backgroundColor = BACKGROUND_COLOR
        btnNext.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        btnNext.addTarget(self, action: #selector(btnNextTapped(_:)), for: .touchUpInside)
        offset += btnNext.frame.height
        
        self.frame = CGRect(x: x, y: y, width: w, height: offset)
        self.backgroundColor = BACKGROUND_COLOR
        
        self.addSubview(lblTitle)
        self.addSubview(btnCancel)
        self.addSubview(btnNext)
        self.addSubview(lblDeliveryInfo)
        self.addSubview(btnUpdateInfo)
        self.addSubview(tblDeliveryInfo)
        self.addSubview(tblInfo)
        self.addSubview(imgGas)
        self.addSubview(btnGas)
        self.addSubview(lblPromote)
        self.addSubview(lblPromoteValue)
        self.addSubview(imgPromote)
        self.addSubview(btnPromote)
    }
    
    /**
     * Update view
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    public func update(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        var offset:             CGFloat = 0.0
        let firstColumnWidth:   CGFloat = w * FIRST_COLUMN_WIDTH_RATE
        let secondColumnWidth:  CGFloat = w * SECOND_COLUMN_WIDTH_RATE
        CommonProcess.updateViewPos(
            view: lblTitle,
            x: 0, y: 0, w: w, h: TITLE_LABEL_HEIGH)
        offset += lblTitle.frame.maxY
        
        let actionButtonHeight: CGFloat = lblTitle.frame.height - 2 * GlobalConst.MARGIN_CELL_X
        let tblHeight:          CGFloat = (h - actionButtonHeight) * TABLE_VIEW_HEIGHT_RATE
        let cancelLeft = lblTitle.frame.minX + GlobalConst.MARGIN_CELL_X
        
        CommonProcess.updateViewPos(
            view: lblDeliveryInfo,
            x: 0,
            y: offset,
            w: firstColumnWidth,
            h: GlobalConst.LABEL_H)
        
        CommonProcess.updateViewPos(
            view: btnUpdateInfo,
            x: lblDeliveryInfo.frame.maxX,
            y: offset,
            w: secondColumnWidth,
            h: lblDeliveryInfo.frame.height)
        offset += lblDeliveryInfo.frame.height
        
        CommonProcess.updateViewPos(
            view: tblDeliveryInfo,
            x: 0, y: offset,
            w: w,
            h: tblHeight)
        offset += tblDeliveryInfo.frame.height
        
        CommonProcess.updateViewPos(
            view: tblInfo,
            x: 0, y: offset,
            w: firstColumnWidth,
            h: tblHeight)
        CommonProcess.updateViewPos(
            view: imgGas,
            x: tblInfo.frame.maxX,
            y: tblInfo.frame.minY,
            w: secondColumnWidth,
            h: tblHeight * GAS_SELECT_IMG_RATE)
        CommonProcess.updateViewPos(
            view: btnGas,
            x: imgGas.frame.minX,
            y: imgGas.frame.maxY,
            w: imgGas.frame.width,
            h: tblHeight * GAS_SELECT_LBL_RATE)
        offset += tblInfo.frame.height
        
        CommonProcess.updateViewPos(
            view: lblPromote,
            x: 0,
            y: offset,
            w: firstColumnWidth / 2,
            h: tblHeight)
        
        CommonProcess.updateViewPos(
            view: lblPromoteValue,
            x: lblPromote.frame.maxX,
            y: offset,
            w: firstColumnWidth / 2,
            h: tblHeight)
        
        CommonProcess.updateViewPos(
            view: imgPromote,
            x: tblInfo.frame.maxX,
            y: offset,
            w: secondColumnWidth,
            h: tblHeight * GAS_SELECT_IMG_RATE)
        CommonProcess.updateViewPos(
            view: btnPromote,
            x: imgPromote.frame.minX,
            y: imgPromote.frame.maxY,
            w: imgPromote.frame.width,
            h: tblHeight * GAS_SELECT_LBL_RATE)
        
        offset += lblPromote.frame.height
        CommonProcess.updateViewPos(
            view: btnCancel,
            x: cancelLeft,
            y: offset,
            w: w / 3,
            h: actionButtonHeight)
        CommonProcess.updateViewPos(
            view: btnNext,
            x: w / 3,
            y: offset,
            w: 2 * w / 3,
            h: actionButtonHeight)
        offset += btnNext.frame.height
        CommonProcess.updateViewPos(
            view: self,
            x: x, y: y, w: w, h: offset)
    }
    
    /**
     * Set data for this view
     */
    public func setData(data: OrderBean) {
        // Delivery info
        deliveryInfo.append(ConfigurationModel(
            id: DomainConst.NUMBER_ZERO_VALUE,
            name: DomainConst.CONTENT00079,
            iconPath: DomainConst.NAME_ICON_IMG_NAME,
            value: data.first_name))
        deliveryInfo.append(ConfigurationModel(
            id: DomainConst.NUMBER_ONE_VALUE,
            name: DomainConst.CONTENT00088,
            iconPath: DomainConst.ADDRESS_ICON_NEW_IMG_NAME,
            value: data.address))
        deliveryInfo.append(ConfigurationModel(
            id: DomainConst.NUMBER_TWO_VALUE,
            name: DomainConst.CONTENT00152,
            iconPath: DomainConst.PHONE_ICON_NEW_IMG_NAME,
            value: data.phone))
        tblDeliveryInfo.reloadData()
        
        // List information
        self.listInfo.removeAll()
        // Gas and promote
        for item in data.order_detail {
            if item.isGas() {
                setDataForGas(data: item)
                self.listInfo.append(ConfigurationModel(orderDetail: item))
            } else if item.isPromotion() {
                setDataForPromote(data: item)
            }
        }
        if data.discount_amount != DomainConst.NUMBER_ZERO_VALUE {
            self.listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_DISCOUNT,
                name: DomainConst.CONTENT00239,
                iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                value: DomainConst.SPLITER_TYPE1 + data.discount_amount))
        }
        self.listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_TOTAL_MONEY_ID,
            name: DomainConst.CONTENT00218,
            iconPath: DomainConst.MONEY_ICON_IMG_NAME,
            value: data.grand_total))
        
        // Reload data
        tblInfo.reloadData()
    }
    
    private func setDataForGas(data: OrderDetailBean) {
        self.imgGas.setImage(imgPath: data.material_image)
    }
    
    private func setDataForPromote(data: OrderDetailBean) {
        self.imgPromote.setImage(imgPath: data.material_image)
        self.lblPromoteValue.text = data.material_name
    }
    
    // MARK: Event handler
    /**
     * Handle when tap on Gas select button
     */
    func btnDeliveryInfoUpdateTapped(_ sender: AnyObject) {
        delegate?.btnDeliveryInfoUpdateTapped(sender)
    }
    
    /**
     * Handle when tap on Gas select button
     */
    func btnGasTapped(_ sender: AnyObject) {
        delegate?.btnGasTapped(sender)
    }
    
    /**
     * Handle when tap on Promote select button
     */
    func btnPromoteTapped(_ sender: AnyObject) {
        delegate?.btnPromoteTapped(sender)
    }
    
    /**
     * Handle when tap on Cancel button
     */
    func btnCancelTapped(_ sender: AnyObject) {
        delegate?.btnCancelTapped(sender)
    }
    
    /**
     * Handle when tap on Next button
     */
    func btnNextTapped(_ sender: AnyObject) {
        delegate?.btnNextTapped(sender)
    }
    
    func imgPromoteTapped(_ gest: UITapGestureRecognizer) {
        btnPromoteTapped(self)
    }
}

extension OrderPreview: UITableViewDataSource {
    /**
     * Asks the data source to return the number of sections in the table view.
     * - returns: 1 section
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     * - returns: List information count
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblDeliveryInfo {
            return 3
        } else if tableView == tblInfo {
            return self.listInfo.count
        }
        return 0
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tblInfo:
            if indexPath.row > listInfo.count {
                return UITableViewCell()
            }
            let data = listInfo[indexPath.row]
            let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
            cell.textLabel?.text = data.name
            cell.textLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.text = data.getValue()
            switch data.id {
            case DomainConst.ORDER_INFO_TOTAL_MONEY_ID:
                cell.detailTextLabel?.textColor = TEXT_ACTIVE_COLOR
                cell.detailTextLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
            case DomainConst.ORDER_INFO_DISCOUNT:
                cell.detailTextLabel?.textColor = TEXT_ACTIVE_COLOR
                cell.detailTextLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
                break
            default:
                cell.detailTextLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
                break
            }
            return cell
        case tblDeliveryInfo:
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            if indexPath.row < self.deliveryInfo.count {
                let data = self.deliveryInfo[indexPath.row]
                cell.imageView?.setImage(imgPath: data.getIconPath())
                cell.imageView?.contentMode = .scaleAspectFit
                cell.textLabel?.text = data.getValue()
                cell.textLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
                cell.textLabel?.lineBreakMode = .byWordWrapping
                cell.textLabel?.numberOfLines = 0
//                cell.detailTextLabel?.text = data.getValue()
//                cell.detailTextLabel?.font = GlobalConst.BASE_BOLD_FONT
//                cell.detailTextLabel?.lineBreakMode = .byWordWrapping
//                cell.detailTextLabel?.numberOfLines = 0
            }
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

extension OrderPreview: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tblCellHeight
    }
}

