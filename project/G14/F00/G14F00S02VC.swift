//
//  G14F00S02VC.swift
//  project
//
//  Created by SPJ on 1/1/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class G14F00S02VC: ChildExtViewController {
    // MARK: Properties
    /** Id */
    var _id:                    String                  = DomainConst.BLANK
    /** Information table view */
    var _tblView:               UITableView             = UITableView()
    /** List of information data */
    var _listInfo:              [ConfigurationModel]    = [ConfigurationModel]()
    /** Data */
    var _data:                  GasRemainViewRespModel  = GasRemainViewRespModel()
    /** Refrest control */
    lazy var refreshControl:    UIRefreshControl = {
        let refreshControl =    UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    var _btnUpdate:             UIButton                = UIButton()
    /** Flag first time run */
    var _isFirstTime:           Bool                    = true
    
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.createNavigationBar(title: DomainConst.CONTENT00555)
        // Create layout
        createTableView()
        self.view.addSubview(_tblView)
        createUpdateBtn()
        self.view.addSubview(_btnUpdate)
        // Request data
        requestData()
    }
    
    override func setData(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        let model = GasRemainViewRespModel(jsonString: dataStr)
        if model.isSuccess() {
            _data = model
            setListInfoData(data: _data.record)
            _tblView.reloadData()
            _btnUpdate.isHidden = (_data.record.allow_update == 0)
        } else {
            showAlert(message: model.message)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if _isFirstTime {
            _isFirstTime = false
            return
        }
        requestData()
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
    private func setListInfoData(data: GasRemainBean = GasRemainBean()) {
        self._listInfo.removeAll()
        
        // Created date
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CREATED_DATE_ID,
            name: DomainConst.CONTENT00096,
            iconPath: DomainConst.DATETIME_ICON_IMG_NAME,
            value: data.date_input))
        
        // Customer name
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CUSTOMER_NAME_ID,
            name: data.customer_name,
            iconPath: DomainConst.HUMAN_ICON_IMG_NAME,
            value: DomainConst.BLANK))
        
        // Customer phone
        if !data.customer_phone.isEmpty {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_PHONE_ID,
                name: data.customer_phone,
                iconPath: DomainConst.CONTACT_ICON_IMG_NAME,
                value: DomainConst.BLANK))
        }        
        
        // Customer address
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_ADDRESS_ID,
            name: data.customer_address,
            iconPath: DomainConst.ADDRESS_ICON_IMG_NAME,
            value: DomainConst.BLANK))
        
        // Material name
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_MATERIAL_ID,
            name: DomainConst.CONTENT00556,
            iconPath: DomainConst.CONTENT_ICON_IMG_NAME,
            value: data.materials_name))
        
        // Material seri
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_MATERIAL_SERI_ID,
            name: DomainConst.CONTENT00109,
            iconPath: DomainConst.ORDER_TYPE_ICON_IMG_NAME,
            value: data.name))
        
        // Material gas remain
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_GAS_REMAIN_ID,
            name: DomainConst.CONTENT00557,
            iconPath: DomainConst.ORDER_TYPE_ICON_IMG_NAME,
            value: data.amount_gas))
        
        // Material cylinder
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_GAS_REMAIN_ID,
            name: DomainConst.CONTENT00346,
            iconPath: DomainConst.ORDER_TYPE_ICON_IMG_NAME,
            value: data.amount_empty))
        
        // Material cylinder has gas
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_GAS_REMAIN_ID,
            name: DomainConst.CONTENT00347,
            iconPath: DomainConst.ORDER_TYPE_ICON_IMG_NAME,
            value: data.amount_has_gas))
    }
    /**
     * Handle start create store card
     */
    private func openUpdateScreen() {
        let view = G14F01VC(nibName: G14F01VC.theClassName,
                            bundle: nil)
        view.setData(bean: self._data.record)        
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    // MARK: Request server methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        GasRemainViewRequest.request(action: action,
                                    view: self,
                                    id: self._id)
    }
    
    // MARK: Event handler
    /**
     * Handle finish refresh
     */
    internal func finishHandleRefresh(_ notification: Notification) {
        setData(notification)
        refreshControl.endRefreshing()
    }
    
    /**
     * Handle when tap on save button
     */
    internal func btnUpdateTapped(_ sender: AnyObject) {
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheDataForUpdate(_:)),
                                     view: self)
        } else {
            openUpdateScreen()
        }
    }
    
    /**
     * Handle when finish request cache data for update cashbook
     */
    internal func finishRequestCacheDataForUpdate(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            openUpdateScreen()
        } else {
            showAlert(message: model.message)
        }
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
            height: UIScreen.main.bounds.height - GlobalConst.BUTTON_H - GlobalConst.MARGIN)
        _tblView.addSubview(refreshControl)
        _tblView.dataSource = self
        _tblView.delegate = self
        _tblView.register(ConfigurationTableViewCell.self,
                          forCellReuseIdentifier: ConfigurationTableViewCell.theClassName)
        _tblView.estimatedRowHeight = 44.0
        _tblView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK - Update button
    /**
     * Create update button
     */
    private func createUpdateBtn() {
        CommonProcess.createButtonLayout(
            btn: _btnUpdate,
            x: (UIScreen.main.bounds.width - GlobalConst.BUTTON_W) / 2,
            y: UIScreen.main.bounds.height - GlobalConst.BUTTON_H - GlobalConst.MARGIN,
            text: DomainConst.CONTENT00141,
            action: #selector(btnUpdateTapped(_:)),
            target: self,
            img: DomainConst.RELOAD_IMG_NAME,
            tintedColor: UIColor.white)
        
        _btnUpdate.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                 left: GlobalConst.MARGIN,
                                                 bottom: GlobalConst.MARGIN,
                                                 right: GlobalConst.MARGIN)
        
    }
}


// MARK - Protocol UITableViewDataSource
extension G14F00S02VC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // MARK - To do
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        var font = GlobalConst.BASE_FONT
        var color = UIColor.black
        if data.id == DomainConst.ORDER_INFO_ADDRESS_ID || data.id == DomainConst.ORDER_INFO_CUSTOMER_NAME_ID {
            font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        }
        if data.id == DomainConst.ORDER_INFO_PHONE_ID {
            font = GlobalConst.BASE_BOLD_FONT
            color = GlobalConst.MAIN_COLOR
        }
        cell.textLabel?.font = font
        cell.textLabel?.textColor = color
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = data.getValue()
        cell.detailTextLabel?.font = GlobalConst.BASE_FONT
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _listInfo.count
    }
}

// MARK - Protocol UITableViewDataSource
extension G14F00S02VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {        
        return GlobalConst.CONFIGURATION_ITEM_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = _listInfo[indexPath.row] 
        if data.id == DomainConst.ORDER_INFO_PHONE_ID {
            self.makeACall(phone: data.name.normalizatePhoneString())
        }
    }
}
