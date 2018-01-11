//
//  G14F01S03.swift
//  project
//
//  Created by SPJ on 12/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G14F01S03: StepContent {
    // MARK: Properties
    /** Table view */
    var _tblMaterial:           UITableView             = UITableView()
    /** List data */
    public static var _data:    [OrderVIPDetailBean]    = [OrderVIPDetailBean]()
    /** List of material information */
    var _listMaterial:          [[(String, Int)]]       = [[(String, Int)]]()
    /** Material header */
    var _materialHeader:        [(String, Int)]         = [
        (DomainConst.CONTENT00411, G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.0),
        (DomainConst.CONTENT00466, G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.1),
        (DomainConst.CONTENT00337, G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.2),
        (DomainConst.CONTENT00338, G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.3),
        (DomainConst.CONTENT00339, G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.4)
    ]
    private var _height:        CGFloat                 = 0.0    
    /** Type when open a model VC */
    public static let TYPE_NONE:              String = DomainConst.NUMBER_ZERO_VALUE
    public static let TYPE_GAS:               String = "1"
    public static let TYPE_OTHERMATERIAL:     String = "2"
    public static let TYPE_CYLINDER:          String = "3"
    /** Current type when open model VC */
    public static var _type:                  String = DomainConst.NUMBER_ZERO_VALUE
    
    /**
     * Default initializer.
     */
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        _height = h
        var offset: CGFloat = 0
        let contentView     = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        // --- Create content view ---
        // Table view material
        _tblMaterial.frame = CGRect(x: 0, y: offset,
                                    width: GlobalConst.SCREEN_WIDTH,
                                    height: h - self.getTitleHeight())
        _tblMaterial.register(OrderDetailTableViewCell.self, forCellReuseIdentifier: "cell")
        _tblMaterial.delegate = self
        _tblMaterial.dataSource = self
        updateTableView()
        
        contentView.addSubview(_tblMaterial)
        offset += _tblMaterial.frame.height
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00367,
                   contentHeight: offset,
                   width: w, height: h)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Update table after data was changed
     */
    internal func updateTableView() {
        _listMaterial.removeAll()
        // Header
        _listMaterial.append(_materialHeader)
        
        // Order detail
        for item in G14F01S03._data {
            var gasdu = DomainConst.BLANK
            // Check empty value
            if !item.kg_has_gas.isEmpty && !item.kg_empty.isEmpty {
                let fKgGas = (item.kg_has_gas as NSString).floatValue
                let fKgEmpty = (item.kg_empty as NSString).floatValue
                gasdu = String(fKgGas - fKgEmpty)
            }
            let materialValue: [(String, Int)] = [
                (item.material_name,    G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.0),
                (item.seri,             G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.1),
                (item.kg_empty,         G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.2),
                (item.kg_has_gas,       G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.3),
                (gasdu,                 G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.4)
            ]
            _listMaterial.append(materialValue)
        }
        
        // Total
        let total: [(String, Int)] = [
            (DomainConst.CONTENT00341,    G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.0),
            (DomainConst.BLANK,         G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.1),
            (DomainConst.BLANK,         G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.2),
            (DomainConst.BLANK,         G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.3),
            (DomainConst.BLANK,         G14Const.TABLE_COLUMN_WEIGHT_GAS_INFO.4)
        ]
        _listMaterial.append(total)
        // Reload table view
        _tblMaterial.reloadData()
        
        // Fix material table view height
        var tblHeight = CGFloat(_listMaterial.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT
        if tblHeight > _height - getTitleHeight() {
            tblHeight = _height - getTitleHeight()
        }
        _tblMaterial.frame = CGRect(x: 0, y: 0,
                                    width: GlobalConst.SCREEN_WIDTH,
                                    height: tblHeight)
    }
    
    /**
     * Add material
     */
    internal func addNewMaterial() {
        // Show alert CONTENT00253
        let alert = UIAlertController(title: DomainConst.CONTENT00341,
                                      message: DomainConst.CONTENT00314,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
//        let gas = UIAlertAction(title: DomainConst.CONTENT00333,
//                                style: .default, handler: {
//                                    action in
//                                    self.selectMaterial(type: G14F01S03.TYPE_GAS)
//        })
        let cylinder = UIAlertAction(title: DomainConst.CONTENT00315,
                                     style: .default, handler: {
                                        action in
                                        self.selectMaterial(type: G14F01S03.TYPE_CYLINDER)
        })
//        let other = UIAlertAction(title: DomainConst.CONTENT00316,
//                                  style: .default, handler: {
//                                    action in
//                                    self.selectMaterial(type: G14F01S03.TYPE_OTHERMATERIAL)
//        })
        alert.addAction(cancel)
//        alert.addAction(gas)
        alert.addAction(cylinder)
//        alert.addAction(other)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = self._tblMaterial
            presenter.sourceRect = self._tblMaterial.bounds
        }
        self.getParentView().present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle select material for add new
     * - parameter type: Type of material
     * - parameter data: Current selection
     */
    internal func selectMaterial(type: String, data: OrderDetailBean = OrderDetailBean.init()) {
        MaterialSelectViewController.setSelectedItem(item: data)
        G14F01S03._type = type
        switch G14F01S03._type {
        case G14F01S03.TYPE_GAS:                      // Gas
            MaterialSelectViewController.setMaterialData(orderDetails: CacheDataRespModel.record.getGasMaterials())
            self.getParentView().pushToView(name: G05F02S01VC.theClassName)
        case G14F01S03.TYPE_CYLINDER:                 // Cylinder
            MaterialSelectViewController.setMaterialData(orderDetails: CacheDataRespModel.record.getCylinderMaterials())
            self.getParentView().pushToView(name: G05F02S01VC.theClassName)
        case G14F01S03.TYPE_OTHERMATERIAL:            // The other material
            MaterialSelectViewController.setMaterialData(orderDetails: CacheDataRespModel.record.getAllMaterials())
            self.getParentView().pushToView(name: G05F02S01VC.theClassName)
        default:
            break
        }
    }
    
    /**
     * Insert material at tail
     * - parameter material: Data to update
     */
    public func appendMaterial(material: OrderDetailBean, isUpdateQty: Bool = true) {
        let orderItem = OrderVIPDetailBean(orderDetail: material)
        G14F01S03._data.append(orderItem)
        if isUpdateQty {
            updateQtyMaterial(idx: _listMaterial.count - 1)
        }
        updateTableView()
    }
    
    /**
     * Delete material
     * - parameter idx: Index of selected row (by table view index)
     */
    internal func deleteMaterial(idx: Int) {
        // Check index is valid
        if idx < 1 || idx > _listMaterial.count - 2 {
            return
        }
        // Delete in data
        G14F01S03._data.remove(at: idx - 1)
        // Delete in table data
        _listMaterial.remove(at: idx)
        let indexPath: IndexPath = IndexPath(item: idx, section: 0)
        // Delete in table
        _tblMaterial.deleteRows(at: [indexPath], with: .fade)
    }
    
    /**
     * Update quantity of material
     * - parameter idx: Index of selected row (by table view index)
     */
    internal func updateQtyMaterial(idx: Int) {
        let dataIdx = idx - 1
        let material = G14F01S03._data[dataIdx]
        var tbxSerial       : UITextField?
        var tbxCylinderOnly : UITextField?
        var tbxFull         : UITextField?
        var tbxQty          : UITextField?
        let df = NumberFormatter()
        df.locale = Locale.current
        let decimal = df.decimalSeparator ?? DomainConst.SPLITER_TYPE4
        // Create alert
        let alert = UIAlertController(title: material.material_name,
                                      message: DomainConst.CONTENT00344,
                                      preferredStyle: .alert)
        alert.addTextField(configurationHandler: {
            textField -> Void in
            tbxQty = textField
            tbxQty?.placeholder       = DomainConst.CONTENT00255
            tbxQty?.clearButtonMode   = .whileEditing
            tbxQty?.returnKeyType     = .done
            tbxQty?.keyboardType      = .numberPad
            tbxQty?.text              = material.qty
            tbxQty?.textAlignment     = .center
        })
        alert.addTextField(configurationHandler: {
            textField -> Void in
            tbxSerial = textField
            tbxSerial?.placeholder       = DomainConst.CONTENT00109
            tbxSerial?.clearButtonMode   = .whileEditing
            tbxSerial?.returnKeyType     = .next
            tbxSerial?.keyboardType      = .numberPad
            tbxSerial?.text              = material.seri
            tbxSerial?.textAlignment     = .center
        })
        alert.addTextField(configurationHandler: {
            textField -> Void in
            tbxCylinderOnly = textField
            tbxCylinderOnly?.placeholder       = DomainConst.CONTENT00346
            tbxCylinderOnly?.clearButtonMode   = .whileEditing
            tbxCylinderOnly?.returnKeyType     = .next
            tbxCylinderOnly?.keyboardType      = .decimalPad
            tbxCylinderOnly?.text              = material.kg_empty.replacingOccurrences(
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
            tbxFull?.text              = material.kg_has_gas.replacingOccurrences(
                of: DomainConst.SPLITER_TYPE4,
                with: decimal)
            tbxFull?.textAlignment     = .center
        })
        
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
            if let seri = tbxSerial?.text, let qty = tbxQty?.text,
                let cylinderMass = tbxCylinderOnly?.text,
                let fullMass = tbxFull?.text {
                // Small cylinder
                if G14F01S03._data[dataIdx].isCylinderType1() {
                    self.updateDataLayoutCylinder(dataIdx: dataIdx, value: (seri, qty, cylinderMass, fullMass))
                } else if G14F01S03._data[dataIdx].isCylinderType2() {   // Big cylinders
                    // Quantity is "1"
                    if qty == DomainConst.NUMBER_ONE_VALUE {
                        self.updateDataLayoutCylinder(dataIdx: dataIdx, value: (seri, qty, cylinderMass, fullMass))
                    } else if !qty.isEmpty {    // Quantity is greater than "1"
                        self.updateDataLayoutCylinder(dataIdx: dataIdx,
                                                      value: (seri, DomainConst.NUMBER_ONE_VALUE,
                                                              cylinderMass, fullMass))
                        if let n = NumberFormatter().number(from: qty) {
                            for _ in 0..<(n.intValue - 1) {
                                self.appendMaterial(material: G14F01S03._data[dataIdx], isUpdateQty: false)
                            }
                        }
                    }
                }
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.getParentView().present(alert, animated: true, completion: nil)
    }
    
    /**
     * Update data layout for list cylinder
     * - parameter idx: Index (by _data list)
     * - parameter value: Value to update (Serial, Quantity, Cylinder mass, Full mass)
     */
    private func updateDataLayoutCylinder(dataIdx: Int, value: (String, String, String, String)) {
        if G14F01S03._data.count <= dataIdx {
            return
        }
        let df = NumberFormatter()
        df.locale = Locale.current
        let decimal = df.decimalSeparator ?? DomainConst.SPLITER_TYPE4
        let isDataValid = !value.1.isEmpty && !value.2.isEmpty && !value.3.isEmpty
        // Cylinder 4kg, 6kg, 12kg
        if G14F01S03._data[dataIdx].isCylinderType1() && !value.1.isEmpty {
            // Serial
            G14F01S03._data[dataIdx].seri        = value.0
            // Quantity
            G14F01S03._data[dataIdx].qty         = value.1
            G14F01S03._data[dataIdx].qty_real    = value.1
            var cylinderOnly = 0.0
            var full = 0.0
            // Cylinder mass
            if !value.2.isEmpty {
                let cylinderOnlyStr = value.2.replacingOccurrences(of: decimal, with: DomainConst.SPLITER_TYPE4)
                cylinderOnly        = (cylinderOnlyStr as NSString).doubleValue
                G14F01S03._data[dataIdx].kg_empty    = String(describing: cylinderOnly)
            }
            // Full mass
            if !value.3.isEmpty {
                let fullStr = value.3.replacingOccurrences(of: decimal, with: DomainConst.SPLITER_TYPE4)
                full    = (fullStr as NSString).doubleValue
                G14F01S03._data[dataIdx].kg_has_gas = String(describing: full)
            }
            if !value.2.isEmpty && !value.3.isEmpty {
//                self._listMaterial[idx][5].0 = String(describing: (full - cylinderOnly))
            }
        } else if G14F01S03._data[dataIdx].isCylinderType2() && isDataValid {
            let cylinderOnlyStr = value.2.replacingOccurrences(of: decimal, with: DomainConst.SPLITER_TYPE4)
            let fullStr = value.3.replacingOccurrences(of: decimal, with: DomainConst.SPLITER_TYPE4)
            let cylinderOnly    = (cylinderOnlyStr as NSString).doubleValue
            let full            = (fullStr as NSString).doubleValue
            // Update to array
            self.updateDataArrayCylinder(dataIdx: dataIdx, value: (value.0, value.1,
                                                           cylinderOnly, full))
        } else {
            self.getParentView().showAlert(message: DomainConst.CONTENT00047, okTitle: DomainConst.CONTENT00251,
                           okHandler: {_ in
                            self.updateQtyMaterial(idx: dataIdx)
            },
                           cancelHandler: {_ in
                            
            })
        }
        updateTableView()
    }
    
    /**
     * Update data to array cylinder
     * - parameter idx: Index
     * - parameter value: Value to update (Serial, Quantity, Cylinder mass, Full mass)
     */
    private func updateDataArrayCylinder(dataIdx: Int, value: (String, String, Double, Double)) {
        if G14F01S03._data.count <= dataIdx {
            return
        }
        // Update data
        G14F01S03._data[dataIdx].kg_empty    = String(describing: value.2)
        G14F01S03._data[dataIdx].seri        = value.0
        G14F01S03._data[dataIdx].qty         = value.1
        G14F01S03._data[dataIdx].qty_real    = value.1
        G14F01S03._data[dataIdx].kg_has_gas  = String(describing: value.3)
        // Update in table data
//        self._listCylinder[dataIdx][2].0 = value.0
//        self._listCylinder[dataIdx][1].0 = value.1
//        self._listCylinder[dataIdx][3].0 = String(describing: value.2)
//        self._listCylinder[dataIdx][4].0 = String(describing: value.3)
//        self._listCylinder[dataIdx][5].0 = String(describing: (value.3 - value.2))
    }
    
    override func checkDone() -> Bool {
        if G14F01S03._data.isEmpty {
            self.showAlert(message: DomainConst.CONTENT00367)
            return false
        }
        return true
    }
}

extension G14F01S03: UITableViewDataSource {
    /**
     * The number of sections in the table view.
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _listMaterial.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = OrderDetailTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "td")
            if indexPath.row == 0 {
                cell.setup(data: _listMaterial[indexPath.row], color: GlobalConst.BUTTON_COLOR_GRAY)
            } else if (indexPath.row == _listMaterial.count - 1) {
                cell.setup(data: _listMaterial[indexPath.row],
                           color: UIColor.white,
                           highlighColumn: [0])
            } else {
                cell.setup(data: _listMaterial[indexPath.row],
                           color: UIColor.white,
                           highlighColumn: [0],
                           alignment: [.left, .left, .left, .left, .left])
            }
            
            return cell
    }
}

extension G14F01S03: UITableViewDelegate {
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalConst.CONFIGURATION_ITEM_HEIGHT
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == _listMaterial.count - 1 {
            addNewMaterial()
        } else if (indexPath.row != 0) {
//            deleteMaterial(idx: indexPath.row)
            self.updateQtyMaterial(idx: indexPath.row)
        }
    }
    
    /**
     * Asks the data source to verify that the given row is editable.
     */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 || indexPath.row == _listMaterial.count - 1 {
            return false
        }
        return true
    }
    
    /**
     * Asks the data source to commit the insertion or deletion of a specified row in the receiver.
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.getParentView().showAlert(message: DomainConst.CONTENT00317,
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
}
