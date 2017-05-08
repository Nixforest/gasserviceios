//
//  G05F00S04VC.swift
//  project
//
//  Created by SPJ on 4/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F00S04VC: ChildViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: Properties
    /** Information table view */
    @IBOutlet weak var _tableView:  UITableView!
    /** Material table view */
    @IBOutlet weak var _tblViewGas: UITableView!
    /** Cylinder table view */
    @IBOutlet weak var _tblViewCylinder: UITableView!
    /** Bottom view */
    private var _bottomView:        UIView               = UIView()
    /** Id */
    public static var _id:          String               = DomainConst.BLANK
    /** Data */
    private var _data:              OrderVIPCreateRespModel = OrderVIPCreateRespModel()
    /** Parent view */
    private var _scrollView:        UIScrollView         = UIScrollView()
    /** Customer name label */
    private var _lblCustomerName:   UILabel              = UILabel()
    /** List of information data */
    private var _listInfo:          [ConfigurationModel] = [ConfigurationModel]()
    /** Segment control */
    private var _segment:           UISegmentedControl   = UISegmentedControl(
                                    items: [DomainConst.CONTENT00253, DomainConst.CONTENT00263])
    /** Order information view */
//    private var _viewOrderInfo:     UIView               = UIView()
    /** Order cylinder information view */
