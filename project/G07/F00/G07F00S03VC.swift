//
//  G07F00S03VC.swift
//  project
//
//  Created by SPJ on 2/22/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class G07F00S03VC: ChildExtViewController {
    // MARK: Properties
    /** Present data */
    var _data:          [ConfigurationModel]    = [ConfigurationModel]()
    /** Data */
    var _materialData:  OrderVIPDetailBean      = OrderVIPDetailBean()
    /** Information table view */
    var _tblInfo:       UITableView             = UITableView()
    
    // MARK: Static values
    // MARK: Constant
    
    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createInfoTableView()
        self.view.addSubview(_tblInfo)
    }
    
    /**
     * Set data
     * - parameter bean: Data to set
     */
    public func setData(bean: OrderVIPDetailBean) {
        self._materialData = bean
//        _data.append(ConfigurationModel(id: DomainConst.ITEM_QTY,
//                                       name: DomainConst.CONTENT00255,
//                                       iconPath: "",
//                                       value: bean.qty))
        _data.append(ConfigurationModel(id: DomainConst.ITEM_SERIAL,
                                       name: DomainConst.CONTENT00336,
                                       iconPath: "",
                                       value: bean.seri))
        _data.append(ConfigurationModel(id: DomainConst.ITEM_CYLINDER_MASS,
                                       name: DomainConst.CONTENT00346,
                                       iconPath: "",
                                       value: bean.kg_empty))
        _data.append(ConfigurationModel(id: DomainConst.ITEM_CYLINDER_GAS_MASS,
                                       name: DomainConst.CONTENT00347,
                                       iconPath: "",
                                       value: bean.kg_has_gas))
    }
    
    /**
     * Handle input text
     * - parameter bean: Data of item
     */
    internal func inputText(bean: ConfigurationModel) {
        var title           = bean.name
        var message         = DomainConst.BLANK
        var placeHolder     = DomainConst.BLANK
        var keyboardType    = UIKeyboardType.default
        var value           = bean.getValue()
        var tbxValue: UITextField?
        
        // Create alert
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        // Add textfield
        alert.addTextField(configurationHandler: { textField -> Void in
            tbxValue = textField
            tbxValue?.placeholder       = placeHolder
            tbxValue?.clearButtonMode   = .whileEditing
            tbxValue?.returnKeyType     = .done
            tbxValue?.keyboardType      = keyboardType
            tbxValue?.text              = value
            tbxValue?.textAlignment     = .center
        })
        
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) {
            action -> Void in
            if let newValue = tbxValue?.text, !newValue.isEmpty {
                bean.updateData(id: bean.id,
                                name: bean.name,
                                iconPath: bean.getIconPath(),
                                value: newValue)
                switch bean.id {
                case DomainConst.ITEM_QTY:
                    self._materialData.qty = newValue
                case DomainConst.ITEM_SERIAL:
                    self._materialData.seri = newValue
                case DomainConst.ITEM_CYLINDER_MASS:
                    self._materialData.kg_empty = newValue
                case DomainConst.ITEM_CYLINDER_GAS_MASS:
                    self._materialData.kg_has_gas = newValue
                default: break
                }
                self._tblInfo.reloadData()
            } else {
                self.showAlert(message: DomainConst.CONTENT00551,
                               okHandler: {
                                alert in
                                self.inputText(bean: bean)
                })
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        if let popVC = alert.popoverPresentationController {
            popVC.sourceView = self.view
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle input numeric
     * - parameter bean: Data of item
     */
    internal func inputNumeric(bean: ConfigurationModel) {
        var title           = bean.name
        var message         = DomainConst.BLANK
        var placeHolder     = DomainConst.BLANK
        var keyboardType    = UIKeyboardType.decimalPad
        var value           = bean.getValue()
        var tbxValue: UITextField?
        let df = NumberFormatter()
        df.locale = Locale.current
        let decimal = df.decimalSeparator ?? DomainConst.SPLITER_TYPE4
        // Create alert
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        // Add textfield
        alert.addTextField(configurationHandler: { textField -> Void in
            tbxValue = textField
            tbxValue?.placeholder       = placeHolder
            tbxValue?.clearButtonMode   = .whileEditing
            tbxValue?.returnKeyType     = .done
            tbxValue?.keyboardType      = keyboardType
            tbxValue?.text              = value.replacingOccurrences(
                of: DomainConst.SPLITER_TYPE4,
                with: decimal)
            tbxValue?.textAlignment     = .center
        })
        
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) {
            action -> Void in
            if let newValue = tbxValue?.text, !newValue.isEmpty {
                if newValue.characters.count <= 5 {
                    let newValueStr = newValue.replacingOccurrences(of: decimal, with: DomainConst.SPLITER_TYPE4)
                    let doubleValue = (newValueStr as NSString).doubleValue
                    bean.updateData(id: bean.id,
                                    name: bean.name,
                                    iconPath: bean.getIconPath(),
                                    value: String(describing: doubleValue))
                    switch bean.id {
                    case DomainConst.ITEM_CYLINDER_MASS:
                        self._materialData.kg_empty = String(describing: doubleValue)
                    case DomainConst.ITEM_CYLINDER_GAS_MASS:
                        self._materialData.kg_has_gas = String(describing: doubleValue)
                    default: break
                    }
                    self._tblInfo.reloadData()
                } else {
                    self.showAlert(message: DomainConst.CONTENT00560,
                                   okHandler: {
                                    alert in
                                    self.inputText(bean: bean)
                    })
                }
            } else {
                self.showAlert(message: DomainConst.CONTENT00559,
                               okHandler: {
                                alert in
                                self.inputText(bean: bean)
                })
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        if let popVC = alert.popoverPresentationController {
            popVC.sourceView = self.view
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Layout
    
    // MARK: Information table view
    private func createInfoTableView() {
        _tblInfo.frame = CGRect(
            x: 0, y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height)
        _tblInfo.dataSource = self
        _tblInfo.delegate = self
    }
}

// MARK: Protocol - UITableViewDataSource
extension G07F00S03VC: UITableViewDataSource {
    /**
     * Asks the data source to return the number of sections in the table view.
     * - returns: 1 section
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     * - returns: List information count
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self._data.count
        default:
            // For future
            return 0
        }
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row > self._data.count {
                return UITableViewCell()
            }
            let data = self._data[indexPath.row]
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            cell.textLabel?.text = data.name
            cell.textLabel?.font = GlobalConst.BASE_FONT
            cell.detailTextLabel?.text = data.getValue()
            cell.detailTextLabel?.font = GlobalConst.BASE_FONT
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            cell.detailTextLabel?.numberOfLines = 0
            if data.getValue().isEmpty {
                cell.detailTextLabel?.text = "Đang cập nhật"
                cell.detailTextLabel?.textColor = UIColor.red
            }
            return cell
        case 1:     // For future
            break
        default:
            break
        }
        
        return UITableViewCell()        
    }
}

// MARK: Protocol - UITableViewDelegate
extension G07F00S03VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let data = self._data[indexPath.row]
            switch data.id {
            case DomainConst.ITEM_QTY, DomainConst.ITEM_SERIAL:
                self.inputText(bean: data)
            case DomainConst.ITEM_CYLINDER_MASS,
                 DomainConst.ITEM_CYLINDER_GAS_MASS:
                self.inputNumeric(bean: data)
            default: break
            }
        case 1:     // For future
            break
        default:
            break
        }
        
    }
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
