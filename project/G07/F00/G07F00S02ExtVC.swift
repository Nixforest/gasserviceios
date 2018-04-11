//
//  G07F00S02ExtVC.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/7/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework
import Alamofire
import AlamofireImage

class G07F00S02ExtVC: ChildExtViewController {
    // MARK: Properties
    /** Present data */
    var _data:          OrderFamilyViewRespModel    = OrderFamilyViewRespModel()
    /** Id */
     var _id:           String                      = DomainConst.BLANK
    /** List of information data */
    var _listInfo:      [[ConfigurationModel]]      = [[ConfigurationModel]]()
    /** List material bean */
    var _listMaterials: [OrderVIPDetailBean]        = [OrderVIPDetailBean]()
    /** List material images */
    var _listMaterialImgs:  [UIImage]               = [UIImage]()
    /** Information table view */
    var _tblInfo:       UITableView                 = UITableView()
    /** Current type when open model VC */
    var _type:          String                      = DomainConst.NUMBER_ZERO_VALUE
    /** Customer model */
    var _customerModel: CustomerFamilyBean          = CustomerFamilyBean()
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Bottom view */
    var _bottomView:    UIView                      = UIView()
    /** Height of bottom view */
    let _bottomHeight:   CGFloat                    = 2 * (GlobalConst.BUTTON_H + GlobalConst.MARGIN)
    /** Save button */
    var _btnSave:           UIButton                = UIButton()
    /** Action button */
    var _btnAction:         UIButton                = UIButton()
    /** Cancel button */
    var _btnCancel:         UIButton                = UIButton()
    /** Other actions button */
    var _btnOtherAction:    UIButton                = UIButton()
    
