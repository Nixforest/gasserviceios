//
//  G05F00S04VC.swift
//  project
//
//  Created by SPJ on 4/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F00S04VC: ChildViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
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
    internal var _data:              OrderVIPCreateRespModel = OrderVIPCreateRespModel()
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
                                                            iconPath: DomainConst.ADD_MATERIAL_ICON_IMG_NAME,
                                                            value: DomainConst.BLANK)
    /** List of cylinder information */
    private var _listCylinder: [[(String, Int)]]         = [[(String, Int)]]()
    /** Cylinder info header */
    private let _cylinderHeader:    [(String, Int)]      = [(DomainConst.CONTENT00335, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.0),
                                                            //(DomainConst.CONTENT00336, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.1),
                                                            (DomainConst.CONTENT00415, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.1),
                                                            (DomainConst.CONTENT00466, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.2),
                                                            (DomainConst.CONTENT00337, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.3),
                                                            (DomainConst.CONTENT00338, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.4),
                                                            (DomainConst.CONTENT00339, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.5)]
    /** Add cylinder row data */
    private var _listCylinderOption: [ConfigurationModel] = [ConfigurationModel]()
    private let _addCylinderRow:    ConfigurationModel   = ConfigurationModel(
                                                            id: DomainConst.ORDER_INFO_MATERIAL_ADD_NEW,
                                                            name: DomainConst.CONTENT00325,
                                                            iconPath: DomainConst.ADD_ICON_IMG_NAME,
                                                            value: DomainConst.BLANK)
    //++ BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
    private let _clearAllCylinderRow: ConfigurationModel   = ConfigurationModel(
                                                            id: DomainConst.ORDER_INFO_MATERIAL_CLEAR_ALL_CYLINDER,
                                                            name: DomainConst.CONTENT00464,
                                                            iconPath: DomainConst.CLEAR_ALL_ICON_IMG_NAME,
                                                            value: DomainConst.BLANK)
    //-- BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
    //++ BUG0136-SPJ (NguyenPT 20170727) Handle sum all cylinders
    private let _sumCylinder:       ConfigurationModel   = ConfigurationModel(
                                                            id: DomainConst.ORDER_INFO_MATERIAL_SUM_ALL_CYLINDER,
        name: DomainConst.CONTENT00218,
        iconPath: DomainConst.SUM_ICON_IMG_NAME,
        value: DomainConst.BLANK)
    //-- BUG0136-SPJ (NguyenPT 20170727) Handle sum all cylinders
    //++ BUG0154-SPJ (NguyenPT 20170909) Add image in VIP order detail when update
    /** List image add to this order */
    internal var _images:            [UIImage]           = [UIImage]()
    //-- BUG0154-SPJ (NguyenPT 20170909) Add image in VIP order detail when update
    
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
    
    //++ BUG0104-SPJ (NguyenPT 20170606) Handle action buttons
    /** Save button */
    private var btnSave:            UIButton                = UIButton()
    /** Action button */
    private var btnAction:          UIButton                = UIButton()
    /** Cancel button */
    private var btnCancel:          UIButton                = UIButton()
    //++ BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
//    /** Create ticket button */
//    private var _btnTicket:         UIButton                = UIButton()
    //-- BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
    /** Other actions button */
    private var _btnOtherAction:    UIButton                = UIButton()
    /** Image collection view */
    private var cltImg:             UICollectionView!       = nil
    //-- BUG0104-SPJ (NguyenPT 20170606) Handle action buttons
    
    // MARK: Methods
    // MARK: Data prepare
    //++ BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
    /**
     * Clear all cylinders
     */
    private func clearAllCylinders() {
        showAlert(message: DomainConst.CONTENT00465,
                  okHandler: {
                    alert in
                    self._data.getRecord().info_vo.removeAll()
                    self._listCylinder.removeAll()
                    self._tblViewCylinder.reloadData()
                    self.updateLayout()
        },
                  cancelHandler: {
                    alert in
        })
    }
    //-- BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
    
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
        let otherMaterial = UIAlertAction(title: DomainConst.CONTENT00316,
                                   style: .default, handler: {
                                    action in
                                    self.selectMaterial(type: self.TYPE_OTHERMATERIAL)
        })
        alert.addAction(cancel)
        alert.addAction(gas)
        alert.addAction(otherMaterial)
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
            //++ BUG0151-SPJ (NguyenPT 20170819) Handle favourite when select material
