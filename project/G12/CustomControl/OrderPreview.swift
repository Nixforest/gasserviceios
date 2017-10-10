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
    var lblTitle:           UILabel = UILabel()
    /** Information table view */
    var tblInfo:            UITableView             = UITableView()
    /** List of information data */
    var listInfo:           [ConfigurationModel]    = [ConfigurationModel]()
    /** Gas select button */
    var btnGasSelect:       CategoryButton          = CategoryButton()
    /** Delegate */
    public var delegate:    OrderPreviewDelegate?
    
    // MARK: Constants
    let TITLE_LABEL_HEIGH:      CGFloat             = GlobalConst.LABEL_H * 2
    let TABLE_VIEW_WIDTH_RATE:  CGFloat             = 4 / 5
    let TABLE_VIEW_HEIGHT_RATE: CGFloat             = 2 / 5
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
        self.frame = CGRect(x: x, y: y, width: w, height: h)
        
        // Title label
        lblTitle.frame = CGRect(
            x: 0, y: 0,
            width: w,
            height: TITLE_LABEL_HEIGH)
        lblTitle.text = DomainConst.CONTENT00516.uppercased()
        lblTitle.textColor = UIColor.white
        lblTitle.textAlignment = .center
        lblTitle.backgroundColor = GlobalConst.TEXT_COLOR_GRAY
        lblTitle.font = UIFont.boldSystemFont(ofSize: GlobalConst.PREVIEW_LABEL_FONT_SIZE)
        
        // Table view
        tblInfo.frame = CGRect(x: 0,
                               y: lblTitle.frame.maxY,
                               width: w * TABLE_VIEW_WIDTH_RATE,
                               height: h * TABLE_VIEW_HEIGHT_RATE)
        tblInfo.dataSource = self
        
        // Gas select button
        btnGasSelect = CategoryButton(
            frame: CGRect(x: tblInfo.frame.maxX,
                          y: lblTitle.frame.maxY,
                          width: w - tblInfo.frame.width,
                          height: h * TABLE_VIEW_HEIGHT_RATE),
            icon: G12F01S01VC._gasSelected.material_image,
            iconActive: G12F01S01VC._gasSelected.material_image,
            title: "Thay đổi",
            id: DomainConst.BLANK)
        btnGasSelect.addTarget(self, action: #selector(btnGasTapped), for: .touchUpInside)
        
        self.addSubview(lblTitle)
        self.addSubview(tblInfo)
        self.addSubview(btnGasSelect)
    }
    
    /**
     * Update view
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    public func update(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        CommonProcess.updateViewPos(
            view: self,
            x: x, y: y, w: w, h: h)
        CommonProcess.updateViewPos(
            view: lblTitle,
            x: 0, y: 0, w: w, h: TITLE_LABEL_HEIGH)
        CommonProcess.updateViewPos(
            view: tblInfo,
            x: 0, y: lblTitle.frame.maxY,
            w: w * TABLE_VIEW_WIDTH_RATE,
            h: h * TABLE_VIEW_HEIGHT_RATE)
    }
    
    public func setData() {
        btnGasSelect.imageView?.setImage(imgPath: G12F01S01VC._gasSelected.material_image)
        self.listInfo.removeAll()
        if !G12F01S01VC._gasSelected.isEmpty() {
            self.listInfo.append(ConfigurationModel(
                material: G12F01S01VC._gasSelected))
        }
        if !G12F01S01VC._promoteSelected.isEmpty() {
            self.listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_DISCOUNT,
                name: DomainConst.CONTENT00239,
                iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                value: DomainConst.SPLITER_TYPE1 + "20.000"))
        }
        self.listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_TOTAL_MONEY_ID,
            name: DomainConst.CONTENT00218,
            iconPath: DomainConst.MONEY_ICON_IMG_NAME,
            value: "310.000"))
        tblInfo.reloadData()
    }
    
    // MARK: Event handler
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
        return self.listInfo.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > listInfo.count {
            return UITableViewCell()
        }
        let data = listInfo[indexPath.row]
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = data.name
        cell.textLabel?.font = GlobalConst.BASE_FONT
        cell.detailTextLabel?.text = data.getValue()
        switch data.id {
        case DomainConst.ORDER_INFO_TOTAL_MONEY_ID:
            cell.detailTextLabel?.textColor = GlobalConst.MAIN_COLOR_GAS_24H
            cell.detailTextLabel?.font = GlobalConst.BASE_BOLD_FONT
        case DomainConst.ORDER_INFO_DISCOUNT:
            cell.detailTextLabel?.textColor = GlobalConst.MAIN_COLOR_GAS_24H
            cell.detailTextLabel?.font = GlobalConst.BASE_FONT
            break
        default:
            cell.detailTextLabel?.font = GlobalConst.BASE_FONT
            break
        }
        return cell
    }
}
