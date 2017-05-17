//
//  G07F00S02VC.swift
//  project
//
//  Created by SPJ on 4/10/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G07F00S02VC: ChildViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: Properties
    /** Id */
    public static var _id:          String                      = DomainConst.BLANK
    /** Bottom view */
    private var _bottomView:        UIView                      = UIView()
    /** Information table view */
    @IBOutlet weak var _tableView:  UITableView!
    /** List of information data */
    private var _listInfo:          [[ConfigurationModel]]      = [[ConfigurationModel]]()
    /** List material bean */
    private var _listMaterials:     [OrderDetailBean]           = [OrderDetailBean]()
    /** Current data */
    private var _data:              OrderFamilyViewRespModel    = OrderFamilyViewRespModel()
    /** Type when open a model VC */
    private let TYPE_NONE:              String = DomainConst.NUMBER_ZERO_VALUE
    private let TYPE_PROMOTE:           String = "1"
    private let TYPE_CYLINDER:          String = "2"
    private let TYPE_OTHERMATERIAL:     String = "3"
    private let TYPE_PROMOTE_ADD:       String = "4"
    private let TYPE_CYLINDER_ADD:      String = "5"
    private let TYPE_OTHERMATERIAL_ADD: String = "6"
    //++ BUG0088-SPJ (NguyenPT 20170516) Can change gas material
    private let TYPE_GAS:               String = "7"
    //-- BUG0088-SPJ (NguyenPT 20170516) Can change gas material
    /** Current type when open model VC */
    private var _type:              String                  = DomainConst.NUMBER_ZERO_VALUE
    /** Height of bottom view */
    private let bottomHeight:       CGFloat                 = 2 * (GlobalConst.BUTTON_H + GlobalConst.MARGIN)
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        if !G07F00S02VC._id.isEmpty {
            OrderFamilyViewRequest.request(action: action, view: self, id: G07F00S02VC._id)
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
    
    // MARK: Override from UIViewController
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        createNavigationBar(title: DomainConst.CONTENT00232)
        var offset: CGFloat = getTopHeight()
        
        // Information table view
        _tableView.translatesAutoresizingMaskIntoConstraints = true
        _tableView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.SCREEN_HEIGHT - bottomHeight)
        _tableView.allowsMultipleSelectionDuringEditing = false
        _tableView.addSubview(refreshControl)
        offset = offset + _tableView.frame.height + GlobalConst.MARGIN
        self.view.addSubview(_tableView)
        
        // Create list info
        _listInfo.append([ConfigurationModel]())
        _listInfo.append([ConfigurationModel]())
        _listInfo.append([ConfigurationModel]())
        
        // Bottom view
        _bottomView.frame = CGRect(x: 0, y: GlobalConst.SCREEN_HEIGHT - bottomHeight,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: bottomHeight)
        _bottomView.isHidden = true
        self.view.addSubview(_bottomView)
        createBottomView()
        self.view.makeComponentsColor()