//            MaterialSelectViewController.setMaterialData(data: BaseModel.shared.getListGasMaterialInfo())
            MaterialSelectViewController.setMaterialDataFromFavourite(key: DomainConst.KEY_SETTING_FAVOURITE_GAS_LOGIN)
            //-- BUG0151-SPJ (NguyenPT 20170819) Handle favourite when select material
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
    //++ BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
    //private func appendMaterialCylinder(material: OrderDetailBean) {
    private func appendMaterialCylinder(material: OrderDetailBean, isUpdateQty: Bool = true) {
    //-- BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
        //++ BUG0083-SPJ (NguyenPT 20170515) Add Cylinder in VIP Order bug
//        var idx: Int = -1
//        // Search in lists
//        for i in 0..<_data.getRecord().info_vo.count {
//            if material.material_id == _data.getRecord().info_vo[i].material_id {
//                // Found
//                idx = i
//                break
//            }
//        }
//        if idx == -1 {
//            // Not found -> Append
//            let orderItem = OrderVIPDetailBean(orderDetail: material)
//            var gasdu = DomainConst.BLANK
//            // Check empty value
//            if !orderItem.kg_has_gas.isEmpty && !orderItem.kg_empty.isEmpty {
//                let fKgGas = (orderItem.kg_has_gas as NSString).floatValue
//                let fKgEmpty = (orderItem.kg_empty as NSString).floatValue
//                gasdu = String(fKgGas - fKgEmpty)
//            }
//            _data.getRecord().info_vo.append(orderItem)
//            let cylinderValue: [(String, Int)] = [
//                (orderItem.material_name, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.0),
//                (orderItem.seri,          G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.1),
//                (orderItem.kg_empty,      G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.2),
//                (orderItem.kg_has_gas,    G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.3),
//                (gasdu,                   G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.4)
//            ]
//            _listCylinder.append(cylinderValue)
//            updateQtyCylinder(idx: _listCylinder.count - 1)
//        } else {
//            // Found -> Update
//            updateQtyCylinder(idx: idx)
//        }
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
            (orderItem.qty,           G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.1),
            (orderItem.seri,          G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.2),
            (orderItem.kg_empty,      G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.3),
            (orderItem.kg_has_gas,    G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.4),
            (gasdu,                   G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.5)
        ]
        _listCylinder.append(cylinderValue)
        //++ BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
        //updateQtyCylinder(idx: _listCylinder.count - 1)
        if isUpdateQty {
            updateQtyCylinder(idx: _listCylinder.count - 1)
        } else {
            _tblViewCylinder.reloadData()
        }
        //-- BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
        updateLayout()
        //-- BUG0083-SPJ (NguyenPT 20170515) Add Cylinder in VIP Order bug
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
        //++ BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
        if self._data.getRecord().info_vo.count <= idx {
            return
        }
        //-- BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
        let cylinder = self._data.getRecord().info_vo[idx]
        var tbxSerial       : UITextField?
        var tbxCylinderOnly : UITextField?
        var tbxFull         : UITextField?
        var tbxQty          : UITextField?
        
        //++ BUG0113-SPJ (NguyenPT 20170622) Bug when input "," inside number field
        let df = NumberFormatter()
        df.locale = Locale.current
        let decimal = df.decimalSeparator ?? DomainConst.SPLITER_TYPE4
        //-- BUG0113-SPJ (NguyenPT 20170622) Bug when input "," inside number field
        
        // Create alert
        let alert = UIAlertController(title: cylinder.material_name,
                                      message: DomainConst.CONTENT00345,
                                      preferredStyle: .alert)
        //++ BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
        alert.addTextField(configurationHandler: {
            textField -> Void in
            tbxQty = textField
            tbxQty?.placeholder       = DomainConst.CONTENT00255
            tbxQty?.clearButtonMode   = .whileEditing
            tbxQty?.returnKeyType     = .done
            tbxQty?.keyboardType      = .numberPad
            tbxQty?.text              = cylinder.qty
            tbxQty?.textAlignment     = .center
        })
        //-- BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
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
            tbxCylinderOnly?.text              = cylinder.kg_empty.replacingOccurrences(
                of: DomainConst.SPLITER_TYPE4,
                with: decimal)
            tbxCylinderOnly?.textAlignment     = .center
        })
        alert.addTextField(configurationHandler: {
            textField -> Void in
            tbxFull = textField
            tbxFull?.placeholder       = DomainConst.CONTENT00347
            tbxFull?.clearButtonMode   = .whileEditing
            tbxFull?.returnKeyType     = .done
            tbxFull?.keyboardType      = .decimalPad
            tbxFull?.text              = cylinder.kg_has_gas.replacingOccurrences(
                of: DomainConst.SPLITER_TYPE4,
                with: decimal)
            tbxFull?.textAlignment     = .center
        })
        
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
            //++ BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
//            if !(tbxCylinderOnly?.text?.isEmpty)! && !(tbxFull?.text?.isEmpty)! && !(tbxQty?.text?.isEmpty)! {
//                //++ BUG0113-SPJ (NguyenPT 20170622) Bug when input "," inside number field
//                let cylinderOnlyStr = (tbxCylinderOnly?.text)!.replacingOccurrences(of: decimal, with: DomainConst.SPLITER_TYPE4)
//                let fullStr = (tbxFull?.text)!.replacingOccurrences(of: decimal, with: DomainConst.SPLITER_TYPE4)
//                
//                //let cylinderOnly    = ((tbxCylinderOnly?.text)! as NSString).doubleValue
//                //let full            = ((tbxFull?.text)! as NSString).doubleValue
//                let cylinderOnly    = (cylinderOnlyStr as NSString).doubleValue
//                let full            = (fullStr as NSString).doubleValue
//                //-- BUG0113-SPJ (NguyenPT 20170622) Bug when input "," inside number field
//                
//                // Update data
//                self._data.getRecord().info_vo[idx].kg_empty    = String(describing: cylinderOnly)
//                self._data.getRecord().info_vo[idx].seri        = (tbxSerial?.text)!
//                self._data.getRecord().info_vo[idx].qty         = (tbxQty?.text)!
//                self._data.getRecord().info_vo[idx].qty_real    = (tbxQty?.text)!
//                self._data.getRecord().info_vo[idx].kg_has_gas  = String(describing: full)
//                // Update in table data
//                self._listCylinder[idx][1].0 = (tbxSerial?.text)!
//                self._listCylinder[idx][2].0 = (tbxQty?.text)!
//                self._listCylinder[idx][3].0 = String(describing: cylinderOnly)
//                self._listCylinder[idx][4].0 = String(describing: full)
//                self._listCylinder[idx][5].0 = String(describing: (full - cylinderOnly))
//                // Update table
//                self._tblViewCylinder.reloadRows(at: [IndexPath(item: idx, section: 1)], with: .automatic)
//            } else {
//                self.showAlert(message: DomainConst.CONTENT00251, okTitle: DomainConst.CONTENT00251,
//                               okHandler: {_ in
//                                self.updateQtyCylinder(idx: idx)
//                },
//                               cancelHandler: {_ in
//                                
//                })
//            }
            if let seri = tbxSerial?.text, let qty = tbxQty?.text,
                let cylinderMass = tbxCylinderOnly?.text,
                let fullMass = tbxFull?.text {
                // Small cylinder
                if self._data.getRecord().info_vo[idx].isCylinderType1() {
                    self.updateDataLayoutCylinder(idx: idx, value: (seri, qty, cylinderMass, fullMass))
                } else if self._data.getRecord().info_vo[idx].isCylinderType2() {   // Big cylinders
                    // Quantity is "1"
                    if qty == DomainConst.NUMBER_ONE_VALUE {
                        self.updateDataLayoutCylinder(idx: idx, value: (seri, qty, cylinderMass, fullMass))
                    } else if !qty.isEmpty {    // Quantity is greater than "1"
                        self.updateDataLayoutCylinder(idx: idx,
                                                      value: (seri, DomainConst.NUMBER_ONE_VALUE,
                                                              cylinderMass, fullMass))
                        if let n = NumberFormatter().number(from: qty) {
                            for _ in 0..<(n.intValue - 1) {
                                self.appendMaterialCylinder(material: self._data.getRecord().info_vo[idx], isUpdateQty: false)
                            }
                        }
                    }
                }
            }
            //-- BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    //++ BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
    /**
     * Update data layout for list cylinder
     * - parameter idx: Index
     * - parameter value: Value to update (Serial, Quantity, Cylinder mass, Full mass)
     */
    private func updateDataLayoutCylinder(idx: Int, value: (String, String, String, String)) {
        if _data.getRecord().info_vo.count <= idx {
            return
        }
        let df = NumberFormatter()
        df.locale = Locale.current
        let decimal = df.decimalSeparator ?? DomainConst.SPLITER_TYPE4
        let isDataValid = !value.1.isEmpty && !value.2.isEmpty && !value.3.isEmpty
        // Cylinder 4kg, 6kg, 12kg
        if self._data.getRecord().info_vo[idx].isCylinderType1() && !value.1.isEmpty {
            // Serial
            self._data.getRecord().info_vo[idx].seri        = value.0
            self._listCylinder[idx][2].0                    = value.0
            // Quantity
            self._data.getRecord().info_vo[idx].qty         = value.1
            self._data.getRecord().info_vo[idx].qty_real    = value.1
            self._listCylinder[idx][1].0                    = value.1
            var cylinderOnly = 0.0
            var full = 0.0
            // Cylinder mass
            if !value.2.isEmpty {
                let cylinderOnlyStr = value.2.replacingOccurrences(of: decimal, with: DomainConst.SPLITER_TYPE4)
                cylinderOnly        = (cylinderOnlyStr as NSString).doubleValue
                self._data.getRecord().info_vo[idx].kg_empty    = String(describing: cylinderOnly)
                self._listCylinder[idx][3].0                    = String(describing: cylinderOnly)
            }
            // Full mass
            if !value.3.isEmpty {
                let fullStr = value.3.replacingOccurrences(of: decimal, with: DomainConst.SPLITER_TYPE4)
                full    = (fullStr as NSString).doubleValue
                self._data.getRecord().info_vo[idx].kg_has_gas  = String(describing: full)
                self._listCylinder[idx][4].0                    = String(describing: full)
            }
            if !value.2.isEmpty && !value.3.isEmpty {
                self._listCylinder[idx][5].0 = String(describing: (full - cylinderOnly))
            }
            // Update table
            self._tblViewCylinder.reloadRows(at: [IndexPath(item: idx, section: 1)], with: .automatic)
        } else if self._data.getRecord().info_vo[idx].isCylinderType2() && isDataValid {
            let cylinderOnlyStr = value.2.replacingOccurrences(of: decimal, with: DomainConst.SPLITER_TYPE4)
            let fullStr = value.3.replacingOccurrences(of: decimal, with: DomainConst.SPLITER_TYPE4)
            let cylinderOnly    = (cylinderOnlyStr as NSString).doubleValue
            let full            = (fullStr as NSString).doubleValue
            // Update to array
            self.updateDataArrayCylinder(idx: idx, value: (value.0, value.1,
                                                           cylinderOnly, full))
            // Update table
            self._tblViewCylinder.reloadRows(at: [IndexPath(item: idx, section: 1)], with: .automatic)
        } else {
            self.showAlert(message: DomainConst.CONTENT00047, okTitle: DomainConst.CONTENT00251,
                           okHandler: {_ in
                            self.updateQtyCylinder(idx: idx)
            },
                           cancelHandler: {_ in
                            
            })
        }
    }
    
    /**
     * Update data to array cylinder
     * - parameter idx: Index
     * - parameter value: Value to update (Serial, Quantity, Cylinder mass, Full mass)
     */
    private func updateDataArrayCylinder(idx: Int, value: (String, String, Double, Double)) {
        if _data.getRecord().info_vo.count <= idx {
            return
        }
        // Update data
        self._data.getRecord().info_vo[idx].kg_empty    = String(describing: value.2)
        self._data.getRecord().info_vo[idx].seri        = value.0
        self._data.getRecord().info_vo[idx].qty         = value.1
        self._data.getRecord().info_vo[idx].qty_real    = value.1
        self._data.getRecord().info_vo[idx].kg_has_gas  = String(describing: value.3)
        // Update in table data
        self._listCylinder[idx][2].0 = value.0
        self._listCylinder[idx][1].0 = value.1
        self._listCylinder[idx][3].0 = String(describing: value.2)
        self._listCylinder[idx][4].0 = String(describing: value.3)
        self._listCylinder[idx][5].0 = String(describing: (value.3 - value.2))
    }
    //-- BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
    
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
        //++ BUG0106-SPJ (NguyenPT 20170610) Fix bug Add item vanish