//    private var _viewOrderCylinderInfo: UIView           = UIView()
    /** List of material information */
    private var _listMaterial: [[(String, Int)]]         = [[(String, Int)]]()
    /** Material info header */
    private let _materialHeader:    [(String, Int)]      = [(DomainConst.CONTENT00333, G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.0),
                                                            (DomainConst.CONTENT00255, G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.1),
                                                            (DomainConst.CONTENT00334, G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.2)]
    /** Add material row data */
    private var _listMaterialOption: [ConfigurationModel] = [ConfigurationModel]()
    private let _addMaterialRow:    ConfigurationModel   = ConfigurationModel(
                                                            id: DomainConst.ORDER_INFO_MATERIAL_ADD_NEW,
                                                            name: DomainConst.CONTENT00341,
                                                            iconPath: DomainConst.ADD_ICON_IMG_NAME,
                                                            value: DomainConst.BLANK)
    /** List of cylinder information */
    private var _listCylinder: [[(String, Int)]]         = [[(String, Int)]]()
    /** Cylinder info header */
    private let _cylinderHeader:    [(String, Int)]      = [(DomainConst.CONTENT00335, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.0),
                                                            (DomainConst.CONTENT00336, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.1),
                                                            (DomainConst.CONTENT00337, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.2),
                                                            (DomainConst.CONTENT00338, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.3),
                                                            (DomainConst.CONTENT00339, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.4)]
    /** Add cylinder row data */
    private var _listCylinderOption: [ConfigurationModel] = [ConfigurationModel]()
    private let _addCylinderRow:    ConfigurationModel   = ConfigurationModel(
                                                            id: DomainConst.ORDER_INFO_MATERIAL_ADD_NEW,
                                                            name: DomainConst.CONTENT00325,
                                                            iconPath: DomainConst.ADD_ICON_IMG_NAME,
                                                            value: DomainConst.BLANK)
    /** Note textview */
    private var _tbxNote: UITextView                     = UITextView()
    /** Height of bottom view */
    private let bottomHeight:       CGFloat              = 2 * (GlobalConst.BUTTON_H + GlobalConst.MARGIN)
    /** Type when open a model VC */
    private let TYPE_NONE:              String = DomainConst.NUMBER_ZERO_VALUE
    private let TYPE_GAS:               String = "1"
    private let TYPE_OTHERMATERIAL:     String = "2"
    private let TYPE_CYLINDER:          String = "3"
    /** Current type when open model VC */
    private var _type:              String                  = DomainConst.NUMBER_ZERO_VALUE
    
    // MARK: Methods
    // MARK: Data prepare
    /**
     * Add material
     */
    private func addNewMaterial() {
        // Show alert CONTENT00253
        let alert = UIAlertController(title: DomainConst.CONTENT00341,
                                      message: DomainConst.CONTENT00314,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        let gas = UIAlertAction(title: DomainConst.CONTENT00333,
                                   style: .default, handler: {
                                    action in
                                    self.selectMaterial(type: self.TYPE_GAS)
        })
//        let otherMaterial = UIAlertAction(title: DomainConst.CONTENT00316,
//                                   style: .default, handler: {
//                                    action in
//                                    self.selectMaterial(type: self.TYPE_OTHERMATERIAL)
//        })
        alert.addAction(cancel)
        alert.addAction(gas)
        //alert.addAction(otherMaterial)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle select material
     * - parameter type: Type of material
     * - parameter data: Current selection
     */
    internal func selectMaterial(type: String, data: OrderDetailBean = OrderDetailBean.init()) {
        MaterialSelectViewController.setSelectedItem(item: data)
        self._type = type
        switch _type {
        case TYPE_GAS:                      // Gas
            MaterialSelectViewController.setMaterialData(data: BaseModel.shared.getListGasMaterialInfo())
            self.pushToView(name: G05F02S01VC.theClassName)
        case TYPE_CYLINDER:                 // Cylinder
            MaterialSelectViewController.setMaterialData(data: BaseModel.shared.getListCylinderInfo())
            self.pushToView(name: G05F02S01VC.theClassName)
        case TYPE_OTHERMATERIAL:            // The other material
            MaterialSelectViewController.setMaterialData(data: BaseModel.shared.getListOtherMaterialInfo())
            self.pushToView(name: G05F02S01VC.theClassName)
        default:
            break
        }
    }
    
    /**
     * Insert material at tail
     * - parameter material: Data to update
     */
    private func appendMaterialGas(material: OrderDetailBean) {
        var idx: Int = -1
        // Search in lists
        for i in 0..<_data.getRecord().info_gas.count {
            if material.material_id == _data.getRecord().info_gas[i].material_id {
                // Found
                idx = i
                break
            }
        }
        if idx == -1 {
            // Not found -> Append
            let orderItem = OrderVIPDetailBean(orderDetail: material)
            _data.getRecord().info_gas.append(orderItem)
            let materialValue: [(String, Int)] = [
                (orderItem.material_name,    G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.0),
                (orderItem.qty,              G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.1),
                (orderItem.qty_real,         G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.2)
            ]
            _listMaterial.append(materialValue)
            updateQtyMaterial(idx: _listMaterial.count - 1)
        } else {
            // Found -> Update
            updateQtyMaterial(idx: idx)
        }
        updateLayout()
    }
    
    /**
     * Insert material at tail
     * - parameter material: Data to update
     */
    private func appendMaterialCylinder(material: OrderDetailBean) {
        var idx: Int = -1
        // Search in lists
        for i in 0..<_data.getRecord().info_vo.count {
            if material.material_id == _data.getRecord().info_vo[i].material_id {
                // Found
                idx = i
                break
            }
        }
        if idx == -1 {
            // Not found -> Append
            let orderItem = OrderVIPDetailBean(orderDetail: material)
            var gasdu = DomainConst.BLANK
            // Check empty value
            if !orderItem.kg_has_gas.isEmpty && !orderItem.kg_empty.isEmpty {
                let fKgGas = (orderItem.kg_has_gas as NSString).floatValue
                let fKgEmpty = (orderItem.kg_empty as NSString).floatValue
                gasdu = String(fKgGas - fKgEmpty)
            }
            _data.getRecord().info_vo.append(orderItem)
            let cylinderValue: [(String, Int)] = [
                (orderItem.material_name, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.0),
                (orderItem.seri,          G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.1),
                (orderItem.kg_empty,      G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.2),
                (orderItem.kg_has_gas,    G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.3),
                (gasdu,                   G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.4)
            ]
            _listCylinder.append(cylinderValue)
            updateQtyCylinder(idx: _listCylinder.count - 1)
        } else {
            // Found -> Update
            updateQtyCylinder(idx: idx)
        }
        updateLayout()
    }
    
    /**
     * Delete material
     * - parameter idx: Index of selected row
     */
    private func deleteMaterial(idx: Int) {
        // Delete in data
        _data.getRecord().info_gas.remove(at: idx)
        // Delete in table data
        _listMaterial.remove(at: idx)
        let indexPath: IndexPath = IndexPath(item: idx, section: 1)
        // Delete in table
        _tblViewGas.deleteRows(at: [indexPath], with: .fade)
        updateLayout()
    }
    
    /**
     * Update quantity of material
     * - parameter idx: Index of selected row
     */
    private func updateQtyMaterial(idx: Int) {
        let material = _data.getRecord().info_gas[idx]
        var tbxValue: UITextField?
        
        // Create alert
        let alert = UIAlertController(title: material.material_name,
                                      message: DomainConst.CONTENT00344,
                                      preferredStyle: .alert)
        // Add textfield
        alert.addTextField(configurationHandler: { textField -> Void in
            tbxValue = textField
            tbxValue?.placeholder       = DomainConst.CONTENT00255
            tbxValue?.clearButtonMode   = .whileEditing
            tbxValue?.returnKeyType     = .done
            tbxValue?.keyboardType      = .numberPad
            tbxValue?.text              = material.qty_real
            tbxValue?.textAlignment     = .center
        })
        
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
            if let n = NumberFormatter().number(from: (tbxValue?.text)!) {
                // Update data
                self._data.getRecord().info_gas[idx].qty_real = String(describing: n)
                // Update in table data
                self._listMaterial[idx][2].0 = String(describing: n)
                // Update table
                self._tblViewGas.reloadRows(at: [IndexPath(item: idx, section: 1)], with: .automatic)
            } else {
                self.showAlert(message: DomainConst.CONTENT00251, okTitle: DomainConst.CONTENT00251,
                               okHandler: {_ in
                                self.updateQtyMaterial(idx: idx)
                },
                               cancelHandler: {_ in
                                
                })
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Update quantity of cylinder
     * - parameter idx: Index of selected row
     */
    private func updateQtyCylinder(idx: Int) {
        let cylinder = self._data.getRecord().info_vo[idx]
        var tbxSerial       : UITextField?
        var tbxCylinderOnly : UITextField?
        var tbxFull         : UITextField?
        // Create alert
        let alert = UIAlertController(title: cylinder.material_name,
                                      message: DomainConst.CONTENT00345,
                                      preferredStyle: .alert)
        alert.addTextField(configurationHandler: {
            textField -> Void in
            tbxSerial = textField
            tbxSerial?.placeholder       = DomainConst.CONTENT00109
            tbxSerial?.clearButtonMode   = .whileEditing
            tbxSerial?.returnKeyType     = .next
            tbxSerial?.keyboardType      = .numberPad
            tbxSerial?.text              = cylinder.seri
            tbxSerial?.textAlignment     = .center
        })
        alert.addTextField(configurationHandler: {
            textField -> Void in
            tbxCylinderOnly = textField
            tbxCylinderOnly?.placeholder       = DomainConst.CONTENT00346
            tbxCylinderOnly?.clearButtonMode   = .whileEditing
            tbxCylinderOnly?.returnKeyType     = .next
            tbxCylinderOnly?.keyboardType      = .decimalPad
            tbxCylinderOnly?.text              = cylinder.kg_empty
            tbxCylinderOnly?.textAlignment     = .center
        })
        alert.addTextField(configurationHandler: {
            textField -> Void in
            tbxFull = textField
            tbxFull?.placeholder       = DomainConst.CONTENT00347
            tbxFull?.clearButtonMode   = .whileEditing
            tbxFull?.returnKeyType     = .done
            tbxFull?.keyboardType      = .decimalPad
            tbxFull?.text              = cylinder.kg_has_gas
            tbxFull?.textAlignment     = .center
        })
        
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
            if !(tbxCylinderOnly?.text?.isEmpty)! && !(tbxFull?.text?.isEmpty)! {
                let cylinderOnly    = ((tbxCylinderOnly?.text)! as NSString).doubleValue
                let full            = ((tbxFull?.text)! as NSString).doubleValue
                // Update data
                self._data.getRecord().info_vo[idx].kg_empty    = String(describing: cylinderOnly)
                self._data.getRecord().info_vo[idx].seri        = (tbxSerial?.text)!
                self._data.getRecord().info_vo[idx].kg_has_gas  = String(describing: full)
                // Update in table data
                self._listCylinder[idx][1].0 = (tbxSerial?.text)!
                self._listCylinder[idx][2].0 = String(describing: cylinderOnly)
                self._listCylinder[idx][3].0 = String(describing: full)
                self._listCylinder[idx][4].0 = String(describing: (full - cylinderOnly))
                // Update table
                self._tblViewCylinder.reloadRows(at: [IndexPath(item: idx, section: 1)], with: .automatic)
            } else {
                self.showAlert(message: DomainConst.CONTENT00251, okTitle: DomainConst.CONTENT00251,
                               okHandler: {_ in
                                self.updateQtyCylinder(idx: idx)
                },
                               cancelHandler: {_ in
                                
                })
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Remove cylinder
     * - parameter at: Index
     */
    private func removeCylinder(at: Int) {
        // Delete in data
        _data.getRecord().info_vo.remove(at: at)
        // Delete in table data
        _listCylinder.remove(at: at)
        let indexPath: IndexPath = IndexPath(item: at, section: 1)
        // Delete in table
        _tblViewCylinder.deleteRows(at: [indexPath], with: .fade)
        updateLayout()
    }
    
    /**
     * Setup list of materials
     */
    func setupListMaterial(data: OrderVIPBean = OrderVIPBean()) {
        // List material
        _listMaterial.removeAll()
        // Update data for list gas info
        for item in data.info_gas {
            let materialValue: [(String, Int)] = [
                (item.material_name,    G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.0),
                (item.qty,              G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.1),
                (item.qty_real,         G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.2)
            ]
            _listMaterial.append(materialValue)
        }
        // Option
        if (_listMaterialOption.count == 0) && (data.allow_update == DomainConst.NUMBER_ONE_VALUE) {
            _listMaterialOption.append(_addMaterialRow)
        } else {
            _listMaterialOption.removeAll()
        }
        // Update table
        var offset: CGFloat = _segment.frame.maxY
//        _viewOrderInfo.frame = CGRect(x: 0, y: offset,
//                                      width: GlobalConst.SCREEN_WIDTH,
//                                      height: CGFloat(_listMaterial.count + _listMaterialOption.count + 1) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        _tblViewGas.translatesAutoresizingMaskIntoConstraints = true
        _tblViewGas.frame = CGRect(x: 0, y: offset,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: CGFloat(_listMaterial.count + _listMaterialOption.count + 1) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        _tblViewGas.allowsSelectionDuringEditing = false
        // List cylinder
        _listCylinder.removeAll()
        // Update data for list cylinder info
        for item in data.info_vo {
            var gasdu = DomainConst.BLANK
            // Check empty value
            if !item.kg_has_gas.isEmpty && !item.kg_empty.isEmpty {
                let fKgGas = (item.kg_has_gas as NSString).floatValue
                let fKgEmpty = (item.kg_empty as NSString).floatValue
                gasdu = String(fKgGas - fKgEmpty)
            }
            let cylinderValue: [(String, Int)] = [
                (item.material_name, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.0),
                (item.seri,          G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.1),
                (item.kg_empty,      G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.2),
                (item.kg_has_gas,    G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.3),
                (gasdu,              G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.4)
            ]
            self._listCylinder.append(cylinderValue)
        }
        // Option
        if (_listCylinderOption.count == 0) && (data.allow_update == DomainConst.NUMBER_ONE_VALUE) {
            _listCylinderOption.append(_addCylinderRow)
        } else {
            _listCylinderOption.removeAll()
        }
        // Update table
//        _viewOrderCylinderInfo.frame = CGRect(x: 0, y: offset,
//                                              width: GlobalConst.SCREEN_WIDTH,
//                                              height: CGFloat(_listCylinder.count + _listCylinderOption.count + 1) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        _tblViewCylinder.translatesAutoresizingMaskIntoConstraints = true
        _tblViewCylinder.frame = CGRect(x: 0, y: offset,
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: CGFloat(_listCylinder.count + _listCylinderOption.count + 1) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        _tblViewCylinder.allowsSelectionDuringEditing = false
        // Calculate height for put note textbox
        var height = _tblViewGas.frame.height
        if _listMaterial.count < _listCylinder.count {
            height = _tblViewCylinder.frame.height
        }
        offset = offset + height + GlobalConst.MARGIN
        
        // Note textfield
        if !data.note_customer.isEmpty {
            _tbxNote.isHidden = false
            _tbxNote.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                    y: offset,
                                    width: GlobalConst.EDITTEXT_W,
                                    height: GlobalConst.EDITTEXT_H * 5)
            offset += _tbxNote.frame.height + GlobalConst.MARGIN
        } else {
            _tbxNote.isHidden = true
        }
        
        // Scrollview content
        self._scrollView.contentSize = CGSize(
            width: GlobalConst.SCREEN_WIDTH,
            height: offset)
    }
    
    /**
     * Get status string from status number
     * - parameter status: Value of status number
     * - returns: Value of status string
     */
    private func getStatusString(status: String) -> String {
        var retVal = DomainConst.BLANK
        switch status {
        case DomainConst.ORDER_STATUS_NEW:
            retVal = DomainConst.CONTENT00329
            break
        case DomainConst.ORDER_STATUS_PROCESSING:
            retVal = DomainConst.CONTENT00328
            break
        case DomainConst.ORDER_STATUS_COMPLETE:
            retVal = DomainConst.CONTENT00330
            break
        case DomainConst.ORDER_STATUS_CANCEL:
            retVal = DomainConst.CONTENT00331
            break
        default:
            break
        }
        return retVal
    }
    
    /**
     * Setup list information data
     */
    func setupListInfo(data: OrderVIPBean = OrderVIPBean()) {
        self._listInfo.removeAll()
        // Order code
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_ID_ID,
                                            name: DomainConst.CONTENT00257,
                                            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
                                            value: DomainConst.ORDER_CODE_PREFIX + data.code_no))
        // Order status
        var status = DomainConst.CONTENT00328
        if !data.status_number.isEmpty {
            status = getStatusString(status: data.status_number)
        }
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_STATUS_ID,
                                            name: DomainConst.CONTENT00092,
                                            iconPath: DomainConst.ORDER_STATUS_ICON_IMG_NAME,
                                            value: status))
        // Created date
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CREATED_DATE_ID,
            name: DomainConst.CONTENT00096,
            iconPath: DomainConst.DATETIME_ICON_IMG_NAME,
            value: data.created_date))
        
        // Delivery date
        if data.status_number == DomainConst.ORDER_STATUS_COMPLETE {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_DELIVERY_DATE_ID,
                name: DomainConst.CONTENT00340,
                iconPath: DomainConst.DATETIME_ICON_IMG_NAME,
                value: data.date_delivery))
        }
        
        // Name of car
        if !data.name_car.isEmpty {
            _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_CAR_NUMBER_ID,
                                                name: DomainConst.CONTENT00258,
                                                iconPath: DomainConst.ORDER_CAR_NUMBER_ICON_IMG_NAME,
                                                value: data.name_car))
        }
        
        // Address
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_ADDRESS_ID,
            name: data.customer_address.normalizateString(),
            iconPath: DomainConst.ADDRESS_ICON_IMG_NAME,
            value: DomainConst.BLANK))
        
        // Contact
        if !data.customer_contact.isEmpty {
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CONTACT_ID,
            name: data.customer_contact,
            iconPath: DomainConst.PHONE_IMG_NAME,
            value: DomainConst.BLANK))
        }
        // Employee name
        if !BaseModel.shared.isNVGNUser() {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_EMPLOYEE_DELIVER_ID,
                name: DomainConst.CONTENT00233,
                iconPath: DomainConst.HUMAN_ICON_IMG_NAME,
                value: data.name_employee_maintain))
        }
        
        // Payment method