//        // Add search button to navigation bar
//        self.createRightNavigationItem(title: "+",
//                                       action: #selector(addNewMaterialButtonTapped(_:)),
//                                       target: self)
        
        // Request data froms server
        if !G07F00S02VC._id.isEmpty {
            OrderFamilyViewRequest.request(action: #selector(setData(_:)), view: self, id: G07F00S02VC._id)
        }
    }
    
    /**
     * Notifies the view controller that its view is about to be added to a view hierarchy.
     */
    override func viewWillAppear(_ animated: Bool) {
        // Check if table view has selected rows
        if (_tableView.indexPathForSelectedRow != nil) {
            // Get selected row index
            let selectedRow = (_tableView.indexPathForSelectedRow?.row)!
            
            switch _type {
            case TYPE_PROMOTE, TYPE_CYLINDER, TYPE_OTHERMATERIAL, TYPE_GAS:                  // Change material
                // Not select promotion material
                if MaterialSelectViewController.getSelectedItem().isEmpty() {
                    // Remove data
                    removeMaterial(at: selectedRow)
                    // Remove cell
                    _tableView.deleteRows(at: _tableView.indexPathsForSelectedRows!, with: .fade)
                } else {    // Change promotion material
                    // Update data
                    updateMaterial(at: selectedRow, material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                    // Reload table with section 1
                    //++ BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
                    //_tableView.reloadSections(IndexSet(integersIn: 1...1), with: .fade)
                    _tableView.reloadData()
                    //-- BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
                }
                //btnSaveTapped(self)
            case TYPE_PROMOTE_ADD, TYPE_CYLINDER_ADD, TYPE_OTHERMATERIAL_ADD:              // Add material
                if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                    // Add data
                    appendMaterial(material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                    // Reload table with section 1,2
                    //++ BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
                    //_tableView.reloadSections(IndexSet(integersIn: 1...2), with: .fade)
                    _tableView.reloadData()
                    //-- BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
                }
                //btnSaveTapped(self)
            default:
                break
            }
        } else {
            switch _type {
            case TYPE_PROMOTE_ADD, TYPE_CYLINDER_ADD, TYPE_OTHERMATERIAL_ADD:              // Add material
                if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                    // Add data
                    appendMaterial(material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                    // Reload table with section 1,2
                    //++ BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
                    //_tableView.reloadSections(IndexSet(integersIn: 1...2), with: .fade)
                    _tableView.reloadData()
                    //-- BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
                }
                //btnSaveTapped(self)
            default:
                break
            }
        }
    }
    
    /**
     * Sent to the view controller when the app receives a memory warning.
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
                self._bottomView.isHidden = false
                
                _tableView.frame = CGRect(x: 0,
                                          y: 0,
                                          width: GlobalConst.SCREEN_WIDTH,
                                          height: GlobalConst.SCREEN_HEIGHT - bottomHeight)
            } else {
                self._bottomView.isHidden = true
                
                _tableView.frame = CGRect(x: 0,
                                          y: 0,
                                          width: GlobalConst.SCREEN_WIDTH,
                                          height: GlobalConst.SCREEN_HEIGHT)
            }
            // Reload data in table view
            //++ BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
            //self._tableView.reloadData()
            DispatchQueue.main.async {
                self._tableView.reloadData()
            }
            //-- BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
        }
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
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
                    y: botOffset,
                    //++ BUG0085-SPJ (NguyenPT 20170515) Change label of Action button on Order Family detail screen
                    //title: DomainConst.CONTENT00318,
                    title: DomainConst.CONTENT00311,
                    //-- BUG0085-SPJ (NguyenPT 20170515) Change label of Action button on Order Family detail screen
                    icon: DomainConst.CONFIRM_IMG_NAME, color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnActionHandler(_:)))
        setupButton(button: btnCancel, x: GlobalConst.SCREEN_WIDTH / 2,
                    y: botOffset, title: DomainConst.CONTENT00220,
                    icon: DomainConst.CANCEL_IMG_NAME, color: GlobalConst.BUTTON_COLOR_YELLOW,
                    action: #selector(btnCancelHandler(_:)))
        _bottomView.addSubview(btnAction)
        _bottomView.addSubview(btnCancel)
    }
    
    // MARK: Handle events
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
            orderDetail: orderDetail.joined(separator: DomainConst.SPLITER_TYPE2))
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
            orderDetail: orderDetail.joined(separator: DomainConst.SPLITER_TYPE2))
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
    
    //++ BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
    /**
     * Handle when tap support type
     */
    internal func updateSupportType() {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00370,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
        for item in BaseModel.shared.getListSupportTypes() {
            let action = UIAlertAction(title: item.name,
                                       style: .default, handler: {
                                        action in
                                        self.handleUpdateSupportOrder(id: item.id)
            })
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle change support type
     * - parameter id: Id of support type
     */
    internal func handleUpdateSupportOrder(id: String) {
        if id != _data.getRecord().support_id {
            _data.getRecord().support_id = id
            for item in _listInfo[2] {  // Loop in section 2 data
                if item.id == DomainConst.ORDER_INFO_SUPPORT_TYPE_ID {  // Support item
                    if (_data.getRecord().support_id != DomainConst.NUMBER_ZERO_VALUE) {    // Support type is not default
                        // Update value
                        item.updateData(id: DomainConst.ORDER_INFO_SUPPORT_TYPE_ID,
                                        name: DomainConst.CONTENT00370,
                                        iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                                        value: BaseModel.shared.getSupportNameById(id: id))
                    } else {        // Default value
                        // Update value
                        item.updateData(
                            id: DomainConst.ORDER_INFO_SUPPORT_TYPE_ID,
                            name: BaseModel.shared.getSupportNameById(id: _data.getRecord().support_id),
                            iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                            value: DomainConst.BLANK)
                    }
                    break
                }
            }
            _tableView.reloadData()
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
        self.present(alert, animated: true, completion: nil)
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
                                        iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                                        value: DomainConst.BLANK)
                    } else {        // Default value
                        // Update value
                        item.updateData(id: DomainConst.ORDER_INFO_ORDER_TYPE_ID,
                                        name: DomainConst.CONTENT00371,
                                        iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                                        value: BaseModel.shared.getOrderTypeNameById(id: id))
                    }
                    break
                }
            }
            _tableView.reloadData()
        }
    }
    //-- BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
    
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
        alert.addAction(cancel)
        alert.addAction(promotion)
        alert.addAction(cylinder)
        alert.addAction(other)
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
        //++ BUG0088-SPJ (NguyenPT 20170516) Can change gas material
        case TYPE_GAS:
            MaterialSelectViewController.setMaterialData(data: BaseModel.shared.getAgentMaterialGas(agentId: _data.getRecord().agent_id))
            self.pushToView(name: G07F01S02VC.theClassName)
        //-- BUG0088-SPJ (NguyenPT 20170516) Can change gas material
        default:
            break
        }
    }
    
    // MARK: Utility methods
    
    /**
     * Get number of element in list info
     * - returns: Number of element in list info
     */
    private func getCountOfInfo() -> Int {
        var retVal = 0
        for item in _listInfo {
            for _ in item {
                retVal += 1
            }
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
    }
    
    /**
     * Set update data for list material infor
     */
    private func setupListMaterialInfo() {
        _listInfo[1].removeAll()
        _listMaterials.removeAll()
        
        // Add materials to table
        for item in _data.getRecord().order_detail {
            appendMaterial(material: item)
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
                iconPath: DomainConst.ADD_ICON_IMG_NAME, value: DomainConst.BLANK))
        }
        
        //++ BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
        if BaseModel.shared.isNVGNUser() {      // User is NVGN
            if (_data.getRecord().support_id != DomainConst.NUMBER_ZERO_VALUE) {
                _listInfo[2].append(ConfigurationModel(
                    id: DomainConst.ORDER_INFO_SUPPORT_TYPE_ID,
                    name: DomainConst.CONTENT00370,
                    iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                    value: _data.getRecord().support_text))
            } else {        // Default value
                if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
                    _listInfo[2].append(ConfigurationModel(
                        id: DomainConst.ORDER_INFO_SUPPORT_TYPE_ID,
                        name: BaseModel.shared.getSupportNameById(id: _data.getRecord().support_id),
                        iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                        value: DomainConst.BLANK))
                }
            }
        } else if !BaseModel.shared.isCustomerUser() {  // User is not customer
            if (_data.getRecord().support_id != DomainConst.NUMBER_ZERO_VALUE) {
                _listInfo[2].append(ConfigurationModel(
                    id: DomainConst.ORDER_INFO_SUPPORT_TYPE_ID,
                    name: DomainConst.CONTENT00370,
                    iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                    value: _data.getRecord().support_text))
            }
        }
        //-- BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
        
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
        // Bu vo
        if !_data.getRecord().amount_bu_vo.isEmpty
            && _data.getRecord().amount_bu_vo != DomainConst.NUMBER_ZERO_VALUE {
            _listInfo[2].append(ConfigurationModel(
                id: DomainConst.AGENT_BUVO_ID, name: DomainConst.CONTENT00246,
                iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                value: DomainConst.PLUS_SPLITER + _data.getRecord().amount_bu_vo + DomainConst.VIETNAMDONG))
        }
        //++ BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
        if _data.getRecord().order_type != DomainConst.NUMBER_ONE_VALUE {    // Order type is not default
            var orderTypeAmount = DomainConst.BLANK
            if !_data.getRecord().order_type_amount.isEmpty
                && _data.getRecord().order_type_amount != DomainConst.NUMBER_ZERO_VALUE {
                orderTypeAmount = DomainConst.PLUS_SPLITER + _data.getRecord().order_type_amount
            }
            _listInfo[2].append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_ORDER_TYPE_ID,
                name: _data.getRecord().order_type_text,
                iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                value: orderTypeAmount))
        } else {        // Default value
            if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
                _listInfo[2].append(ConfigurationModel(
                    id: DomainConst.ORDER_INFO_ORDER_TYPE_ID,
                    name: DomainConst.CONTENT00371,
                    iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                    value: BaseModel.shared.getOrderTypeNameById(id: _data.getRecord().order_type)))
            }
        }
        //-- BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
        
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
     * Remove material
     * - parameter at: Index
     */
    private func removeMaterial(at: Int) {
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
                _listMaterials[at] = material
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
            }
        }
    }
    
    /**
     * Insert material at tail
     * - parameter material: Data to update
     */
    private func appendMaterial(material: OrderDetailBean) {
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
            _listInfo[1].append(ConfigurationModel(orderDetail: material))
            _listMaterials.append(material)
        } else {
            // Found -> Update quantity
            if let qtyNumber = Int(_listMaterials[idx].qty) {
                _listMaterials[idx].qty = String(qtyNumber + 1)
                _listInfo[1][idx] = ConfigurationModel(orderDetail: _listMaterials[idx])
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */
    // MARK: - UITableViewDataSource-Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return _listInfo.count
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
        return _listInfo[section].count
    }
    
    /**
     * Set content of row in table view
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var retCell = UITableViewCell()
        if tableView == _tableView {
            ConfigurationTableViewCell.PARENT_WIDTH = GlobalConst.SCREEN_WIDTH
            let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.CONFIGURATION_TABLE_VIEW_CELL,
                                                     for: indexPath) as! ConfigurationTableViewCell
            cell.resetHighligh()
            switch indexPath.section {
            case 0:     // First section
                if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_PHONE_ID {
                    // Highlight phone number
                    cell.highlightValue()
                }
                break
            case 1:     // Material section
                //++ BUG0088-SPJ (NguyenPT 20170516) Can change gas material
                cell.setData(data: _listInfo[indexPath.section][indexPath.row], isShowFullValue: true)
                cell.setNeedsDisplay()
                return cell
                //-- BUG0088-SPJ (NguyenPT 20170516) Can change gas material
            case 2:     // Third section
                if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_TOTAL_MONEY_ID {
                    // Highlight total money
                    cell.highlightValue()
                }
                if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_MATERIAL_ADD_NEW
                    || (!_listInfo[indexPath.section][indexPath.row].isNotMaterial()) {
                    cell.highlightName()
                }
                if (_listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_SUPPORT_TYPE_ID) {
                    if _data.getRecord().support_id == DomainConst.NUMBER_ZERO_VALUE {
                        cell.highlightName()
                    } else {
                        // Highlight total money
                        if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
                            cell.highlightValue()
                        }
                    }
                }
                if (_listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_ORDER_TYPE_ID) {
                    // Highlight total money
                    if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
                        cell.highlightValue()
                    }
                }
                break
            default:
                break
            }
            cell.setData(data: _listInfo[indexPath.section][indexPath.row])
            cell.setNeedsDisplay()
            
            retCell = cell
        }
        
        return retCell
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.CONFIGURATION_TABLE_VIEW_CELL,
                                                 for: indexPath) as! ConfigurationTableViewCell
        if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_MATERIAL_ADD_NEW && (self._data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE) {
            self.addNewMaterialButtonTapped(cell)
        }
        if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_PHONE_ID {
            self.makeACall(phone: _listInfo[indexPath.section][indexPath.row].getValue().normalizatePhoneString())
        }
        if indexPath.section == 1 && (self._data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE) {
            let data = _listMaterials[indexPath.row]
            if data.isPromotion() {
                self.selectMaterial(type: TYPE_PROMOTE,
                                    data: data)
            } else if data.isCylinder() {
                self.selectMaterial(type: TYPE_CYLINDER,
                                    data: data)
            } else if !data.isGas() {
                self.selectMaterial(type: TYPE_OTHERMATERIAL,
                                    data: data)
            }
        }
        if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_SUPPORT_TYPE_ID
            && (self._data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE) {
            self.updateSupportType()
        }
        
        if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_ORDER_TYPE_ID
            && (self._data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE) {
            self.updateOrderType()
        }
        //++ BUG0088-SPJ (NguyenPT 20170516) Can change gas material
        if indexPath.section == 1 {
            if _listMaterials[indexPath.row].isGas()
                && (self._data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE) {
                selectMaterial(type: TYPE_GAS, data: _listMaterials[indexPath.row])
            }
        }
        //-- BUG0088-SPJ (NguyenPT 20170516) Can change gas material
    }
    
    /**
     * Asks the data source to verify that the given row is editable.
     */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            if _listMaterials[indexPath.row].isGas() {
                return false
            }
            if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
                return true
            }
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
                            self._tableView.deleteRows(at: [indexPath],
                                                       with: .fade)
                            //self.btnSaveTapped(self)
            },
                           cancelHandler: {
                            (alert: UIAlertAction!) in
            })
        default:
            break
        }
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
}