    // MARK: Static values
    // MARK: Constant
    /** Type when open a model VC */
    let TYPE_NONE:                          String = DomainConst.NUMBER_ZERO_VALUE
    let TYPE_PROMOTE:                       String = "1"
    let TYPE_CYLINDER:                      String = "2"
    let TYPE_OTHERMATERIAL:                 String = "3"
    let TYPE_PROMOTE_ADD:                   String = "4"
    let TYPE_CYLINDER_ADD:                  String = "5"
    let TYPE_OTHERMATERIAL_ADD:             String = "6"
    let TYPE_GAS:                           String = "7"
    let TYPE_GAS_ADD:                       String = "8"
    let TYPE_CYLINTER_UPDATE:               String = "9"
    
    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00232)
        createInfoTableView()
        self.view.addSubview(_tblInfo)
        createBottomView()
        self.view.addSubview(_bottomView)
        // Create list info
        _listInfo.append([ConfigurationModel]())
        _listInfo.append([ConfigurationModel]())
        _listInfo.append([ConfigurationModel]())
        
        // Request data from server
        requestData()
    }
    
    /**
     * Notifies the view controller that its view is about to be added to a view hierarchy.
     */
    override func viewWillAppear(_ animated: Bool) {
        // Check if table view has selected rows
        if (_tblInfo.indexPathForSelectedRow != nil) {
            // Get selected row index
            let selectedRow = (_tblInfo.indexPathForSelectedRow?.row)!
            
            switch _type {
            case TYPE_PROMOTE, TYPE_CYLINDER, TYPE_OTHERMATERIAL, TYPE_GAS:                  // Change material
                // Not select promotion material
                if MaterialSelectViewController.getSelectedItem().isEmpty() {
                    // Remove data
                    removeMaterial(at: selectedRow)
                    // Remove cell
                    _tblInfo.deleteRows(at: _tblInfo.indexPathsForSelectedRows!, with: .fade)
                } else {    // Change promotion material
                    // Update data
                    updateMaterial(at: selectedRow, material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                    // Reload table with section 1
                    loadTableViewData()
                }
            case TYPE_PROMOTE_ADD, TYPE_CYLINDER_ADD, TYPE_OTHERMATERIAL_ADD, TYPE_GAS_ADD:              // Add material
                if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                    let orderVIP = OrderVIPDetailBean(orderDetail: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                    // Add data
                    appendMaterial(material: orderVIP)
                    // Reload table with section 1,2
                    loadTableViewData()
                }
            case TYPE_CYLINTER_UPDATE:
                // Update data
                updateMaterial(at: selectedRow, material: _listMaterials[selectedRow])
                loadTableViewData()
            default:
                break
            }
        } else {
            switch _type {
            case TYPE_PROMOTE_ADD, TYPE_CYLINDER_ADD, TYPE_OTHERMATERIAL_ADD, TYPE_GAS_ADD:              // Add material
                if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                    // Add data
                    appendMaterial(material: OrderVIPDetailBean(orderDetail: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem())))
                    // Reload table with section 1,2
                    loadTableViewData()
                }
            default:
                break
            }
        }
        _type = DomainConst.NUMBER_ZERO_VALUE
    }
    
    /**
     * Set data for this view controller
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = OrderFamilyViewRespModel(jsonString: data)
        // Success response
        if model.isSuccess() {
            _data = model
            setupFirstListInfo()
            setupListMaterialInfo()
            setupListThirdListInfo()
            loadImageFromServer()
//            _tblInfo.reloadData()
            loadTableViewData()
            showHideBottomView(isShow: _data.getRecord().allow_update.isON())
        } else {
            showAlert(message: model.message)
        }
    }
    
    // MARK: Layout
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
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.clipsToBounds            = true
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
    // MARK: Information table view
    private func createInfoTableView() {
        _tblInfo.frame = CGRect(
            x: 0, y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height - _bottomHeight)
        _tblInfo.addSubview(refreshControl)
        _tblInfo.dataSource = self
        _tblInfo.delegate = self
    }
    
    /**
     * Create bottom view
     */
    private func createBottomView () {
        _bottomView.frame = CGRect(
            x: 0, y: UIScreen.main.bounds.height - _bottomHeight,
            width: UIScreen.main.bounds.width,
            height: _bottomHeight)
        var botOffset: CGFloat = 0.0
        setupButton(button: _btnSave,
                    x: (UIScreen.main.bounds.width - GlobalConst.BUTTON_W) / 2,
                    y: botOffset, title: DomainConst.CONTENT00086,
                    icon: DomainConst.SAVE_ICON_IMG_NAME, color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnSaveTapped(_:)))
        _bottomView.addSubview(_btnSave)
        setupButton(button: _btnOtherAction, x: UIScreen.main.bounds.width / 2,
                    y: botOffset, title: DomainConst.CONTENT00436,
                    icon: DomainConst.OTHER_TASK_ICON_IMG_NAME, color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnOtherActionTapped(_:)))
        _bottomView.addSubview(_btnOtherAction)
        botOffset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        setupButton(button: _btnAction,
                    x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                    y: botOffset,
                    title: DomainConst.CONTENT00311,
                    icon: DomainConst.CONFIRM_IMG_NAME, color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnActionHandler(_:)))
        setupButton(button: _btnCancel,
                    x: GlobalConst.SCREEN_WIDTH / 2,
                    y: botOffset, title: DomainConst.CONTENT00220,
                    icon: DomainConst.CANCEL_IMG_NAME, color: GlobalConst.BUTTON_COLOR_YELLOW,
                    action: #selector(btnCancelHandler(_:)))
        _bottomView.addSubview(_btnAction)
        _bottomView.addSubview(_btnCancel)
    }
    
    /**
     * Handle show/hide bottom view
     * - parameter isShow: True is show bottom view, False is hide
     */
    private func showHideBottomView(isShow: Bool) {
        if isShow {
            _btnSave.isEnabled   = _data.getRecord().show_button_save.isON()
            _btnAction.isEnabled = _data.getRecord().show_button_complete.isON()
            _btnCancel.isEnabled = _data.getRecord().show_button_cancel.isON()
        } else {
            _btnCancel.isEnabled    = false
            _btnSave.isEnabled      = false
            _btnAction.isEnabled    = false
        }
    }
    
    // MARK: Request server
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        if !self._id.isEmpty {
            OrderFamilyViewRequest.request(action: action, view: self, id: self._id)
        }
    }
    
    /**
     * Handle finish refresh
     */
    internal func finishHandleRefresh(_ notification: Notification) {
        setData(notification)
        refreshControl.endRefreshing()
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        requestData(action: #selector(finishHandleRefresh(_:)))
    }
    
    /**
     * Load image from server
     */
    internal func loadImageFromServer() {
        _listMaterialImgs.removeAll()
        for item in _listInfo[1] {
            Alamofire.request(
                item.getIconPath()).responseImage(
                    completionHandler: { response in
                        if let img = response.result.value {
//                            self._listMaterialImgs.append(img)
                            self._listMaterialImgs.insert(img, at: 0)
//                            self._tblInfo.reloadSections(IndexSet(1...2), with: .automatic)
                            self._tblInfo.reloadData()
                        }
                })
        }
    }
    
    // MARK: Logic
    /**
     * Set init data for this screen
     * - parameter id: Id of order
     */
    public func setData(id: String) {
        self._id = id
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
     * Set update data for first list infor
     */
    private func setupFirstListInfo() {
        _listInfo[0].removeAll()
        
        // Id
        _listInfo[0].append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_ID_ID, name: DomainConst.CONTENT00257,
            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME, value: _data.getRecord().code_no))
        var status = DomainConst.CONTENT00328
        if !_data.getRecord().status_number.isEmpty {
            status = getStatusString(status: _data.getRecord().status_number)
        }
        if _data.getRecord().status_number == DomainConst.ORDER_STATUS_CANCEL {
            _listInfo[0].append(ConfigurationModel(id: DomainConst.ORDER_INFO_STATUS_ID,
                                                   name: status,
                                                   iconPath: DomainConst.ORDER_STATUS_ICON_IMG_NAME,
                                                   value: BaseModel.shared.getOrderCancelReasonById(id: _data.getRecord().status_cancel)))
        } else if _data.getRecord().status_number == DomainConst.ORDER_STATUS_COMPLETE {
            _listInfo[0].append(ConfigurationModel(id: DomainConst.ORDER_INFO_STATUS_ID,
                                                   name: DomainConst.CONTENT00092,
                                                   iconPath: DomainConst.ORDER_STATUS_ICON_IMG_NAME,
                                                   value: status))
        }
        
        // Customer name and phone
        _listInfo[0].append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_PHONE_ID, name: _data.getRecord().first_name,
            iconPath: DomainConst.HUMAN_ICON_IMG_NAME, value: _data.getRecord().phone))
        // Address
        _listInfo[0].append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_ADDRESS_ID, name: _data.getRecord().address,
            iconPath: DomainConst.ADDRESS_ICON_IMG_NAME, value: DomainConst.BLANK))
        
        if !_data.getRecord().note.isBlank {
            _listInfo[0].append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_NOTE_ID, name: _data.getRecord().note,
                iconPath: DomainConst.PROBLEM_TYPE_IMG_NAME, value: DomainConst.BLANK))
        }
        
        // CCS code
        _listInfo[0].append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CCS_CODE_ID, name: DomainConst.CONTENT00445,
            iconPath: DomainConst.CCS_CODE_ICON_IMG_NAME, value: _data.getRecord().ccsCode))
    }
    
    /**
     * Set update data for list material infor
     */
    private func setupListMaterialInfo() {
        _listInfo[1].removeAll()
        _listMaterials.removeAll()
        
        // Add materials to table
        for item in _data.getRecord().order_detail {
            appendMaterial(material: item, isUpdateQty: false)
        }
    }
    
    /**
     * Set update data for third list infor
     */
    private func setupListThirdListInfo() {
        _listInfo[2].removeAll()
        
        // Add new material
        if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
            _listInfo[2].append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_MATERIAL_ADD_NEW, name: DomainConst.CONTENT00341,
                iconPath: DomainConst.ADD_MATERIAL_ICON_IMG_NAME, value: DomainConst.BLANK))
        }
        
        // Promote
        if !_data.getRecord().promotion_amount.isEmpty
            && _data.getRecord().promotion_amount != DomainConst.NUMBER_ZERO_VALUE {
            _listInfo[2].append(ConfigurationModel(
                id: DomainConst.AGENT_PROMOTION_ID, name: DomainConst.CONTENT00219,
                iconPath: DomainConst.DEFAULT_MATERIAL_IMG_NAME,
                value: DomainConst.SPLITER_TYPE1 + _data.getRecord().promotion_amount + DomainConst.VIETNAMDONG))
        }
        
        // Discount
        if !_data.getRecord().discount_amount.isEmpty
            && _data.getRecord().discount_amount != DomainConst.NUMBER_ZERO_VALUE {
            _listInfo[2].append(ConfigurationModel(
                id: DomainConst.AGENT_DISCOUNT_ID, name: DomainConst.CONTENT00239,
                iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                value: DomainConst.SPLITER_TYPE1 + _data.getRecord().discount_amount + DomainConst.VIETNAMDONG))
        }
        // Gas remain
        let gasRemain = _data.getRecord().gas_remain_amount
        if !gasRemain.isEmpty {
            _listInfo[2].append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_GAS_DU_ID,
                name: DomainConst.CONTENT00547,
                iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                value: DomainConst.SPLITER_TYPE1 + gasRemain))
        }
        // Bu vo
        if !_data.getRecord().amount_bu_vo.isEmpty
            && _data.getRecord().amount_bu_vo != DomainConst.NUMBER_ZERO_VALUE {
            _listInfo[2].append(ConfigurationModel(
                id: DomainConst.AGENT_BUVO_ID, name: DomainConst.CONTENT00246,
                iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                value: DomainConst.PLUS_SPLITER + _data.getRecord().amount_bu_vo + DomainConst.VIETNAMDONG))
        }
        if _data.getRecord().order_type != DomainConst.NUMBER_ONE_VALUE {    // Order type is not default
            var orderTypeAmount = DomainConst.BLANK
            if !_data.getRecord().order_type_amount.isEmpty
                && _data.getRecord().order_type_amount != DomainConst.NUMBER_ZERO_VALUE {
                orderTypeAmount = DomainConst.PLUS_SPLITER + _data.getRecord().order_type_amount
            }
            _listInfo[2].append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_ORDER_TYPE_ID,
                name: _data.getRecord().order_type_text,
                iconPath: DomainConst.ORDER_TYPE_ICON_IMG_NAME,
                value: orderTypeAmount))
        } else {        // Default value
            if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
                _listInfo[2].append(ConfigurationModel(
                    id: DomainConst.ORDER_INFO_ORDER_TYPE_ID,
                    name: DomainConst.CONTENT00371,
                    iconPath: DomainConst.ORDER_TYPE_ICON_IMG_NAME,
                    value: BaseModel.shared.getOrderTypeNameById(id: _data.getRecord().order_type)))
            }
        }
        
        // Total money
        _listInfo[2].append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_TOTAL_MONEY_ID, name: DomainConst.CONTENT00262,
            iconPath: DomainConst.MONEY_ICON_IMG_NAME, value: _data.getRecord().grand_total + DomainConst.VIETNAMDONG))
        // Agent name
        _listInfo[2].append(ConfigurationModel(
            id: DomainConst.AGENT_NAME_ID, name: DomainConst.CONTENT00240,
            iconPath: DomainConst.AGENT_ICON_IMG_NAME, value: _data.getRecord().agent_name))
    }
    
    /**
     * Update quantity of material
     * - parameter idx: Index of selected row
     */
    private func updateQtyMaterial(idx: Int) {
        let material = _listMaterials[idx]
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
                self._listMaterials[idx].qty = String(describing: n)
                // Update in table data
                self._listInfo[1][idx] = ConfigurationModel(orderDetail: self._listMaterials[idx])
                // Update table
//                self._tblInfo.reloadRows(at: [IndexPath(item: idx, section: 1)], with: .automatic)
                self._tblInfo.reloadData()
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
     * Update quantity for cylinder
     */
    private func updateQtyCylinder(idx: Int) {
        let bean = _listMaterials[idx]
        var tbxSerial       : UITextField?
        var tbxCylinderOnly : UITextField?
        var tbxFull         : UITextField?
        let df = NumberFormatter()
        df.locale = Locale.current
        let decimal = df.decimalSeparator ?? DomainConst.SPLITER_TYPE4
        // Create alert
        let alert = UIAlertController(title: bean.material_name,
                                      message: DomainConst.CONTENT00345,
                                      preferredStyle: .alert)
        alert.addTextField(configurationHandler: {
            textField -> Void in
            tbxSerial = textField
            tbxSerial?.placeholder       = DomainConst.CONTENT00109
            tbxSerial?.clearButtonMode   = .whileEditing
            tbxSerial?.returnKeyType     = .next
            tbxSerial?.keyboardType      = .numberPad
            tbxSerial?.text              = bean.seri
            tbxSerial?.textAlignment     = .center
        })
        alert.addTextField(configurationHandler: {
            textField -> Void in
            tbxCylinderOnly = textField
            tbxCylinderOnly?.placeholder       = DomainConst.CONTENT00346
            tbxCylinderOnly?.clearButtonMode   = .whileEditing
            tbxCylinderOnly?.returnKeyType     = .next
            tbxCylinderOnly?.keyboardType      = .decimalPad
            tbxCylinderOnly?.text              = bean.kg_empty.replacingOccurrences(
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
            tbxFull?.text              = bean.kg_has_gas.replacingOccurrences(
                of: DomainConst.SPLITER_TYPE4,
                with: decimal)
            tbxFull?.textAlignment     = .center
        })
        
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
            if let seri = tbxSerial?.text,
                let cylinderMass = tbxCylinderOnly?.text,
                let fullMass = tbxFull?.text {
                bean.seri = seri
                bean.kg_empty = cylinderMass
                bean.kg_has_gas = fullMass
                // Update data
//                self._listMaterials[idx].qty = String(describing: n)
                // Update in table data
                self._listInfo[1][idx] = ConfigurationModel(orderVIPDetail: self._listMaterials[idx])
                // Update table
//                self._tblInfo.reloadRows(at: [IndexPath(item: idx, section: 1)], with: .automatic)
                self._tblInfo.reloadData()
//                self.loadTableViewData()
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Insert material at tail
     * - parameter material: Data to update
     */
    private func appendMaterial(material: OrderVIPDetailBean, isUpdateQty: Bool = true) {
        var idx: Int = -1
        // Search in lists
        for i in 0..<_listInfo[1].count {
            if material.material_id == _listInfo[1][i].id {
                // Found
                idx = i
                break
            }
        }
        if idx == -1 {
            // Not found -> Append
            if material.isCylinder() {
                _listInfo[1].append(ConfigurationModel(orderVIPDetail: material))
            } else {
                _listInfo[1].append(ConfigurationModel(orderDetail: material))
            }
            _listMaterials.append(material)
            
            // Update quantity
            if isUpdateQty {
                if material.isCylinder() {
                    updateQtyCylinder(idx: _listMaterials.count - 1)
                } else {
                    updateQtyMaterial(idx: _listMaterials.count - 1)
                }
            }
        } else {
            // Found -> Update quantity
            if isUpdateQty {
                if material.isCylinder() {
                    updateQtyCylinder(idx: _listMaterials.count - 1)
                } else {
                    updateQtyMaterial(idx: idx)
                }
            }
        }
    }
    
    /**
     * Remove material
     * - parameter at: Index
     */
    internal func removeMaterial(at: Int) {
        _listMaterials.remove(at: at)
        _listInfo[1].remove(at: at)
    }
    
    /**
     * Update material
     * - parameter at: Index
     * - parameter material: Data to update
     */
    private func updateMaterial(at: Int, material: OrderDetailBean) {
        var idx: Int = -1
        // Search in lists
        for i in 0..<_listInfo[1].count {
            if material.material_id == _listInfo[1][i].id {
                // Found
                idx = i
                break
            }
        }
        if idx == -1 {
            // Not found -> Update item
            if (at >= 0) && (at < _listInfo[1].count){
                _listInfo[1][at] = ConfigurationModel(orderDetail: material)
            }
            if (at >= 0) && (at < _listMaterials.count) {
                _listMaterials[at] = OrderVIPDetailBean(orderDetail: material)
            }
        } else {
            // Found -> Update quantity
            if idx != at {
                if let qtyNumber = Int(_listMaterials[idx].qty) {
                    _listMaterials[idx].qty = String(qtyNumber + 1)
                    _listInfo[1][idx] = ConfigurationModel(orderDetail: _listMaterials[idx])
                }
                // Remove current select
                removeMaterial(at: at)
            } else {
                if material.isCylinder() {
                    _listInfo[1][idx] = ConfigurationModel(orderVIPDetail: _listMaterials[idx])
                }
            }
        }
    }
    
    /**
     * Handle when tap on add new material item/buton
     * - parameter sender: AnyObject
     */
    internal func addNewMaterialButtonTapped(_ sender: AnyObject) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00312,
                                      message: DomainConst.CONTENT00314,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        let promotion = UIAlertAction(title: DomainConst.CONTENT00313,
                                      style: .default, handler: {
                                        action in
                                        self.selectMaterial(type: self.TYPE_PROMOTE_ADD)
        })
        let cylinder = UIAlertAction(title: DomainConst.CONTENT00315,
                                     style: .default, handler: {
                                        action in
                                        self.selectMaterial(type: self.TYPE_CYLINDER_ADD)
        })
        let other = UIAlertAction(title: DomainConst.CONTENT00316,
                                  style: .default, handler: {
                                    action in
                                    self.selectMaterial(type: self.TYPE_OTHERMATERIAL_ADD)
        })
        let gas = UIAlertAction(title: DomainConst.CONTENT00333,
                                style: .default, handler: {
                                    action in
                                    self.selectMaterial(type: self.TYPE_GAS_ADD)
        })
        alert.addAction(gas)
        
        alert.addAction(cancel)
        alert.addAction(promotion)
        alert.addAction(cylinder)
        alert.addAction(other)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = _tblInfo
            presenter.sourceRect = _tblInfo.bounds
        }
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
        case TYPE_PROMOTE, TYPE_PROMOTE_ADD:                // Promotion
            MaterialSelectViewController.setMaterialData(data: BaseModel.shared.getAgentMaterialPromotion(agentId: _data.getRecord().agent_id))
            self.pushToView(name: G07F01S01VC.theClassName)
            
        case TYPE_CYLINDER, TYPE_CYLINDER_ADD:              // Cylinder
            MaterialSelectViewController.setMaterialData(data: BaseModel.shared.getListCylinderInfo())
            self.pushToView(name: G07F01S02VC.theClassName)
            
        case TYPE_OTHERMATERIAL, TYPE_OTHERMATERIAL_ADD:    // The other material
            MaterialSelectViewController.setMaterialData(data: BaseModel.shared.getListOtherMaterialInfo())
            self.pushToView(name: G07F01S02VC.theClassName)
            
        case TYPE_GAS, TYPE_GAS_ADD:
            MaterialSelectViewController.setMaterialDataFromFavourite(key: DomainConst.KEY_SETTING_FAVOURITE_GAS)
            self.pushToView(name: G07F01S02VC.theClassName)
            
        default:
            break
        }
    }
    
    /**
     * Check can update data
     * - returns: True if allow update flag is ON, False otherwise
     */
    internal func canUpdate() -> Bool {
        return self._data.getRecord().allow_update.isON()
    }
    
    /**
     * Handle update order type
     * - parameter id: Id of order type
     */
    internal func handleUpdateOrderType(id: String) {
        if id != _data.getRecord().order_type {
            _data.getRecord().order_type = id
            for item in _listInfo[2] {  // Loop in section 2 data
                if item.id == DomainConst.ORDER_INFO_ORDER_TYPE_ID {  // Order type item
                    if (_data.getRecord().order_type != DomainConst.NUMBER_ZERO_VALUE) {    // Order type is not default
                        // Update value
                        item.updateData(id: DomainConst.ORDER_INFO_ORDER_TYPE_ID,
                                        name: BaseModel.shared.getOrderTypeNameById(id: id),
                                        iconPath: DomainConst.ORDER_TYPE_ICON_IMG_NAME,
                                        value: DomainConst.BLANK)
                    } else {        // Default value
                        // Update value
                        item.updateData(id: DomainConst.ORDER_INFO_ORDER_TYPE_ID,
                                        name: DomainConst.CONTENT00371,
                                        iconPath: DomainConst.ORDER_TYPE_ICON_IMG_NAME,
                                        value: BaseModel.shared.getOrderTypeNameById(id: id))
                    }
                    break
                }
            }
//            _tblInfo.reloadData()
            loadTableViewData()
        }
    }
    
    /**
     * Handle when tap Order type
     */
    internal func updateOrderType() {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00371,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
        for item in BaseModel.shared.getListOrderTypes() {
            let action = UIAlertAction(title: item.name,
                                       style: .default, handler: {
                                        action in
                                        self.handleUpdateOrderType(id: item.id)
            })
            alert.addAction(action)
        }
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Update value of ccs code
     */
    internal func updateCCSCode() {
        var tbxValue: UITextField?
        // Create alert
        let alert = UIAlertController(title: DomainConst.CONTENT00445,
                                      message: DomainConst.CONTENT00445,
                                      preferredStyle: .alert)
        // Add textfield
        alert.addTextField(configurationHandler: { textField -> Void in
            tbxValue = textField
            tbxValue?.placeholder       = DomainConst.CONTENT00445
            tbxValue?.clearButtonMode   = .whileEditing
            tbxValue?.returnKeyType     = .done
            tbxValue?.keyboardType      = .default
            tbxValue?.text              = self._data.getRecord().ccsCode
            tbxValue?.autocapitalizationType = .allCharacters
            tbxValue?.textAlignment     = .center
        })
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
            if let value = tbxValue?.text {
                // Update data
                self._data.getRecord().ccsCode = value
                // Loop for all the first list info
                for i in 0..<self._listInfo[0].count {
                    // Get current item
                    let item = self._listInfo[0][i]
                    // Check if ccs code item
                    if item.id == DomainConst.ORDER_INFO_CCS_CODE_ID {
                        // Update value
                        self._listInfo[0][i].updateData(id: item.id,
                                                        name: item.name,
                                                        iconPath: item.getIconPath(),
                                                        value: value)
                        // Stop loop statement
                        break
                    }
                }
                // Reload tableview
//                self._tblInfo.reloadData()
                self.loadTableViewData()
            } else {
                self.showAlert(message: DomainConst.CONTENT00251, okTitle: DomainConst.CONTENT00251,
                               okHandler: {_ in
                                self.updateCCSCode()
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
     * Load data for table view
     */
    internal func loadTableViewData() {
//        loadImageFromServer()
        _tblInfo.reloadData()
    }
    
    /**
     * Handle when tap on save button
     */
    internal func btnSaveTapped(_ sender: AnyObject) {
        var orderDetail = [String]()
        for item in self._listMaterials {
            if !item.material_id.isEmpty {
                orderDetail.append(item.createJsonDataForUpdateOrder())
            }
        }
        OrderFamilyHandleRequest.requestUpdate(
            action: #selector(finishUpdateOrder(_:)),
            view: self,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: _data.getRecord().id,
            statusCancel: _data.getRecord().status_cancel,
            orderType: _data.getRecord().order_type,
            discountType: _data.getRecord().discount_type,
            amountDiscount: _data.getRecord().amount_discount,
            typeAmount: _data.getRecord().type_amount,
            support_id: _data.getRecord().support_id,
            orderDetail: orderDetail.joined(separator: DomainConst.SPLITER_TYPE2),
            ccsCode: _data.getRecord().ccsCode)
    }
    
    internal func finishUpdateOrder(_ notification: Notification) {
        setData(notification)
    }
    
    /**
     * Handle when tap on Action button
     */
    internal func btnActionHandler(_ sender: AnyObject) {
        var bIsExistCylinder = false
        for item in _listMaterials {
            if item.isCylinder() {
                bIsExistCylinder = true
                break
            }
        }
        if bIsExistCylinder {
            requestCompleteOrder()
        } else {
            showAlert(message: DomainConst.CONTENT00324,
                      okTitle: DomainConst.CONTENT00326,
                      cancelTitle: DomainConst.CONTENT00325,
                      okHandler: {
                        alert in
                        self.requestCompleteOrder()
            },
                      cancelHandler: {
                        alert in
                        self.selectMaterial(type: self.TYPE_CYLINDER_ADD)
            })
        }
    }
    
    /**
     * Request complete order
     */
    private func requestCompleteOrder() {
        var orderDetail = [String]()
        for item in self._listMaterials {
            if !item.material_id.isEmpty {
                orderDetail.append(item.createJsonDataForUpdateOrder())
            }
        }
        OrderFamilyHandleRequest.requestComplete(
            action: #selector(finishUpdateOrder(_:)),
            view: self,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: _data.getRecord().id,
            statusCancel: _data.getRecord().status_cancel,
            orderType: _data.getRecord().order_type,
            discountType: _data.getRecord().discount_type,
            amountDiscount: _data.getRecord().amount_discount,
            typeAmount: _data.getRecord().type_amount,
            support_id: _data.getRecord().support_id,
            orderDetail: orderDetail.joined(separator: DomainConst.SPLITER_TYPE2),
            ccsCode: _data.getRecord().ccsCode)
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
        for item in BaseModel.shared.getListCancelOrderReasons() {
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
        showAlert(message: String.init(format: DomainConst.CONTENT00349, BaseModel.shared.getOrderCancelReasonById(id: id)),
                  okTitle: DomainConst.CONTENT00008,
                  cancelTitle: DomainConst.CONTENT00009,
                  okHandler: {
                    alert in
                    OrderFamilyHandleRequest.requestCancelOrder(
                        action: #selector(self.finishUpdateOrder(_:)),
                        view: self,
                        lat: String(MapViewController._originPos.latitude),
                        long: String(MapViewController._originPos.longitude),
                        id: self._data.getRecord().id,
                        statusCancel: id)
        },
                  cancelHandler: {
                    alert in
        })
    }
    
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
        
        if _data.getRecord().show_button_change_agent == 1 {
            let updateAgent = UIAlertAction(title: DomainConst.CONTENT00458,
                                            style: .default, handler: {
                                                action in
                                                self.handleUpdateAgent()
            })
            alert.addAction(updateAgent)
        }
        
        if _data.getRecord().show_button_update_customer == 1 {
            let updateCustomer = UIAlertAction(title: DomainConst.CONTENT00154,
                                               style: .default, handler: {
                                                action in
                                                self.handleUpdateCustomer()
            })
            alert.addAction(updateCustomer)
        }
        let ticket = UIAlertAction(title: DomainConst.CONTENT00402,
                                   style: .default, handler: {
                                    action in
                                    self.btnCreateTicketTapped(self)
        })
        alert.addAction(ticket)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle update agent delivery
     */
    internal func handleUpdateAgent() {
        G07F03VC._currentAgent.id    = self._data.getRecord().agent_id
        G07F03VC._currentAgent.name  = self._data.getRecord().agent_name
        G07F03VC._currentAgent.phone = self._data.getRecord().agent_phone
        G07F03VC._orderId            = self._data.getRecord().id
        self.pushToView(name: G07F03VC.theClassName)
    }
     
    /**
     * Handle update customer information
     */
    internal func handleUpdateCustomer() {
        if !_data.getRecord().customer_id.isEmpty {
            CustomerFamilyViewRequest.request(
                action: #selector(finishRequestCustomerInfo(_:)),
                view: self,
                customer_id: _data.getRecord().customer_id)
        } else {
            showAlert(message: DomainConst.CONTENT00447)
        }
    }
    
    /**
     * Handle when finish request customer information
     */
    internal func finishRequestCustomerInfo(_ notification: Notification) {
        let data = (notification.object as? String)
        let model = CustomerFamilyViewRespModel(jsonString: data!)
        if model.isSuccess() {
            _customerModel = model.record
            if BaseModel.shared.getListDistricts(provinceId: model.record.province_id) != nil {
                updateCustomer()
            } else {
                // Request data from server
                DistrictsListRequest.request(
                    action: #selector(finishRequestDistrictList(_:)),
                    view: self,
                    provinceId: model.record.province_id)
            }
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle when finish request district list from server
     */
    internal func finishRequestDistrictList(_ notification: Notification) {
        let data = (notification.object as? String)
        let model = DistrictsListRespModel(jsonString: data!)
        if model.isSuccess() {
            updateCustomer()
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Open update customer information screen
     */
    private func updateCustomer() {
        G07F02VC._data = _customerModel
        G07F02S01._selectedValue = (_customerModel.name, _customerModel.phone)
        G07F02S02._fullAddress.setData(bean: FullAddressBean(
            provinceId:     _customerModel.province_id,
            districtId:     _customerModel.district_id,
            wardId:         _customerModel.ward_id,
            streetId:       _customerModel.street_id,
            houseNumber:    _customerModel.house_numbers))
        self.pushToView(name: G07F02VC.theClassName)
    }
    
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
            format: DomainConst.CONTENT00562,
            _data.getRecord().created_date,
            _data.getRecord().code_no,
            _data.getRecord().first_name)
        self.pushToView(name: G11F01VC.theClassName)
        
    }
    
    /**
     * Update cylinder information
     *  - parameter bean: Order data
     */
    func updateCylinderInfo(bean: OrderVIPDetailBean) {
        self._type = TYPE_CYLINTER_UPDATE
        let view = G07F00S03VC(nibName: G07F00S03VC.theClassName, bundle: nil)
        view.createNavigationBar(title: bean.material_name)
        view.setData(bean: bean)
        if let controller = BaseViewController.getCurrentViewController() {
            controller.navigationController?.pushViewController(
                view, animated: true)
        }
    }
}

// MARK: Protocol - UITableViewDataSource
extension G07F00S02ExtVC: UITableViewDataSource {
    /**
     * Asks the data source to return the number of sections in the table view.
     * - returns: _listInfo.count
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return _listInfo.count
    }
    
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     * - returns: List information count
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _listInfo[section].count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > self._listInfo[indexPath.section].count {
            return UITableViewCell()
        }
        let data = self._listInfo[indexPath.section][indexPath.row]
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        switch indexPath.section {
        case 0, 2:
            cell.textLabel?.text = data.name
            cell.textLabel?.font = GlobalConst.SMALL_FONT
            cell.detailTextLabel?.text = data.getValue()
            cell.detailTextLabel?.font = GlobalConst.SMALL_FONT
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            cell.detailTextLabel?.numberOfLines = 0
            cell.imageView?.image = ImageManager.getImage(
                named: data.getIconPath(),
                margin: GlobalConst.MARGIN)
            cell.imageView?.contentMode = .scaleAspectFit
        case 1:
            cell.textLabel?.text = data.name
            cell.textLabel?.font = GlobalConst.SMALL_FONT
            cell.detailTextLabel?.text = data.getValue()
            cell.detailTextLabel?.font = GlobalConst.SMALL_FONT
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            cell.detailTextLabel?.numberOfLines = 0
            if _listMaterialImgs.count > indexPath.row {
                cell.imageView?.image = _listMaterialImgs[indexPath.row]
            }
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView?.frame = CGRect(
                x: 0, y: 0,
                width: GlobalConst.ACCOUNT_AVATAR_H / 2,
                height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        default:
            break
        }
        
        return cell    
    }
}

// MARK: Protocol - UITableViewDelegate
extension G07F00S02ExtVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = _listInfo[indexPath.section][indexPath.row]
        switch indexPath.section {
        case 0, 2:     // Basic information
            switch data.id {
            case DomainConst.ORDER_INFO_ADDRESS_ID:
                showAlert(message: data.name, title: DomainConst.CONTENT00561)
            case DomainConst.ORDER_INFO_MATERIAL_ADD_NEW:
                if self.canUpdate() {
                    self.addNewMaterialButtonTapped(self)
                }
            case DomainConst.ORDER_INFO_PHONE_ID:
                self.makeACall(phone: data.getValue().normalizatePhoneString())
            case DomainConst.ORDER_INFO_ORDER_TYPE_ID:
                if self.canUpdate() {
                    self.updateOrderType()
                }
            case DomainConst.ORDER_INFO_CCS_CODE_ID:
                if self.canUpdate() {
                    self.updateCCSCode()
                }
            case DomainConst.ORDER_INFO_NOTE_ID:
                self.showAlert(message: _data.getRecord().note)
            default: break
            }
            break
        case 1:     // Material list
            if self.canUpdate() {
                let materialData = _listMaterials[indexPath.row]
                if materialData.isPromotion() {
                    self.selectMaterial(type: TYPE_PROMOTE, data: materialData)
                } else if materialData.isCylinder() {
                    self.updateCylinderInfo(bean: materialData)
                } else if materialData.isGas() {
                    self.selectMaterial(type: TYPE_GAS, data: materialData)
                } else {
                    self.selectMaterial(type: TYPE_OTHERMATERIAL, data: materialData)
                }
            }
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
    
    /**
     * Asks the data source to verify that the given row is editable.
     */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0, 2:
            break
        case 1:
            if self.canUpdate() {
                return true
            }
        default:
            break
        }
        return false
    }
    
    /**
     * Asks the data source to commit the insertion or deletion of a specified row in the receiver.
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.showAlert(message: DomainConst.CONTENT00317,
                           okHandler: {
                            (alert: UIAlertAction!) in
                            self.removeMaterial(at: indexPath.row)
                            self._tblInfo.deleteRows(
                                at: [indexPath], with: .fade)
            },
                           cancelHandler: {
                            (alert: UIAlertAction!) in
            })
        default:
            break
        }
    }
}