//        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_PAYMENT_METHOD_ID,
//                                            name: DomainConst.CONTENT00259,
//                                            iconPath: DomainConst.ORDER_PAYMENT_METHOD_ICON_IMG_NAME,
//                                            value: DomainConst.CONTENT00342))
        //++ BUG0062-SPJ (NguyenPT 20170421) Add new item gas price information
        if !data.info_price.isEmpty {
            _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_GAS_PRICE_ID,
                                                name: data.info_price + DomainConst.VIETNAMDONG,
                                                iconPath: DomainConst.MONEY_ICON_GREY_IMG_NAME,
                                                value: DomainConst.BLANK))
        }
        //-- BUG0062-SPJ (NguyenPT 20170421) Add new item gas price information
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_GAS_MONEY_ID,
                                            name: DomainConst.CONTENT00260,
                                            iconPath: DomainConst.MONEY_ICON_GREY_IMG_NAME,
                                            value: data.total_gas + DomainConst.VIETNAMDONG))
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_GAS_DU_ID,
                                            name: DomainConst.CONTENT00261,
                                            iconPath: DomainConst.MONEY_ICON_GREY_IMG_NAME,
                                            value: data.total_gas_du + DomainConst.VIETNAMDONG))
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_TOTAL_MONEY_ID,
                                            name: DomainConst.CONTENT00262,
                                            iconPath: DomainConst.MONEY_ICON_PAPER_IMG_NAME,
                                            value: data.grand_total + DomainConst.VIETNAMDONG))
        let frame = self._tableView.frame
        self._tableView.frame = CGRect(x: frame.origin.x,
                                       y: frame.origin.y,
                                       width: frame.width,
                                       height: CGFloat(_listInfo.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        self._segment.frame.origin = CGPoint(x: 0,
                                             y: self._tableView.frame.maxY)
    }
    
    // MARK: Event handler
    /**
     * Handle when segment change
     */
    internal func segmentChange(_ sender: AnyObject) {
        switch _segment.selectedSegmentIndex {
        case 0:
//            self._viewOrderInfo.isHidden         = false
//            self._viewOrderCylinderInfo.isHidden = true
            self._tblViewGas.isHidden       = false
            self._tblViewCylinder.isHidden  = true
            break
        case 1:
//            self._viewOrderInfo.isHidden         = true
//            self._viewOrderCylinderInfo.isHidden = false
            self._tblViewGas.isHidden       = true
            self._tblViewCylinder.isHidden  = false
            break
        default:
            break
        }
    }
    
    /**
     * Handle when finish request
     */
    override func setData(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        _data = OrderVIPCreateRespModel(jsonString: dataStr)
        setupListInfo(data: _data.getRecord())
        setupListMaterial(data: _data.getRecord())
        _lblCustomerName.text = _data.getRecord().customer_name
        _tableView.reloadData()
        _tblViewGas.reloadData()
        _tblViewCylinder.reloadData()
        _tbxNote.text = _data.getRecord().note_customer
        if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
            self._bottomView.isHidden = false
            
            _scrollView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: GlobalConst.SCREEN_WIDTH,
                                      height: GlobalConst.SCREEN_HEIGHT - bottomHeight)
        } else {
            self._bottomView.isHidden = true
            
            _scrollView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: GlobalConst.SCREEN_WIDTH,
                                      height: GlobalConst.SCREEN_HEIGHT)
        }
        updateLayout()
    }
    
    /**
     * Handle when tap on save button
     */
    internal func btnSaveTapped(_ sender: AnyObject) {
        var orderDetail = [String]()
        for item in self._data.getRecord().info_gas {
            if !item.material_id.isEmpty {
                orderDetail.append(item.createJsonDataForUpdateOrder())
            }
        }
        for item in self._data.getRecord().info_vo {
            if !item.material_id.isEmpty {
                orderDetail.append(item.createJsonDataForUpdateOrder())
            }
        }
        OrderVIPUpdateRequest.request(
            action: #selector(finishUpdateOrder(_:)),
            view: self,
            id: G05F00S04VC._id,
            note_employee: DomainConst.BLANK,
            orderDetail: orderDetail.joined(separator: DomainConst.SPLITER_TYPE2))
    }
    
    internal func finishUpdateOrder(_ notification: Notification) {
        setData(notification)
    }
    
    /**
     * Handle when tap on Action button
     */
    internal func btnActionHandler(_ sender: AnyObject) {
        showAlert(message: DomainConst.CONTENT00348,
                  okHandler: {
                    alert in
                    self.requestCompleteOrder()
        },
                  cancelHandler: {
                    alert in
                    // Do nothing
        })
    }
    
    private func requestCompleteOrder() {
        var orderDetail = [String]()
        for item in self._data.getRecord().info_gas {
            if !item.material_id.isEmpty {
                orderDetail.append(item.createJsonDataForUpdateOrder())
            }
        }
        for item in self._data.getRecord().info_vo {
            if !item.material_id.isEmpty {
                orderDetail.append(item.createJsonDataForUpdateOrder())
            }
        }
        OrderVipSetEventRequest.request(
            action: #selector(finishCompleteOrder(_:)),
            view: self,
            actionType: ActionTypeVIPCustomerEnum.EMPLOYEE_COMPLETE.rawValue,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: G05F00S04VC._id,
            note: DomainConst.BLANK,
            statusCancel: DomainConst.BLANK,
            orderDetail: orderDetail.joined(separator: DomainConst.SPLITER_TYPE2))
    }
    
    internal func finishCompleteOrder(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            OrderVIPViewRequest.request(action: #selector(setData(_:)),
                                        view: self,
                                        id: G05F00S04VC._id)
        }
    }
    
    /**
     * Handle when tap on Cancel button
     */
    internal func btnCancelHandler(_ sender: AnyObject) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00320,
                                      message: DomainConst.CONTENT00319,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
        for item in BaseModel.shared.getListCancelOrderVIPReasons() {
            let action = UIAlertAction(title: item.name,
                                       style: .default, handler: {
                                        action in
                                        self.handleCancelOrder(id: item.id)
            })
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle cancel order
     * - parameter id: Id of cancel order reason
     */
    internal func handleCancelOrder(id: String) {
        showAlert(message: String.init(format: DomainConst.CONTENT00349, BaseModel.shared.getOrderVIPCancelReasonById(id: id)),
                  okTitle: DomainConst.CONTENT00008,
                  cancelTitle: DomainConst.CONTENT00009,
                  okHandler: {
                    alert in
                    OrderVipSetEventRequest.request(
                        action: #selector(self.finishCancelOrder(_:)),
                        view: self,
                        actionType: ActionTypeVIPCustomerEnum.EMPLOYEE_DROP.rawValue,
                        lat: String(MapViewController._originPos.latitude),
                        long: String(MapViewController._originPos.longitude),
                        id: self._data.getRecord().id,
                        note: DomainConst.BLANK,
                        statusCancel: id)
        },
                  cancelHandler: {
                    alert in
        })
    }
    
    internal func finishCancelOrder(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            self.backButtonTapped(self)
        }
    }
    
    // MARK: Override from UIViewController
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle when open this view by notification
        if G05F00S04VC._id.isEmpty {
            G05F00S04VC._id = BaseModel.shared.sharedString
        }

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00232)
        
        setupListInfo()
        var offset: CGFloat = getTopHeight()
        
        _scrollView.translatesAutoresizingMaskIntoConstraints = true
        _scrollView.frame = CGRect(
            x: 0,
            y: 0,
            width: GlobalConst.SCREEN_WIDTH,
            height: GlobalConst.SCREEN_HEIGHT - bottomHeight)
        // Customer name label
        _lblCustomerName.frame = CGRect(x: 0, y: offset,
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: GlobalConst.LABEL_H * 3)
        _lblCustomerName.text = "Tên Khách HàngTên Khách HàngTên Khách HàngTên Khách Hàng"
        _lblCustomerName.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        _lblCustomerName.textColor = GlobalConst.BUTTON_COLOR_RED
        _lblCustomerName.textAlignment = .center
        _lblCustomerName.lineBreakMode = .byWordWrapping
        _lblCustomerName.numberOfLines = 0
        _scrollView.addSubview(_lblCustomerName)
        offset = offset + _lblCustomerName.frame.height
        
        // Information table view
        _tableView.translatesAutoresizingMaskIntoConstraints = true
        _tableView.frame = CGRect(x: 0,
                                  y: offset,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: CGFloat(_listInfo.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        offset = offset + _tableView.frame.height + GlobalConst.MARGIN
        self._scrollView.addSubview(_tableView)
        
        // Segment
        let font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _segment.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.BUTTON_H)
        _segment.setTitleTextAttributes([NSFontAttributeName: font],
                                        for: UIControlState())
        _segment.selectedSegmentIndex = 0
        _segment.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        _segment.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        _segment.tintColor = GlobalConst.BUTTON_COLOR_RED
        _segment.addTarget(self, action: #selector(segmentChange(_:)), for: .valueChanged)
        offset = offset + _segment.frame.height + GlobalConst.MARGIN
        self._scrollView.addSubview(_segment)
        
        // Order information view
//        _viewOrderInfo.addSubview(_tblViewGas)
//        _viewOrderCylinderInfo.addSubview(_tblViewCylinder)
        _tblViewGas.isHidden = false
        _tblViewCylinder.isHidden = true
        _scrollView.addSubview(_tblViewGas)
        _scrollView.addSubview(_tblViewCylinder)
        offset = offset + _tblViewGas.frame.height + GlobalConst.MARGIN
        
        // Note
        _tbxNote.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                y: offset,
                                width: GlobalConst.EDITTEXT_W,
                                height: GlobalConst.EDITTEXT_H * 5)
        _tbxNote.font               = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxNote.backgroundColor    = UIColor.white
        _tbxNote.autocorrectionType = .no
        _tbxNote.translatesAutoresizingMaskIntoConstraints = true
        _tbxNote.returnKeyType      = .done
        _tbxNote.tag                = 0
        _tbxNote.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        CommonProcess.setBorder(view: _tbxNote)
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        self._scrollView.addSubview(_tbxNote)
        
        // Scrollview content
        self._scrollView.contentSize = CGSize(
            width: GlobalConst.SCREEN_WIDTH,
            height: offset)
        // Bottom view
        _bottomView.frame = CGRect(x: 0, y: GlobalConst.SCREEN_HEIGHT - bottomHeight,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: bottomHeight)
        _bottomView.isHidden = true
        self.view.addSubview(_bottomView)
        createBottomView()
        self.view.addSubview(_scrollView)
        self.view.makeComponentsColor()
        
        // Request data from server
        OrderVIPViewRequest.request(action: #selector(setData(_:)),
                                    view: self,
                                    id: G05F00S04VC._id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switch _type {
        case TYPE_GAS:
            if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                // Add data
                appendMaterialGas(material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                _tblViewGas.reloadSections(IndexSet(1...2), with: .automatic)
            }
        case TYPE_CYLINDER:
            if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                // Add data
                appendMaterialCylinder(material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                _tblViewCylinder.reloadSections(IndexSet(1...2), with: .automatic)
            }
        default:
            break
        }
    }
    
    // MARK: Setup layout-control
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
        button.setTitle(title.uppercased(), for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.backgroundColor          = color
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
    
    private func updateLayout() {
        var offset: CGFloat = _segment.frame.maxY
        _tblViewGas.frame = CGRect(x: 0, y: offset,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: CGFloat(_listMaterial.count + _listMaterialOption.count + 1) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        _tblViewCylinder.frame = CGRect(x: 0, y: offset,
                                       width: GlobalConst.SCREEN_WIDTH,
                                       height: CGFloat(_listCylinder.count + _listCylinderOption.count + 1) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        var height = _tblViewGas.frame.height
        if _listMaterial.count < _listCylinder.count {
            height = _tblViewCylinder.frame.height
        }
        offset = offset + height + GlobalConst.MARGIN
        // Note textfield
        if !_data.getRecord().note_customer.isEmpty {
            _tbxNote.isHidden = false
            _tbxNote.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                    y: offset,
                                    width: GlobalConst.EDITTEXT_W,
                                    height: GlobalConst.EDITTEXT_H * 5)
            offset += _tbxNote.frame.height + GlobalConst.MARGIN
        } else {
            _tbxNote.isHidden = true
        }
        // Scrollview content
        self._scrollView.contentSize = CGSize(
            width: GlobalConst.SCREEN_WIDTH,
            height: offset)
    }
    
    /**
     * Create bottom view
     */
    private func createBottomView() {
        var botOffset: CGFloat = 0.0
        // Create save button
        let btnSave = UIButton()
        CommonProcess.createButtonLayout(
            btn: btnSave, x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2, y: botOffset,
            text: DomainConst.CONTENT00141.uppercased(), action: #selector(btnSaveTapped(_:)), target: self,
            img: DomainConst.RELOAD_IMG_NAME, tintedColor: UIColor.white)
        
        btnSave.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                               left: GlobalConst.MARGIN,
                                               bottom: GlobalConst.MARGIN,
                                               right: GlobalConst.MARGIN)
        botOffset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        _bottomView.addSubview(btnSave)
        
        // Button action
        let btnAction = UIButton()
        let btnCancel = UIButton()
        setupButton(button: btnAction, x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                    y: botOffset, title: DomainConst.CONTENT00311,
                    icon: DomainConst.CONFIRM_IMG_NAME, color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnActionHandler(_:)))
        setupButton(button: btnCancel, x: GlobalConst.SCREEN_WIDTH / 2,
                    y: botOffset, title: DomainConst.CONTENT00220,
                    icon: DomainConst.CANCEL_IMG_NAME, color: GlobalConst.BUTTON_COLOR_YELLOW,
                    action: #selector(btnCancelHandler(_:)))
        _bottomView.addSubview(btnAction)
        _bottomView.addSubview(btnCancel)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: UITableViewDataSource, UITableViewDelegate
    /**
     * Asks the data source to return the number of sections in the table view.
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case _tableView:
            return 1
        case _tblViewGas, _tblViewCylinder:
            return 3
        default:
            break
        }
        return 1
    }
    
    /**
     * Set height of row in table view
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalConst.CONFIGURATION_ITEM_HEIGHT
    }
    
    /**
     * Set number of row in table view
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case _tableView:
            return _listInfo.count
        case _tblViewGas:
            if section == 0 {
                return 1
            } else if (section == 2) {
                return _listMaterialOption.count
            } else {
                return _listMaterial.count
            }
        case _tblViewCylinder:
            if section == 0 {
                return 1
            } else if (section == 2) {
                return _listCylinderOption.count
            } else {
                return _listCylinder.count
            }
        default:
            break
        }
        return _listInfo.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var retCell = UITableViewCell()
        
        switch tableView {
        case _tableView:
            ConfigurationTableViewCell.PARENT_WIDTH = GlobalConst.SCREEN_WIDTH
            let cell = tableView.dequeueReusableCell(withIdentifier: ConfigurationTableViewCell.theClassName,
                                                     for: indexPath) as! ConfigurationTableViewCell
            
            cell.setData(data: _listInfo[indexPath.row])
            if _listInfo[indexPath.row].id == DomainConst.AGENT_TOTAL_MONEY_ID {
                cell.highlightValue()
            }
            
            retCell = cell
        case _tblViewGas:           // Gas material table
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailTableViewCell.theClassName,
                                                     for: indexPath) as! OrderDetailTableViewCell
            switch indexPath.section {
            case 0:             // Header
                cell.setup(data: _materialHeader, color: GlobalConst.BUTTON_COLOR_GRAY)
            case 1:             // Material
                cell.setup(data: _listMaterial[indexPath.row], color: UIColor.white, highlighColumn: [2])
            case 2:             // Add new
                if _listMaterialOption.count > indexPath.row  {
                    cell.setup(config: _listMaterialOption[indexPath.row])
                }
            default:
                break
            }
//            if indexPath.section == 0 {             // Header
//                cell.setup(data: _materialHeader, color: GlobalConst.BUTTON_COLOR_GRAY)
//            } else if (indexPath.section == 2) {    // Add new
//                if _listMaterialOption.count > indexPath.row  {
//                    cell.setup(config: _listMaterialOption[indexPath.row])
//                }
//            } else {                                // Material
//                cell.setup(data: _materialHeader, color: GlobalConst.BUTTON_COLOR_GRAY)
//            }
            retCell = cell
        case _tblViewCylinder:      // Cylinder material table
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailTableViewCell.theClassName,
                                                     for: indexPath) as! OrderDetailTableViewCell
//            if indexPath.section == 0 {             // Header
//                cell.setup(data: _cylinderHeader, color: GlobalConst.BUTTON_COLOR_GRAY)
//            } else if (indexPath.section == 2) {    // Add new
//                if _listCylinderOption.count > indexPath.row  {
//                    cell.setup(config: _listCylinderOption[indexPath.row])
//                }
//            } else {                                // Material
//                cell.setup(data: _listCylinder[indexPath.row], color: UIColor.white, highlighColumn: [1, 2, 3])
//            }
            switch indexPath.section {
            case 0:             // Header
                cell.setup(data: _cylinderHeader, color: GlobalConst.BUTTON_COLOR_GRAY)
            case 1:             // Material
                cell.setup(data: _listCylinder[indexPath.row], color: UIColor.white, highlighColumn: [1, 2, 3])
            case 2:             // Add new
                if _listCylinderOption.count > indexPath.row  {
                    cell.setup(config: _listCylinderOption[indexPath.row])
                }
            default:
                break
            }
            retCell = cell
        default:
            break
        }
        return retCell
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Check if current data allow update
        if self._data.getRecord().allow_update == DomainConst.NUMBER_ZERO_VALUE {
            return
        }
        switch tableView {
        case _tableView:
            if _listInfo[indexPath.row].id == DomainConst.EMPLOYEE_INFO_PHONE_ID {
                let phone = _listInfo[indexPath.row].name.normalizatePhoneString()
                self.makeACall(phone: phone)
            }
        case _tblViewGas:
            if indexPath.section == 1 {         // Select material
                //updateMaterial(idx: indexPath.row)
                updateQtyMaterial(idx: indexPath.row)
            } else if indexPath.section == 2 {  // Select add material
                if _listMaterialOption[indexPath.row].id == DomainConst.ORDER_INFO_MATERIAL_ADD_NEW {
                    addNewMaterial()
                }
            }
            break
        case _tblViewCylinder:
            if indexPath.section == 1 {
                updateQtyCylinder(idx: indexPath.row)
            } else if indexPath.section == 2 {
                self.selectMaterial(type: self.TYPE_CYLINDER)
            }
            break
        default:
            break
        }
    }
    
    /**
     * Asks the data source to verify that the given row is editable.
     */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch tableView {
        case _tableView:
            break
        case _tblViewGas:
            if indexPath.section == 1 {
                return true
            }
            break
        case _tblViewCylinder:
            if indexPath.section == 1 {
                return true
            }
            break
        default:
            break
        }
        return false
    }
    
    /**
     * Asks the data source to commit the insertion or deletion of a specified row in the receiver.
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch tableView {
        case _tableView:
            break
        case _tblViewGas:
            if indexPath.section == 1 {                
                switch editingStyle {
                case .delete:
                    self.showAlert(message: DomainConst.CONTENT00317,
                                   okHandler: {
                                    (alert: UIAlertAction!) in
                                    self.deleteMaterial(idx: indexPath.row)
                    },
                                   cancelHandler: {
                                    (alert: UIAlertAction!) in
                    })
                default:
                    break
                }
            }
            break
        case _tblViewCylinder:
            if indexPath.section == 1 {
                switch editingStyle {
                case .delete:
                    self.showAlert(message: DomainConst.CONTENT00317,
                                   okHandler: {
                                    (alert: UIAlertAction!) in
                                    self.removeCylinder(at: indexPath.row)
                    },
                                   cancelHandler: {
                                    (alert: UIAlertAction!) in
                    })
                default:
                    break
                }
            }
            break
        default:
            break
        }
    }
}
