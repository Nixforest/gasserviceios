//
//  G05F00S02ExtVC.swift
//  project
//
//  Created by SPJ on 11/13/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F00S02ExtVC: ChildExtViewController {
    // MARK: Properties
    /** Id */
    var _id:                    String                  = DomainConst.BLANK
    /** Customer name label */
    var _lblCustomerName:       UILabel                 = UILabel()
    /** Information table view */
    var _tblView:               UITableView             = UITableView()
    /** List of information data */
    var _listInfo:              [ConfigurationModel]    = [ConfigurationModel]()
    /** Data */
    var _data:                  OrderVIPCreateRespModel = OrderVIPCreateRespModel()
    /** Refrest control */
    lazy var refreshControl:    UIRefreshControl = {
        let refreshControl =    UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Flag section info is show */
    var _isShowInfo:            Bool                    = true
    /** Flag section cylinder is show */
    var _isShowCylinder:        Bool                    = true
    /** List of material information */
    var _listMaterial:          [[(String, Int)]]       = [[(String, Int)]]()
    /** List of cylinder information */
    var _listCylinder:          [[(String, Int)]]       = [[(String, Int)]]()
    /** Button show material */
    var _btnMaterial:           UIButton                = UIButton()
    /** Button show Cylinder */
    var _btnCylinder:           UIButton                = UIButton()
    
    
    // MARK: Constant
    let CUSTOMER_NAME_LABEL_HEIGHT:         CGFloat     = GlobalConst.LABEL_H * 3

    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.createNavigationBar(title: DomainConst.CONTENT00506)
        
        // Create layout
        createTableView()
        createCustomerName()
        createButtons()
        self.view.addSubview(_tblView)
        
        // Request data
        requestData()
        self.view.makeComponentsColor()
    }
    
    override func setData(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        let model = OrderVIPCreateRespModel(jsonString: dataStr)
        if model.isSuccess() {
            _data = model
            _lblCustomerName.text = _data.getRecord().customer_name
            setListInfoData(data: _data.getRecord())
            setupListMaterial(data: _data.getRecord())
            _tblView.reloadData()
        } else {
            showAlert(message: model.message)
        }
    }
    
    // MARK: Logic
    /**
     * Reset data
     */
    private func resetData() {
        // Reload table
        _tblView.reloadData()
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        self.resetData()
        requestData(action: #selector(finishHandleRefresh(_:)))
    }
    
    /**
     * Set id
     * - parameter id: Value of id
     */
    public func setId(id: String) {
        self._id = id
    }
    /**
     * Setup list information data
     */
    private func setListInfoData(data: OrderVIPBean = OrderVIPBean()) {
        self._listInfo.removeAll()
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_ID_ID,
                                            name: DomainConst.CONTENT00257,
                                            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
                                            value: DomainConst.ORDER_CODE_PREFIX + data.code_no))
        var status = DomainConst.CONTENT00328
        if !data.status_number.isEmpty {
            status = CommonProcess.getOrderVIPStatusString(status: data.status_number)
        }
        // Order status
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
        
        // Contact
        if !data.customer_contact.isEmpty {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_CONTACT_ID,
                name: data.customer_contact,
                iconPath: DomainConst.CONTACT_ICON_IMG_NAME,
                value: DomainConst.BLANK))
        }
        
        if !data.info_price.isEmpty {
            _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_GAS_PRICE_ID,
                                                name: data.info_price + DomainConst.VIETNAMDONG,
                                                iconPath: DomainConst.MONEY_ICON_GREY_IMG_NAME,
                                                value: DomainConst.BLANK))
        }
        
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_TOTAL_MONEY_ID,
                                            name: DomainConst.CONTENT00262,
                                            iconPath: DomainConst.MONEY_ICON_PAPER_IMG_NAME,
                                            value: data.grand_total + DomainConst.VIETNAMDONG))
    }
    
    /**
     * Setup list of materials
     */
    func setupListMaterial(data: OrderVIPBean = OrderVIPBean()) {
        _listMaterial.removeAll()
        for item in data.info_gas {
            let materialValue: [(String, Int)] = [
                (item.material_name, G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.0),
                (item.qty, G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.1),
                (item.qty_real, G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.2)
            ]
            _listMaterial.append(materialValue)
        }
        _listCylinder.removeAll()
        for item in data.info_vo {
            var gasdu = DomainConst.BLANK
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
    }
    
    // MARK: Request server methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        OrderVIPViewRequest.request(action: action,
                                    view: self,
                                    id: self._id)
    }
    
    /**
     * Show/hide material section
     */
    internal func showHideMaterialSection(_ sender: AnyObject) {
        _isShowInfo = !_isShowInfo
        let section = IndexSet(integer: 1)
        _tblView.reloadSections(section, with: .automatic)
    }
    
    /**
     * Show/hide cylinder section
     */
    internal func showHideCylinderSection(_ sender: AnyObject) {
        _isShowCylinder = !_isShowCylinder
        let section = IndexSet(integer: 2)
        _tblView.reloadSections(section, with: .automatic)
    }
    
    // MARK: Event handler
    /**
     * Handle finish refresh
     */
    internal func finishHandleRefresh(_ notification: Notification) {
        setData(notification)
        refreshControl.endRefreshing()
    }
    
    // MARK: Layout
    // MARK: Table view
    /**
     * Create table view
     */
    private func createTableView() {
        _tblView.frame = CGRect(
            x: 0, y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height)
        _tblView.addSubview(refreshControl)
        _tblView.dataSource = self
        _tblView.delegate = self
        _tblView.register(ConfigurationTableViewCell.self,
                          forCellReuseIdentifier: ConfigurationTableViewCell.theClassName)
        _tblView.estimatedRowHeight = 44.0
        _tblView.rowHeight = UITableViewAutomaticDimension
    }
    
    /**
     * Create customer name label
     */
    private func createCustomerName() {
        _lblCustomerName.frame = CGRect(x: 0, y: 0,
                                        width: UIScreen.main.bounds.width,
                                        height: CUSTOMER_NAME_LABEL_HEIGHT)
        _lblCustomerName.text = "Tên Khách HàngTên Khách HàngTên Khách HàngTên Khách Hàng"
        _lblCustomerName.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        _lblCustomerName.textColor = GlobalConst.BUTTON_COLOR_RED
        _lblCustomerName.textAlignment = .center
        _lblCustomerName.lineBreakMode = .byWordWrapping
        _lblCustomerName.numberOfLines = 0
        _lblCustomerName.backgroundColor = UIColor.white
    }
    
    /**
     * Create buttons
     */
    private func createButtons() {
        let frame = CGRect(x: 0, y: 0,
                           width: UIScreen.main.bounds.width,
                           height: GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        _btnMaterial.frame = frame
        _btnMaterial.titleLabel?.font = GlobalConst.BASE_FONT
        
        _btnMaterial.setTitle(DomainConst.CONTENT00253, for: UIControlState())
        _btnMaterial.addTarget(self,
                               action: #selector(showHideMaterialSection(_:)),
                               for: .touchUpInside)
        _btnMaterial.titleLabel?.textAlignment = .left
        _btnMaterial.setBackgroundColor(color: GlobalConst.MAIN_COLOR, forState: UIControlState())
        _btnMaterial.setTitleColor(UIColor.white,
                                   for: UIControlState())
        _btnCylinder.frame = frame
        _btnCylinder.titleLabel?.font = GlobalConst.BASE_FONT
        _btnCylinder.setTitle(DomainConst.CONTENT00263, for: UIControlState())
        _btnCylinder.addTarget(self,
                               action: #selector(showHideCylinderSection(_:)),
                               for: .touchUpInside)
        _btnCylinder.titleLabel?.textAlignment = .left
        _btnCylinder.setBackgroundColor(color: GlobalConst.MAIN_COLOR, forState: UIControlState())
        _btnCylinder.setTitleColor(UIColor.white,
                                   for: UIControlState())
        
    }
}