//        if (_listMaterialOption.count == 0) && (data.allow_update == DomainConst.NUMBER_ONE_VALUE) {
//            _listMaterialOption.append(_addMaterialRow)
//        } else {
//            _listMaterialOption.removeAll()
//        }
        if data.allow_update == DomainConst.NUMBER_ONE_VALUE {  // Allow update
            if _listMaterialOption.count == 0 {                 // Not add "Add item" yet
                _listMaterialOption.append(_addMaterialRow)     // Add "Add item"
            }
        } else {  // Not allow update
            _listMaterialOption.removeAll()
        }
        //-- BUG0106-SPJ (NguyenPT 20170610) Fix bug Add item vanish
        
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
                (item.qty,           G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.1),
                (item.seri,          G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.2),
                (item.kg_empty,      G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.3),
                (item.kg_has_gas,    G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.4),
                (gasdu,              G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.5)
            ]
            self._listCylinder.append(cylinderValue)
        }
        // Option
        //++ BUG0106-SPJ (NguyenPT 20170610) Fix bug Add item vanish
//        if (_listCylinderOption.count == 0) && (data.allow_update == DomainConst.NUMBER_ONE_VALUE) {
//            _listCylinderOption.append(_addCylinderRow)
//        } else {
//            _listCylinderOption.removeAll()
//        }
        if data.allow_update == DomainConst.NUMBER_ONE_VALUE {  // Allow update
            if _listCylinderOption.count == 0 {                 // Not add "Add item" yet
                _listCylinderOption.append(_addMaterialRow)     // Add "Add item"
                //++ BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
                _listCylinderOption.append(_clearAllCylinderRow)
                //-- BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
                _listCylinderOption.append(_sumCylinder)
            }
        } else {  // Not allow update
            _listCylinderOption.removeAll()
        }
        //-- BUG0106-SPJ (NguyenPT 20170610) Fix bug Add item vanish
        
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
        //++ BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
