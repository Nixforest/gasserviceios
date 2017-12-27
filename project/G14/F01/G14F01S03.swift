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
    public static var _data:    [OrderDetailBean]       = [OrderDetailBean]()
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
        updateData()
        
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
     * Update data
     */
    internal func updateData() {
        _listMaterial.removeAll()
        // Header
        _listMaterial.append(_materialHeader)
        
        // Order detail
        for item in G14F01S03._data {
            let materialValue: [(String, Int)] = [
                (item.materials_no,     G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.0),
                (item.material_name,    G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.1),
                (item.qty + " x " + item.unit,     G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.2)
            ]
            _listMaterial.append(materialValue)
        }
        // Total
        let total: [(String, Int)] = [
            (DomainConst.BLANK,         G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.0),
            (DomainConst.CONTENT00341,  G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.1),
            (DomainConst.BLANK,    G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.2)
        ]
        _listMaterial.append(total)
        _tblMaterial.reloadData()
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
        let gas = UIAlertAction(title: DomainConst.CONTENT00333,
                                style: .default, handler: {
                                    action in
                                    self.selectMaterial(type: G08F01S03.TYPE_GAS)
        })
        let cylinder = UIAlertAction(title: DomainConst.CONTENT00315,
                                     style: .default, handler: {
                                        action in
                                        self.selectMaterial(type: G08F01S03.TYPE_CYLINDER)
        })
        let other = UIAlertAction(title: DomainConst.CONTENT00316,
                                  style: .default, handler: {
                                    action in
                                    self.selectMaterial(type: G08F01S03.TYPE_OTHERMATERIAL)
        })
        alert.addAction(cancel)
        alert.addAction(gas)
        alert.addAction(cylinder)
        alert.addAction(other)
        self.getParentView().present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle select material
     * - parameter type: Type of material
     * - parameter data: Current selection
     */
    internal func selectMaterial(type: String, data: OrderDetailBean = OrderDetailBean.init()) {
        MaterialSelectViewController.setSelectedItem(item: data)
        G08F01S03._type = type
        switch G08F01S03._type {
        case G08F01S03.TYPE_GAS:                      // Gas
            MaterialSelectViewController.setMaterialData(orderDetails: CacheDataRespModel.record.getGasMaterials())
            //            MaterialSelectViewController.setMaterialDataFromFavourite(key: DomainConst.KEY_SETTING_FAVOURITE_GAS_LOGIN)
            self.getParentView().pushToView(name: G05F02S01VC.theClassName)
        case G08F01S03.TYPE_CYLINDER:                 // Cylinder
            MaterialSelectViewController.setMaterialData(orderDetails: CacheDataRespModel.record.getCylinderMaterials())
            self.getParentView().pushToView(name: G05F02S01VC.theClassName)
        case G08F01S03.TYPE_OTHERMATERIAL:            // The other material
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
    public func appendMaterial(material: OrderDetailBean) {
        var idx: Int = -1
        // Search in lists
        for i in 0..<G08F01S03._data.count {
            if material.material_id == G08F01S03._data[i].material_id {
                // Found
                idx = i
                break
            }
        }
        if idx == -1 {
            // Not found -> Append
            if material.qty.isEmpty {
                material.qty = DomainConst.NUMBER_ONE_VALUE
            }
            G08F01S03._data.append(material)
        } else {
            // Found -> Update quantity
            if let qtyNumber = Int(G08F01S03._data[idx].qty) {
                G08F01S03._data[idx].qty = String(qtyNumber + 1)
            }
        }
        updateData()
    }
    
    /**
     * Delete material
     * - parameter idx: Index of selected row
     */
    internal func deleteMaterial(idx: Int) {
        // Delete in data
        G08F01S03._data.remove(at: idx - 1)
        // Delete in table data
        _listMaterial.remove(at: idx - 1)
        let indexPath: IndexPath = IndexPath(item: idx, section: 0)
        // Delete in table
        _tblMaterial.deleteRows(at: [indexPath], with: .fade)
    }
    
    /**
     * Update quantity of material
     * - parameter idx: Index of selected row
     */
    private func updateQtyMaterial(idx: Int) {
        let material = G08F01S03._data[idx - 1]
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
            tbxValue?.text              = material.qty
            tbxValue?.textAlignment     = .center
        })
        
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
            if let n = NumberFormatter().number(from: (tbxValue?.text)!) {
                // Update data
                G08F01S03._data[idx - 1].qty = String(describing: n)
                self.updateData()
            } else {
                self.getParentView().showAlert(message: DomainConst.CONTENT00251, okTitle: DomainConst.CONTENT00251,
                                               okHandler: {_ in
                                                self.updateQtyMaterial(idx: idx)
                },
                                               cancelHandler: {_ in
                                                
                })
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.getParentView().present(alert, animated: true, completion: nil)
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
            } else {
                cell.setup(data: _listMaterial[indexPath.row],
                           color: UIColor.white,
                           highlighColumn: [1],
                           alignment: [.left, .left, .left])
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
            deleteMaterial(idx: indexPath.row)
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