// MARK - Protocol UITableViewDataSource
extension G05F00S02ExtVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // MARK - To do
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            let data = _listInfo[indexPath.row]
            let cellHeight = GlobalConst.CONFIGURATION_ITEM_HEIGHT - 2 * GlobalConst.MARGIN_CELL_X
            cell.imageView?.frame = CGRect(
                x: GlobalConst.MARGIN,
                y: GlobalConst.MARGIN_CELL_X,
                width: cellHeight,
                height: cellHeight)
            cell.imageView?.image = ImageManager.getImage(named: data.getIconPath())
            cell.imageView?.contentMode = .scaleAspectFit
            cell.textLabel?.text = data.name
            cell.textLabel?.font = GlobalConst.BASE_FONT
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.text = data.getValue()
            cell.detailTextLabel?.font = GlobalConst.BASE_FONT
            return cell
        case 1:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            let data = _listMaterial[indexPath.row]
            cell.textLabel?.text = data[0].0
            cell.detailTextLabel?.text = String(data[0].1)
            return cell
        case 2:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            let data = _listCylinder[indexPath.row]
            cell.textLabel?.text = data[0].0
            cell.detailTextLabel?.text = String(data[0].1)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return CUSTOMER_NAME_LABEL_HEIGHT
        case 1:
            return GlobalConst.CONFIGURATION_ITEM_HEIGHT
        case 2:
            return GlobalConst.CONFIGURATION_ITEM_HEIGHT
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // MARK - To do
        switch section {
        case 0:
            return _listInfo.count
        case 1:
            return _isShowInfo ? _listMaterial.count : 0
        case 2:
            return _isShowCylinder ? _listCylinder.count : 0
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            _lblCustomerName.text = _data.getRecord().customer_name
            return _lblCustomerName
        case 1:
            return _btnMaterial
        case 2:
            return _btnCylinder
        default:
            break
        }
        return nil
    }
}

// MARK - Protocol UITableViewDataSource
extension G05F00S02ExtVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return GlobalConst.CONFIGURATION_ITEM_HEIGHT
        case 1:
            return _isShowInfo ? GlobalConst.CONFIGURATION_ITEM_HEIGHT : 0
        case 2:
            return _isShowCylinder ? GlobalConst.CONFIGURATION_ITEM_HEIGHT : 0
        default:
            break
        }
        return GlobalConst.CONFIGURATION_ITEM_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK - To do
    }
}