//        if _listMaterial.count < _listCylinder.count {
        if _tblViewCylinder.frame.height > height {
        //-- BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
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
        var name = data.name_employee_maintain
        if name.isEmpty {
            name = data.name_driver
        }
        //if !BaseModel.shared.isNVGNUser() {
        if !name.isEmpty {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_EMPLOYEE_DELIVER_ID,
                name: DomainConst.CONTENT00233,
                iconPath: DomainConst.HUMAN_ICON_IMG_NAME,
                //value: data.name_employee_maintain))
                value: name))
        }
        
        //++ BUG0114-SPJ (NguyenPT 20170624) Add note field
        if !data.note_employee.isBlank {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_NOTE_ID, name: data.note_employee,
                iconPath: DomainConst.PROBLEM_TYPE_IMG_NAME, value: DomainConst.BLANK))
        }
        //-- BUG0114-SPJ (NguyenPT 20170624) Add note field
        
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
        if data.total_gas_du != DomainConst.NUMBER_ZERO_VALUE {
            _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_GAS_DU_ID,
                                                name: DomainConst.CONTENT00261,
                                                iconPath: DomainConst.MONEY_ICON_GREY_IMG_NAME,
                                                value: DomainConst.SPLITER_TYPE1 + data.total_gas_du + DomainConst.VIETNAMDONG))
        }
        //++ BUG0137-SPJ (NguyenPT 20170727) Show payback field
        if data.show_pay_back != 0 {
            _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_PAY_BACK,
                                                name: DomainConst.CONTENT00467,
                                                iconPath: DomainConst.MONEY_ICON_GREY_IMG_NAME,
                                                value: data.pay_back + DomainConst.SPACE_STR + DomainConst.GAS_MASS_UNIT))
        }
        //-- BUG0137-SPJ (NguyenPT 20170727) Show payback field
        
        //++ BUG0139-SPJ (NguyenPT 20170805) Show discount field
        if data.show_discount != 0 {
            _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_DISCOUNT,
                                                name: DomainConst.CONTENT00468,
                                                iconPath: DomainConst.MONEY_ICON_GREY_IMG_NAME,
                                                value: data.discount.currencyInputFormatting().replacingOccurrences(
                                                    of: DomainConst.SPLITER_TYPE4,
                                                    with: DomainConst.SPLITER_TYPE2) + DomainConst.VIETNAMDONG))
        }
        //-- BUG0139-SPJ (NguyenPT 20170805) Show discount field
        
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_TOTAL_MONEY_ID,
                                            name: DomainConst.CONTENT00262,
                                            iconPath: DomainConst.MONEY_ICON_PAPER_IMG_NAME,
                                            value: data.grand_total + DomainConst.VIETNAMDONG))
        let frame = self._tableView.frame
        self._tableView.frame = CGRect(x: frame.origin.x,
                                       y: frame.origin.y,
                                       width: frame.width,
                                       height: CGFloat(_listInfo.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        self._segment.frame.origin = CGPoint(x: GlobalConst.MARGIN_CELL_X,
                                             y: self._tableView.frame.maxY)
    }
    
    //++ BUG0136-SPJ (NguyenPT 20170727) Handle sum all cylinders
    /**
     * Show sum all cylinders
     */
    private func getSumCylinder() {
        // Count number
        var sumCount: [(Int, Double)] = [
            (0, 0.0),
            (0, 0.0),
            (0, 0.0),
            (0, 0.0)
        ]
        // Summary strings
        var sum: [String] = [String]()
        // Summary all
        var sumAll: (Int, Double) = (0, 0.0)
        // Loop through all info_vo array
        for item in _data.getRecord().info_vo {
            if let n = Int(item.qty) {
                // Increase summary all number
                sumAll.0 += n
                // Calculate gas remain
                var gasRemain: Double = 0.0
                if !item.kg_empty.isEmpty && !item.kg_has_gas.isEmpty {
                    gasRemain = (item.kg_has_gas as NSString).doubleValue - (item.kg_empty as NSString).doubleValue
                }
                sumAll.1 += gasRemain
                // Check material type id
                switch item.materials_type_id {
                case DomainConst.CYLINDER_TYPE_ID_6KG:      // Cylinder 6Kg
                    sumCount[0].0 += n
                    sumCount[0].1 += gasRemain
                    break
                case DomainConst.CYLINDER_TYPE_ID_12KG:     // Cylinder 12Kg
                    sumCount[1].0 += n
                    sumCount[1].1 += gasRemain
                    break
                case DomainConst.CYLINDER_TYPE_ID_45KG:     // Cylinder 45Kg
                    sumCount[2].0 += n
                    sumCount[2].1 += gasRemain
                    break
                case DomainConst.CYLINDER_TYPE_ID_50KG:     // Cylinder 50Kg
                    sumCount[3].0 += n
                    sumCount[3].1 += gasRemain
                    break
                default:
                    break
                }
            }
        }
        // Get name of type cylinder
        for i in 0..<sumCount.count {
            var name = DomainConst.BLANK
            switch i {
            case 0:
                name = "6Kg"
                break
            case 1:
                name = "12Kg"
                break
            case 2:
                name = "45Kg"
                break
            case 3:
                name = "50Kg"
                break
            default:
                break
            }
            let item = sumCount[i]
            if item.0 != 0 {
                var str = String.init(format: "%@ %@: %d vỏ",
                                      DomainConst.CONTENT00337,
                                      name,
                                      item.0)
                if !item.1.isZero {
                    str = String.init(format: "%@, gas dư: %.01f kg", str, item.1)
                }
                sum.append(str)
            }
        }
        
        // Sum all
        var str = String.init(format: "%@: %d vỏ",
                              DomainConst.CONTENT00218,
                              sumAll.0)
        if !sumAll.1.isZero {
            str = String.init(format: "%@, gas dư: %.01f kg", str, sumAll.1)
        }
        sum.append(str)
        showAlert(message: sum.joined(separator: "\n"))
    }
    //-- BUG0136-SPJ (NguyenPT 20170727) Handle sum all cylinders
    //++ BUG0137-SPJ (NguyenPT 20170727) Show payback field
    /**
     * Update value of payback
     */
    private func updatePaybackValue() {
        var tbxValue: UITextField?
        let df = NumberFormatter()
        df.locale = Locale.current
        let decimal = df.decimalSeparator ?? DomainConst.SPLITER_TYPE4
        // Create alert
        let alert = UIAlertController(title: DomainConst.CONTENT00467,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .alert)
        // Add textfield
        alert.addTextField(configurationHandler: { textField -> Void in
            tbxValue = textField
            tbxValue?.placeholder       = DomainConst.CONTENT00467
            tbxValue?.clearButtonMode   = .whileEditing
            tbxValue?.returnKeyType     = .done
            tbxValue?.keyboardType      = .decimalPad
            tbxValue?.text              = self._data.getRecord().pay_back.replacingOccurrences(
                of: DomainConst.SPLITER_TYPE4,
                with: decimal)
            tbxValue?.autocapitalizationType = .allCharacters
            tbxValue?.textAlignment     = .center
        })
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
            if let value = tbxValue?.text {
                // Update data
                self._data.getRecord().pay_back = value.replacingOccurrences(
                    of: decimal,
                    with: DomainConst.SPLITER_TYPE4)
                // Loop for all the first list info
                for i in 0..<self._listInfo.count {
                    // Get current item
                    let item = self._listInfo[i]
                    // Check if payback item
                    if item.id == DomainConst.ORDER_INFO_PAY_BACK {
                        // Update value
                        self._listInfo[i].updateData(id: item.id,
                                                        name: item.name,
                                                        iconPath: item.getIconPath(),
                                                        value: value.replacingOccurrences(
                                                            of: decimal,
                                                            with: DomainConst.SPLITER_TYPE4) + DomainConst.SPACE_STR + DomainConst.GAS_MASS_UNIT)
                        // Stop loop statement
                        break
                    }
                }
                // Reload tableview
                self._tableView.reloadData()
            } else {
                self.showAlert(message: DomainConst.CONTENT00047, okTitle: DomainConst.CONTENT00251,
                               okHandler: {_ in
                                self.updatePaybackValue()
                },
                               cancelHandler: {_ in
                                
                })
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    //-- BUG0137-SPJ (NguyenPT 20170727) Show payback field
    //++ BUG0139-SPJ (NguyenPT 20170805) Show discount field
    /**
     * Update value of discount
     */
    private func updateDiscountValue() {
        var tbxValue: UITextField?
        // Create alert
        let alert = UIAlertController(title: DomainConst.CONTENT00468,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .alert)
        // Add textfield
        alert.addTextField(configurationHandler: { textField -> Void in
            tbxValue = textField
            tbxValue?.placeholder       = DomainConst.CONTENT00468
            tbxValue?.clearButtonMode   = .whileEditing
            tbxValue?.returnKeyType     = .done
            tbxValue?.keyboardType      = .numberPad
            tbxValue?.text              = self._data.getRecord().discount
            tbxValue?.autocapitalizationType = .allCharacters
            tbxValue?.textAlignment     = .center
        })
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
            if let value = tbxValue?.text {
                // Update data
                self._data.getRecord().discount = value
                // Loop for all the first list info
                for i in 0..<self._listInfo.count {
                    // Get current item
                    let item = self._listInfo[i]
                    // Check if discount item
                    if item.id == DomainConst.ORDER_INFO_DISCOUNT {
                        // Update value
                        self._listInfo[i].updateData(id: item.id,
                                                     name: item.name,
                                                     iconPath: item.getIconPath(),
                                                     value: value.currencyInputFormatting().replacingOccurrences(
                                                        of: DomainConst.SPLITER_TYPE4,
                                                        with: DomainConst.SPLITER_TYPE2) + DomainConst.VIETNAMDONG)
                        // Stop loop statement
                        break
                    }
                }
                // Reload tableview
                self._tableView.reloadData()
            } else {
                self.showAlert(message: DomainConst.CONTENT00047, okTitle: DomainConst.CONTENT00251,
                               okHandler: {_ in
                                self.updateDiscountValue()
                },
                               cancelHandler: {_ in
                                
                })
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    //-- BUG0139-SPJ (NguyenPT 20170805) Show discount field
    
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
        if _data.isSuccess() {
            setupListInfo(data: _data.getRecord())
            setupListMaterial(data: _data.getRecord())
            _lblCustomerName.text = _data.getRecord().customer_name
            _tableView.reloadData()
            _tblViewGas.reloadData()
            _tblViewCylinder.reloadData()
            _tbxNote.text = _data.getRecord().note_customer
            if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
                //++ BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
                //self._bottomView.isHidden = false
                showHideBottomView(isShow: true)
//                _scrollView.frame = CGRect(x: 0,
//                                           y: 0,
//                                           width: GlobalConst.SCREEN_WIDTH,
//                                           height: GlobalConst.SCREEN_HEIGHT - bottomHeight)
                //-- BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
            } else {
                //++ BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
                //self._bottomView.isHidden = true
                showHideBottomView(isShow: false)
                
//                _scrollView.frame = CGRect(x: 0,
//                                           y: 0,
//                                           width: GlobalConst.SCREEN_WIDTH,
//                                           height: GlobalConst.SCREEN_HEIGHT)
                //-- BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
            }
            _scrollView.frame = CGRect(x: 0,
                                       y: 0,
                                       width: GlobalConst.SCREEN_WIDTH,
                                       height: GlobalConst.SCREEN_HEIGHT - bottomHeight)
            //++ BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
//            btnSave.isEnabled = (_data.getRecord().show_button_save == 1)
//            btnAction.isEnabled = (_data.getRecord().show_button_complete == 1)
//            btnCancel.isEnabled = (_data.getRecord().show_button_cancel == 1)
            //-- BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
            _tbxNote.isEditable = (_data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE)
            updateLayout()
        }
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: _data.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    
    //++ BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
    /**
     * Handle show/hide bottom view
     * - parameter isShow: True is show bottom view, False is hide
     */
    private func showHideBottomView(isShow: Bool) {
        if isShow {
            btnSave.isEnabled   = (_data.getRecord().show_button_save == 1)
            btnAction.isEnabled = (_data.getRecord().show_button_complete == 1)
            btnCancel.isEnabled = (_data.getRecord().show_button_cancel == 1)
        } else {
            btnCancel.isEnabled = false
            btnSave.isEnabled   = false
            btnAction.isEnabled = false
            //_btnOtherAction.isEnabled     = false
        }
    }
    //-- BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
    
    /**
     * Handle when tap on save button
     */
    internal func btnOtherActionTapped(_ sender: AnyObject) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00436,
                                      message: DomainConst.CONTENT00437,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
        if _data.getRecord().show_thu_tien == 1 {
            let actionMoneyCollect = UIAlertAction(title: DomainConst.CONTENT00318,
                                                   style: .default, handler: {
                                                    action in
                                                    self.handleSelectPayMoney()
            })
            alert.addAction(actionMoneyCollect)
        }
        if _data.getRecord().show_chi_gas_du == 1 {
            let action = UIAlertAction(title: DomainConst.CONTENT00440,
                                                   style: .default, handler: {
                                                    action in
                                                    self.handleSelectPayGasRemain()
            })
            alert.addAction(action)
        }
        if _data.getRecord().show_button_debit == 1 {
            let action = UIAlertAction(title: DomainConst.CONTENT00438,
                                                   style: .default, handler: {
                                                    action in
                                                    self.handleSelectSetDebit()
            })
            alert.addAction(action)
        }
        //++ BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
        let ticket = UIAlertAction(title: DomainConst.CONTENT00402,
                                   style: .default, handler: {
                                    action in
                                    self.btnCreateTicketTapped(self)
        })
        alert.addAction(ticket)
        //-- BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
        //++ BUG0154-SPJ (NguyenPT 20170909) Add image in VIP order detail when update
        let addImageCamera = UIAlertAction(title: DomainConst.CONTENT00470,
                                     style: .default, handler: {
                                        action in
                                        self.addImageFromCamera()
        })
        alert.addAction(addImageCamera)
        let addImageLib = UIAlertAction(title: DomainConst.CONTENT00471,
                                     style: .default, handler: {
                                        action in
                                        self.addImageFromLibrary()
        })
        alert.addAction(addImageLib)
        //++ BUG0213-SPJ (KhoiVT 20170731) Gasservice - Stock Real View
        let seri_confirmation = UIAlertAction(title: DomainConst.CONTENT00587,
                                   style: .default, handler: {
                                    action in
                                    self.btnSeriConfirmationTapped(self)
        })
        alert.addAction(seri_confirmation)
        //-- BUG0213-SPJ (KhoiVT 20170731) Gasservice - Stock Real View
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = sender as? UIButton
            presenter.sourceRect = sender.bounds
        }
        //-- BUG0154-SPJ (NguyenPT 20170909) Add image in VIP order detail when update
        self.present(alert, animated: true, completion: nil)
    }
    
    //++ BUG0154-SPJ (NguyenPT 20170909) Add image in VIP order detail when update
    /**
     * Handle add image from camera
     */
    internal func addImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.camera
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated: true, completion: {
                self.cltImg.reloadData()
            })
        }
    }
    
    /**
     * Handle add image from library
     */
    internal func addImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated: true, completion: {
                self.cltImg.reloadData()
            })
        }
    }
    //-- BUG0154-SPJ (NguyenPT 20170909) Add image in VIP order detail when update
    
    /**
     * Handle select set debit action
     */
    internal func handleSelectSetDebit() {
        G05F04VC._id = _data.getRecord().id
        G05F04VC._orderInfo = String.init(
            format: "Đơn hàng Bò/Mối - %@ - %@ - %@\n",
            _data.getRecord().created_date,
            _data.getRecord().code_no,
            _data.getRecord().customer_name)
        self.pushToView(name: G05F04VC.theClassName)
    }
    
    /**
     * Handle select pay gas remain action
     */
    internal func handlePayGasRemain() {
        G09F01S02._target = CustomerBean(id: _data.getRecord().customer_id,
                                         name: _data.getRecord().customer_name,
                                         phone: _data.getRecord().customer_contact,
                                         address: _data.getRecord().customer_address)
        G09F01VC._mode      = DomainConst.NUMBER_ZERO_VALUE
        G09F01VC._typeId = "24"
        G09F01VC._appOrderId = _data.getRecord().id
        G09F01S03._selectedValue = _data.getRecord().total_gas_du
        G09F01S04._selectedValue = _data.getRecord().total_gas_du_kg + "Kg"
        self.pushToView(name: G09F01VC.theClassName)
    }
    
    /**
     * Handle select pay money action
     */
    internal func handlePayMoney() {
        G09F01S02._target = CustomerBean(id: _data.getRecord().customer_id,
                                         name: _data.getRecord().customer_name,
                                         phone: _data.getRecord().customer_contact,
                                         address: _data.getRecord().customer_address)
        G09F01VC._mode      = DomainConst.NUMBER_ZERO_VALUE
        G09F01VC._typeId = "43"
        G09F01VC._appOrderId = _data.getRecord().id
        G09F01S03._selectedValue = _data.getRecord().grand_total
        self.pushToView(name: G09F01VC.theClassName)
    }
    
    /**
     * Handle when tap on create button
     */
    internal func handleSelectPayMoney() {
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheDataPayMoney(_:)),
                                     view: self)
        } else {
            // Start create ticket
            handlePayMoney()
        }
    }
    
    /**
     * Handle when finish request cache data
     */
    internal func finishRequestCacheDataPayMoney(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            // Start create ticket
            handlePayMoney()
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle when tap on create button
     */
    internal func handleSelectPayGasRemain() {
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheDataPayGasRemain(_:)),
                                     view: self)
        } else {
            // Start create ticket
            handlePayGasRemain()
        }
    }
    
    /**
     * Handle when finish request cache data
     */
    internal func finishRequestCacheDataPayGasRemain(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            // Start create ticket
            handlePayGasRemain()
        } else {
            showAlert(message: model.message)
        }
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
            orderDetail: orderDetail.joined(separator: DomainConst.SPLITER_TYPE2),
            //++ BUG0137-SPJ (NguyenPT 20170727) Show payback field
            payback: _data.getRecord().pay_back,
            //-- BUG0137-SPJ (NguyenPT 20170727) Show payback field
            //++ BUG0139-SPJ (NguyenPT 20170805) Show discount field
            discount: _data.getRecord().discount,
            //-- BUG0139-SPJ (NguyenPT 20170805) Show discount field
            images: _images)
    }
    
    internal func finishUpdateOrder(_ notification: Notification) {
        self._images.removeAll()
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
            orderDetail: orderDetail.joined(separator: DomainConst.SPLITER_TYPE2),
            //++ BUG0201-SPJ (NguyenPT 20180609) Upload image
            images: self._images)
            //-- BUG0201-SPJ (NguyenPT 20180609) Upload image
    }
    
    internal func finishCompleteOrder(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            //++ BUG0201-SPJ (NguyenPT 20180609) Upload image
            self._images.removeAll()
            //-- BUG0201-SPJ (NguyenPT 20180609) Upload image
            OrderVIPViewRequest.request(action: #selector(setData(_:)),
                                        view: self,
                                        id: G05F00S04VC._id)
        }
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
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
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    
    //++ BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
    /**
     * Handle when tap on create button
     */
    internal func btnCreateTicketTapped(_ sender: AnyObject) {
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheData(_:)),
                                     view: self)
        } else {
            // Start create ticket
            createTicket()
        }
    }
    
    /**
     * Handle when finish request cache data
     */
    
    /**
     * Handle when tap on Seri Confirmation button
     */
    internal func btnSeriConfirmationTapped(_ sender: AnyObject) {
        BaseModel.shared.sharedString = G05F00S04VC._id
        self.pushToView(name: G18F00S03VC.theClassName)
    }
    
    /**
     * Handle when tap on Seri Confirmation button
     */
    
    internal func finishRequestCacheData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            // Start create ticket
            createTicket()
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Start create ticket
     */
    private func createTicket() {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00433,
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
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Open create ticket view controller
     * - parameter id: Id of ticket handler
     */
    internal func handleCreateTicket(id: String) {
        G11F01VC._handlerId = id
        G11F01S01._selectedValue.content = String.init(
            format: "Đơn hàng Bò/Mối - %@ - %@ - %@\n",
            _data.getRecord().created_date,
            _data.getRecord().code_no,
            _data.getRecord().customer_name)
        self.pushToView(name: G11F01VC.theClassName)
        
    }
    //-- BUG0104-SPJ (NguyenPT 20170606) Handle action buttons
    
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
//        var offset: CGFloat = getTopHeight()
        var offset: CGFloat = 0.0
        
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
        _segment.frame = CGRect(x: GlobalConst.MARGIN_CELL_X, y: offset,
                                width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN_CELL_X,
                                height: GlobalConst.BUTTON_H)
        _segment.setTitleTextAttributes([NSFontAttributeName: font],
                                        for: UIControlState())
        _segment.selectedSegmentIndex = 0
//        _segment.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
//        _segment.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        _segment.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
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
        CommonProcess.setBorder(view: _tbxNote, radius: GlobalConst.BUTTON_CORNER_RADIUS)
         _tbxNote.delegate = self
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        self._scrollView.addSubview(_tbxNote)
        
        // Create layout for image collection control
        let layout          = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize     = CGSize(width: GlobalConst.ACCOUNT_AVATAR_W / 2,
                                     height: GlobalConst.ACCOUNT_AVATAR_W / 2)
        
        // Create image collection controll
        self.cltImg         = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        let frameworkBundle = Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)
        self.cltImg.register(UINib(nibName: DomainConst.COLLECTION_IMAGE_VIEW_CELL,
                                   bundle: frameworkBundle),
                             forCellWithReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL)
        self.cltImg.alwaysBounceHorizontal = true
        self.cltImg.delegate    = self
        self.cltImg.dataSource  = self
        self.cltImg.bounces = true
        
        // Set scroll direction
        if let layout = self.cltImg.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        offset += GlobalConst.ACCOUNT_AVATAR_W / 2
        // Add image collection to main view
        _scrollView.addSubview(self.cltImg)
        
        // Scrollview content
        self._scrollView.contentSize = CGSize(
            width: GlobalConst.SCREEN_WIDTH,
            height: offset)
        // Bottom view
        _bottomView.frame = CGRect(x: 0, y: GlobalConst.SCREEN_HEIGHT - bottomHeight,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: bottomHeight)
        //++ BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
        //_bottomView.isHidden = true
        //-- BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
        self.view.addSubview(_bottomView)
        createBottomView()
        self.view.addSubview(_scrollView)
        self.view.makeComponentsColor()
        
        // Request data from server
        OrderVIPViewRequest.request(action: #selector(setData(_:)),
                                    view: self,
                                    id: G05F00S04VC._id)
    }
    
    
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        OrderVIPViewRequest.request(action: action,
                                    view: self,
                                    id: G05F00S04VC._id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switch _type {
        case TYPE_GAS, TYPE_OTHERMATERIAL:
            if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                // Add data
                appendMaterialGas(material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                _tblViewGas.reloadSections(IndexSet(1...2), with: .automatic)
            }
            _type = DomainConst.NUMBER_ZERO_VALUE
        case TYPE_CYLINDER:
            if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                // Add data
                appendMaterialCylinder(material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                _tblViewCylinder.reloadSections(IndexSet(1...2), with: .automatic)
            }
            _type = DomainConst.NUMBER_ZERO_VALUE
        default:
//            requestData()
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
                             icon: String, color: UIColor, action: Selector, width: CGFloat = GlobalConst.BUTTON_W / 2) {
        button.frame = CGRect(x: x,
                              y: y,
                              //width: GlobalConst.BUTTON_W / 2,
                              width: width,
                              height: GlobalConst.BUTTON_H)
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        //++ BUG0103-SPJ (NguyenPT 20170606) Update new flag
//        button.backgroundColor          = color
        button.clipsToBounds            = true
        button.setBackgroundColor(color: color, forState: .normal)
        button.setBackgroundColor(color: GlobalConst.BUTTON_COLOR_GRAY, forState: .disabled)
        //-- BUG0103-SPJ (NguyenPT 20170606) Update new flag
        button.titleLabel?.font         = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        button.layer.cornerRadius       = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        button.imageView?.contentMode   = .scaleAspectFit
        let img = ImageManager.getImage(named: icon)
        let tintedImg = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        button.tintColor = UIColor.white
        button.setImage(tintedImg, for: UIControlState())
        //button.setImage(ImageManager.getImage(named: icon), for: UIControlState())
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
        //++ BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
//        if _listMaterial.count < _listCylinder.count {
        if _tblViewCylinder.frame.height > height {
        //-- BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
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
        if cltImg != nil {
            cltImg.translatesAutoresizingMaskIntoConstraints = true
            cltImg.frame = CGRect(x: GlobalConst.MARGIN_CELL_X * 2,
                                  y: offset,
                                  width: self.view.frame.width - 4 * GlobalConst.MARGIN_CELL_X,
                                  height: GlobalConst.ACCOUNT_AVATAR_H / 2)
            cltImg.backgroundColor = UIColor.white
            cltImg.contentSize = CGSize(
                width: GlobalConst.ACCOUNT_AVATAR_H / 2 * (CGFloat)(_data.record.images.count),
                height: GlobalConst.ACCOUNT_AVATAR_H / 2)
            
            cltImg.reloadData()
        }
        offset += GlobalConst.ACCOUNT_AVATAR_H / 2 + GlobalConst.MARGIN
        
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
        // Other action button
        setupButton(button: _btnOtherAction, x: GlobalConst.SCREEN_WIDTH / 2,
                    y: botOffset, title: "Tác vụ khác",
                    icon: DomainConst.OTHER_TASK_ICON_IMG_NAME, color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnOtherActionTapped(_:)),
                    width: GlobalConst.BUTTON_W / 2)
        _bottomView.addSubview(_btnOtherAction)
        //botOffset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        // Create save button
        //++ BUG0104-SPJ (NguyenPT 20170606) Handle action buttons
//        let btnSave = UIButton()
//        CommonProcess.createButtonLayout(
//            btn: btnSave, x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2, y: botOffset,
//            text: DomainConst.CONTENT00141.uppercased(), action: #selector(btnSaveTapped(_:)), target: self,
//            img: DomainConst.RELOAD_IMG_NAME, tintedColor: UIColor.white)
//        
//        btnSave.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
//                                               left: GlobalConst.MARGIN,
//                                               bottom: GlobalConst.MARGIN,
//                                               right: GlobalConst.MARGIN)
        setupButton(button: btnSave, x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                    y: botOffset, title: DomainConst.CONTENT00086,
                    icon: DomainConst.SAVE_ICON_IMG_NAME, color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnSaveTapped(_:)))
        //++ BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
//        setupButton(button: _btnTicket, x:  GlobalConst.SCREEN_WIDTH / 2,
//                    y: botOffset, title: DomainConst.CONTENT00402,
//                    icon: DomainConst.TICKET_ICON_IMG_NAME,
//                    color: GlobalConst.BUTTON_COLOR_YELLOW,
//                    action: #selector(btnCreateTicketTapped(_:)))
//        _bottomView.addSubview(_btnTicket)
        //-- BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
        //-- BUG0104-SPJ (NguyenPT 20170606) Handle action buttons
        botOffset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        _bottomView.addSubview(btnSave)
        
        
        // Button action
        //++ BUG0104-SPJ (NguyenPT 20170606) Handle action buttons
//        let btnAction = UIButton()
//        let btnCancel = UIButton()
        //-- BUG0104-SPJ (NguyenPT 20170606) Handle action buttons
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
            //++ BUG0139-SPJ (NguyenPT 20170805) Show discount field
//            if _listInfo[indexPath.row].id == DomainConst.ORDER_INFO_PAY_BACK {
//                cell.highlightValue()
//            }
            switch _listInfo[indexPath.row].id {
            case DomainConst.ORDER_INFO_PAY_BACK, DomainConst.ORDER_INFO_DISCOUNT:
                cell.highlightValue()
            default:
                break
            }
            //-- BUG0139-SPJ (NguyenPT 20170805) Show discount field
            
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
                cell.setup(data: _listCylinder[indexPath.row], color: UIColor.white, highlighColumn: [1, 2, 3, 4])
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
//            if _listInfo[indexPath.row].id == DomainConst.EMPLOYEE_INFO_PHONE_ID {
//                let phone = _listInfo[indexPath.row].name.normalizatePhoneString()
//                self.makeACall(phone: phone)
//            }
//            //++ BUG0114-SPJ (NguyenPT 20170624) Add note field
//            if _listInfo[indexPath.row].id == DomainConst.ORDER_INFO_NOTE_ID {
//                self.showAlert(message: _listInfo[indexPath.row].name)
//            }
//            //-- BUG0114-SPJ (NguyenPT 20170624) Add note field
//            //++ BUG0137-SPJ (NguyenPT 20170727) Show payback field
//            if _listInfo[indexPath.row].id == DomainConst.ORDER_INFO_PAY_BACK {
//                self.updatePaybackValue()
//            }
//            //-- BUG0137-SPJ (NguyenPT 20170727) Show payback field            
            switch _listInfo[indexPath.row].id {
            case DomainConst.EMPLOYEE_INFO_PHONE_ID:    // Handle make a call
                let phone = _listInfo[indexPath.row].name.normalizatePhoneString()
                self.makeACall(phone: phone)
            case DomainConst.ORDER_INFO_NOTE_ID:        // Handle show note
                self.showAlert(message: _listInfo[indexPath.row].name)
            case DomainConst.ORDER_INFO_PAY_BACK:       // Handle update payback value
                self.updatePaybackValue()
            case DomainConst.ORDER_INFO_DISCOUNT:       // Handle update discount value
                self.updateDiscountValue()
            default:
                break
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
                //++ BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
//                self.selectMaterial(type: self.TYPE_CYLINDER)
                if _listCylinderOption[indexPath.row].id == DomainConst.ORDER_INFO_MATERIAL_CLEAR_ALL_CYLINDER {
                    clearAllCylinders()
                } else if _listCylinderOption[indexPath.row].id == DomainConst.ORDER_INFO_MATERIAL_ADD_NEW {
                    self.selectMaterial(type: self.TYPE_CYLINDER)
                }
                //-- BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
                //++ BUG0136-SPJ (NguyenPT 20170727) Handle sum all cylinders
                else if _listCylinderOption[indexPath.row].id == DomainConst.ORDER_INFO_MATERIAL_SUM_ALL_CYLINDER {
                    self.getSumCylinder()
                }
                //-- BUG0136-SPJ (NguyenPT 20170727) Handle sum all cylinders
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
    
    //++ BUG0089-SPJ (NguyenPT 20170515) Fix bug move up view when focus text view
    // MARK: UITableViewDelegate
    /**
     * Add a done button when keyboard show
     */
    func addDoneButtonOnKeyboard() {
        // Create toolbar
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(hideKeyboard(_:)))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        // Add toolbar to keyboard
        self._tbxNote.inputAccessoryView = doneToolbar
        self.keyboardTopY -= doneToolbar.frame.height
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        // Hide keyboard
        self.view.endEditing(true)
        // Move back view to previous location
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        })
        // Turn off flag
        isKeyboardShow = false
    }
    
    /**
     * Handle when focus edittext
     * - parameter textField: Textfield will be focusing
     */
    internal func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        isKeyboardShow = true
        // Making A toolbar
        if textView == self._tbxNote {
            addDoneButtonOnKeyboard()
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    /**
     * Hide keyboard
     * - parameter sender: Gesture
     */
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        hideKeyboard()
    }
    
    /**
     * Handle move textview when keyboard overloading
     */
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        if _tbxNote.isFirstResponder {
            // Get bottom offset of scrollview
            let bottomOffset = CGPoint(x: 0.0,
                                       y: _scrollView.contentSize.height - _scrollView.bounds.size.height)
            // Move content of scrollview to bottom
            _scrollView.setContentOffset(bottomOffset, animated: true)
            // Get delta of bottom of note textview and top of keyboard
            let delta = _scrollView.frame.maxY - self.keyboardTopY
            if delta > 0 {      // Need to move up view
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: -delta, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    //++ BUG0089-SPJ (NguyenPT 20170515) Fix bug move up view when focus text view
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
}

// MARK: UIImagePickerControllerDelegate
extension G05F00S04VC: UIImagePickerControllerDelegate {
    /**
     * Tells the delegate that the user picked a still image or movie.
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self._images.append(image)            
        }
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: UINavigationControllerDelegate
extension G05F00S04VC: UINavigationControllerDelegate {
    // Implement methods
}

// MARK: UICollectionViewDataSource
extension G05F00S04VC: UICollectionViewDataSource {
    /**
     * Asks your data source object for the number of items in the specified section.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return _data.record.images.count
        return _data.record.images.count + self._images.count
    }
    
    /**
     * Asks your data source object for the cell that corresponds to the specified item in the collection view.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get current cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL, for: indexPath) as! CollectionImageViewCell
        
        cell.imageView.frame  = CGRect(x: 0,  y: 0,  width: GlobalConst.ACCOUNT_AVATAR_H / 2, height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        if indexPath.row < _data.record.images.count {
            cell.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].thumb, contentMode: cell.imageView.contentMode)
        } else {
            cell.imageView.image = self._images[indexPath.row - _data.record.images.count]
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension G05F00S04VC: UICollectionViewDelegate {
    /**
     * Tells the delegate that the item at the specified index path was selected.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL, for: indexPath) as! CollectionImageViewCell
        /** push to zoomIMGVC */
        zoomIMGViewController.imgPicked = cell.imageView.image
        if indexPath.row < _data.record.images.count {
            zoomIMGViewController.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].large, contentMode: cell.imageView.contentMode)
        } else {
            zoomIMGViewController.setPickedImg(img: self._images[indexPath.row - _data.record.images.count])
        }
        // Move to rating view
        self.pushToView(name: DomainConst.ZOOM_IMAGE_VIEW_CTRL)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        print("Perform")
    }
}
