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
//    private var _listMaterials:     [OrderDetailBean]           = [OrderDetailBean]()
    private var _listMaterials:     [OrderVIPDetailBean]        = [OrderVIPDetailBean]()
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
    //++ BUG0117-SPJ (NguyenPT 20170629) Can Add/Change/Delete Gas Family Order
    private let TYPE_GAS_ADD:           String = "8"
    //-- BUG0117-SPJ (NguyenPT 20170629) Can Add/Change/Delete Gas Family Order
    private let TYPE_CYLINTER_UPDATE:   String = "9"
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
    //++ BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
    /** Save button */
    private var btnSave:            UIButton                = UIButton()
    /** Action button */
    private var btnAction:          UIButton                = UIButton()
    /** Cancel button */
    private var btnCancel:          UIButton                = UIButton()
    //++ BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
//    /** Create ticket button */
//    private var _btnTicket:         UIButton                = UIButton()
    /** Other actions button */
    private var _btnOtherAction:    UIButton                = UIButton()
    //-- BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
    //-- BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
    //++ BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
    private var _customerModel:     CustomerFamilyBean      = CustomerFamilyBean()
    //-- BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
    
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
        //++ BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
        //_bottomView.isHidden = true
        //-- BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
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
            case TYPE_PROMOTE_ADD, TYPE_CYLINDER_ADD, TYPE_OTHERMATERIAL_ADD, TYPE_GAS_ADD:              // Add material
                if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                    let orderVIP = OrderVIPDetailBean(orderDetail: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                    // Add data
//                    appendMaterial(material: OrderVIPDetailBean(orderDetail: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem())))
                    appendMaterial(material: orderVIP)
                    // Reload table with section 1,2
                    //++ BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
                    //_tableView.reloadSections(IndexSet(integersIn: 1...2), with: .fade)
                    _tableView.reloadData()
                    //-- BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
//                    if MaterialSelectViewController.getSelectedItem().isCylinder() {
//                        updateCylinderInfo(bean: orderVIP)
//                    }
                }
                //btnSaveTapped(self)
            case TYPE_CYLINTER_UPDATE:
                // Update data
                updateMaterial(at: selectedRow, material: _listMaterials[selectedRow])
                _tableView.reloadData()
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
        _type = DomainConst.NUMBER_ZERO_VALUE
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
                //++ BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
                //self._bottomView.isHidden = false
                showHideBottomView(isShow: true)
                
//                _tableView.frame = CGRect(x: 0,
//                                          y: 0,
//                                          width: GlobalConst.SCREEN_WIDTH,
//                                          height: GlobalConst.SCREEN_HEIGHT - bottomHeight)
                //-- BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
            } else {
                //++ BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
                //self._bottomView.isHidden = true
                showHideBottomView(isShow: false)
                
//                _tableView.frame = CGRect(x: 0,
//                                          y: 0,
//                                          width: GlobalConst.SCREEN_WIDTH,
//                                          height: GlobalConst.SCREEN_HEIGHT)
                //-- BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
            }
            
            _tableView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: GlobalConst.SCREEN_WIDTH,
                                      height: GlobalConst.SCREEN_HEIGHT - bottomHeight)
            //++ BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
//            btnSave.isEnabled = (_data.getRecord().show_button_save == DomainConst.NUMBER_ONE_VALUE)
//            btnAction.isEnabled = (_data.getRecord().show_button_complete == DomainConst.NUMBER_ONE_VALUE)
            //-- BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
            
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
        button.setImage(ImageManager.getImage(named: icon), for: UIControlState())
        button.addTarget(self, action: action, for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                              left: GlobalConst.MARGIN,
                                              bottom: GlobalConst.MARGIN,
                                              right: GlobalConst.MARGIN)
    }
    
    //++ BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
    /**
     * Handle show/hide bottom view
     * - parameter isShow: True is show bottom view, False is hide
     */
    private func showHideBottomView(isShow: Bool) {
        if isShow {
            btnSave.isEnabled = (_data.getRecord().show_button_save == DomainConst.NUMBER_ONE_VALUE)
            btnAction.isEnabled = (_data.getRecord().show_button_complete == DomainConst.NUMBER_ONE_VALUE)
            btnCancel.isEnabled = _data.getRecord().show_button_cancel.isON()
        } else {
            btnCancel.isEnabled = false
            btnSave.isEnabled = false
            btnAction.isEnabled = false
        }
    }
    //-- BUG0118-SPJ (NguyenPT 20170629) Make Ticket always show on order
    
    /**
     * Create bottom view
     */
    private func createBottomView() {
        var botOffset: CGFloat = 0.0
        // Create save button
        //++ BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
//        let btnSave = UIButton()
//        CommonProcess.createButtonLayout(
//            btn: btnSave, x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2, y: botOffset,
//            text: DomainConst.CONTENT00086, action: #selector(btnSaveTapped(_:)), target: self,
//            img: DomainConst.SAVE_ICON_IMG_NAME, tintedColor: UIColor.white)
//        
//        btnSave.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
//                                              left: GlobalConst.MARGIN,
//                                              bottom: GlobalConst.MARGIN,
//                                              right: GlobalConst.MARGIN)
        setupButton(button: btnSave, x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                    y: botOffset, title: DomainConst.CONTENT00086,
                    icon: DomainConst.SAVE_ICON_IMG_NAME, color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnSaveTapped(_:)))
        _bottomView.addSubview(btnSave)
        //++ BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
//        setupButton(button: _btnTicket, x:  GlobalConst.SCREEN_WIDTH / 2,
//                    y: botOffset, title: DomainConst.CONTENT00402,
//                    icon: DomainConst.TICKET_ICON_IMG_NAME,
//                    color: GlobalConst.BUTTON_COLOR_YELLOW,
//                    action: #selector(btnCreateTicketTapped(_:)))
        //        _bottomView.addSubview(_btnTicket)
        // Other action button
        setupButton(button: _btnOtherAction, x: GlobalConst.SCREEN_WIDTH / 2,
                    y: botOffset, title: "Tác vụ khác",
                    icon: DomainConst.OTHER_TASK_ICON_IMG_NAME, color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnOtherActionTapped(_:)))
        _bottomView.addSubview(_btnOtherAction)
        //-- BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
        botOffset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        //-- BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
        
        // Button action
        //++ BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
//        let btnAction = UIButton()
//        let btnCancel = UIButton()
        //-- BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
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
    //++ BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
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
        //++ BUG0133-SPJ (NguyenPT 20170724) Family order: change agent delivery
        if _data.getRecord().show_button_change_agent == 1 {
            let updateAgent = UIAlertAction(title: DomainConst.CONTENT00458,
                                               style: .default, handler: {
                                                action in
                                                self.handleUpdateAgent()
            })
            alert.addAction(updateAgent)
        }
        //-- BUG0133-SPJ (NguyenPT 20170724) Family order: change agent delivery
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
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = _bottomView
            presenter.sourceRect = _bottomView.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    //++ BUG0133-SPJ (NguyenPT 20170724) Family order: change agent delivery
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
    //-- BUG0133-SPJ (NguyenPT 20170724) Family order: change agent delivery
    
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
    //-- BUG0119-SPJ (NguyenPT 20170630) Handle update customer in Order Family
    
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
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = _bottomView
            presenter.sourceRect = _bottomView.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Open create ticket view controller
     * - parameter id: Id of ticket handler
     */
    internal func handleCreateTicket(id: String) {
        G11F01VC._handlerId = id
        G11F01S01._selectedValue.content = String.init(format: "Đơn hàng HGĐ - %@ - %@ - %@\n",
                    _data.getRecord().created_date,
                    _data.getRecord().code_no,
                    _data.getRecord().first_name)
//        G11F01S01._selectedValue.content = "Đơn hàng HGĐ - "
//            + _data.getRecord().created_date + " - "
//            + _data.getRecord().code_no + " - "
//            + _data.getRecord().first_name + "\n"
        self.pushToView(name: G11F01VC.theClassName)
        
    }
    //-- BUG0103-SPJ (NguyenPT 20170606) Handle action buttons
    
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
            //++ BUG0111-SPJ (NguyenPT 20170617) Update function G06
            ccsCode: _data.getRecord().ccsCode)
            //-- BUG0111-SPJ (NguyenPT 20170617) Update function G06
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
            orderDetail: orderDetail.joined(separator: DomainConst.SPLITER_TYPE2),
            //++ BUG0111-SPJ (NguyenPT 20170617) Update function G06
            ccsCode: _data.getRecord().ccsCode)
            //-- BUG0111-SPJ (NguyenPT 20170617) Update function G06
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
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = _bottomView
            presenter.sourceRect = _bottomView.bounds
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
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = _bottomView
            presenter.sourceRect = _bottomView.bounds
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
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = _bottomView
            presenter.sourceRect = _bottomView.bounds
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
        //++ BUG0117-SPJ (NguyenPT 20170629) Can Add/Change/Delete Gas Family Order
        let gas = UIAlertAction(title: DomainConst.CONTENT00333,
                                  style: .default, handler: {
                                    action in
                                    self.selectMaterial(type: self.TYPE_GAS_ADD)
        })
        alert.addAction(gas)
        //-- BUG0117-SPJ (NguyenPT 20170629) Can Add/Change/Delete Gas Family Order
        
        alert.addAction(cancel)
        alert.addAction(promotion)
        alert.addAction(cylinder)
        alert.addAction(other)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = sender as! UITableViewCell
            presenter.sourceRect = sender.bounds
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
        //++ BUG0088-SPJ (NguyenPT 20170516) Can change gas material
        case TYPE_GAS, TYPE_GAS_ADD:
            //++ BUG0151-SPJ (NguyenPT 20170819) Handle favourite when select material
//            MaterialSelectViewController.setMaterialData(data: BaseModel.shared.getAgentMaterialGas(agentId: _data.getRecord().agent_id))
            MaterialSelectViewController.setMaterialDataFromFavourite(key: DomainConst.KEY_SETTING_FAVOURITE_GAS)
            //-- BUG0151-SPJ (NguyenPT 20170819) Handle favourite when select material
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
        
        //++ BUG0114-SPJ (NguyenPT 20170624) Add note field
        if !_data.getRecord().note.isBlank {
            _listInfo[0].append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_NOTE_ID, name: _data.getRecord().note,
                iconPath: DomainConst.PROBLEM_TYPE_IMG_NAME, value: DomainConst.BLANK))
        }
        //-- BUG0114-SPJ (NguyenPT 20170624) Add note field
        
        //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        // CCS code
        _listInfo[0].append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CCS_CODE_ID, name: DomainConst.CONTENT00445,
            iconPath: DomainConst.CCS_CODE_ICON_IMG_NAME, value: _data.getRecord().ccsCode))
        //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
    }
    
    /**
     * Set update data for list material infor
     */
    private func setupListMaterialInfo() {
        _listInfo[1].removeAll()
        _listMaterials.removeAll()
        
        // Add materials to table
        for item in _data.getRecord().order_detail {
            //++ BUG0125-SPJ (NguyenPT 20170712) Handle input quantity of material when edit Family Customer Order
            //appendMaterial(material: item)
            appendMaterial(material: item, isUpdateQty: false)
            //-- BUG0125-SPJ (NguyenPT 20170712) Handle input quantity of material when edit Family Customer Order
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
        
        //++ BUG0079-SPJ (NguyenPT 20170509) Add order type and support type in Family order
//        if BaseModel.shared.isNVGNUser() {      // User is NVGN
//            if (_data.getRecord().support_id != DomainConst.NUMBER_ZERO_VALUE) {
//                _listInfo[2].append(ConfigurationModel(
//                    id: DomainConst.ORDER_INFO_SUPPORT_TYPE_ID,
//                    name: DomainConst.CONTENT00370,
//                    iconPath: DomainConst.MONEY_ICON_IMG_NAME,
//                    value: _data.getRecord().support_text))
//            } else {        // Default value
//                if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
//                    _listInfo[2].append(ConfigurationModel(
//                        id: DomainConst.ORDER_INFO_SUPPORT_TYPE_ID,
//                        name: BaseModel.shared.getSupportNameById(id: _data.getRecord().support_id),
//                        iconPath: DomainConst.MONEY_ICON_IMG_NAME,
//                        value: DomainConst.BLANK))
//                }
//            }
//        } else if !BaseModel.shared.isCustomerUser() {  // User is not customer
//            if (_data.getRecord().support_id != DomainConst.NUMBER_ZERO_VALUE) {
//                _listInfo[2].append(ConfigurationModel(
//                    id: DomainConst.ORDER_INFO_SUPPORT_TYPE_ID,
//                    name: DomainConst.CONTENT00370,
//                    iconPath: DomainConst.MONEY_ICON_IMG_NAME,
//                    value: _data.getRecord().support_text))
//            }
//        }
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
//                _listMaterials[at] = material
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
     * Insert material at tail
     * - parameter material: Data to update
     */
//    private func appendMaterial(material: OrderDetailBean, isUpdateQty: Bool = true) {
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
//            _listInfo[1].append(ConfigurationModel(orderDetail: material))
            if material.isCylinder() {
                _listInfo[1].append(ConfigurationModel(orderVIPDetail: material))
            } else {
                _listInfo[1].append(ConfigurationModel(orderDetail: material))
            }
            _listMaterials.append(material)
            //++ BUG0125-SPJ (NguyenPT 20170712) Handle input quantity
//            if isUpdateQty {
            if isUpdateQty && !material.isCylinder() {
                updateQtyMaterial(idx: _listMaterials.count - 1)
            } else {
                
            }
            //-- BUG0125-SPJ (NguyenPT 20170712) Handle input quantity
        } else {
            // Found -> Update quantity
            //++ BUG0125-SPJ (NguyenPT 20170712) Handle input quantity
//            if let qtyNumber = Int(_listMaterials[idx].qty) {
//                _listMaterials[idx].qty = String(qtyNumber + 1)
//                _listInfo[1][idx] = ConfigurationModel(orderDetail: _listMaterials[idx])
            //            }
//            if isUpdateQty {
            if isUpdateQty && !material.isCylinder() {
                updateQtyMaterial(idx: idx)
            } else {
                
            }
            //-- BUG0125-SPJ (NguyenPT 20170712) Handle input quantity
        }
    }
    
    //++ BUG0125-SPJ (NguyenPT 20170712) Handle input quantity
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
                self._tableView.reloadRows(at: [IndexPath(item: idx, section: 1)], with: .automatic)
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
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = _bottomView
            presenter.sourceRect = _bottomView.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    //-- BUG0125-SPJ (NguyenPT 20170712) Handle input quantity
    
    private func updateQtyCylinder(bean: OrderVIPDetailBean) {
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
                
                self._tableView.reloadData()
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = _bottomView
            presenter.sourceRect = _bottomView.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
    /**
     * Update value of ccs code
     */
    private func updateCCSCode() {
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
                self._tableView.reloadData()
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
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = _bottomView
            presenter.sourceRect = _bottomView.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code

    // MARK: Logic
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ConfigurationTableViewCell.PARENT_WIDTH = GlobalConst.SCREEN_WIDTH
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DomainConst.CONFIGURATION_TABLE_VIEW_CELL,
            for: indexPath) as! ConfigurationTableViewCell
        cell.resetHighligh()
        let data = _listInfo[indexPath.section][indexPath.row]
        switch indexPath.section {
        case 0:             // First section - Basic info
            switch data.id {
            case DomainConst.ORDER_INFO_PHONE_ID,
                 DomainConst.ORDER_INFO_CCS_CODE_ID:
                cell.highlightValue()
                break
            default: break
            }
            cell.setData(data: data)
            cell.setNeedsDisplay()
            break
        case 1:             // Second section - Material info
            cell.setData(data: data, isShowFullValue: true)
            cell.setNeedsDisplay()
            break
        case 2:             // Third section - Billing info
            switch data.id {
            case DomainConst.ORDER_INFO_TOTAL_MONEY_ID:
                cell.highlightValue()
                break
            case DomainConst.ORDER_INFO_MATERIAL_ADD_NEW:
                cell.highlightName()
            case DomainConst.ORDER_INFO_ORDER_TYPE_ID:
                // Highlight total money
                if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
                    cell.highlightValue()
                }
                break
            default: 
                if !data.isNotMaterial() {
                    cell.highlightName()
                }
                break
            }
            cell.setData(data: data, isShowFullValue: true)
            cell.setNeedsDisplay()
            break
        default:
            break
        }
        return cell
    }
    /**
     * Set content of row in table view
     */
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var retCell = UITableViewCell()
//        if tableView == _tableView {
//            ConfigurationTableViewCell.PARENT_WIDTH = GlobalConst.SCREEN_WIDTH
//            let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.CONFIGURATION_TABLE_VIEW_CELL,
//                                                     for: indexPath) as! ConfigurationTableViewCell
//            cell.resetHighligh()
//            switch indexPath.section {
//            case 0:     // First section
//                if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_PHONE_ID {
//                    // Highlight phone number
//                    cell.highlightValue()
//                }
//                //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
//                if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_CCS_CODE_ID  {
//                    // Highlight CCS code
//                    cell.highlightValue()
//                }
//                //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
//                break
//            case 1:     // Material section
//                //++ BUG0088-SPJ (NguyenPT 20170516) Can change gas material
//                cell.setData(data: _listInfo[indexPath.section][indexPath.row], isShowFullValue: true)
//                cell.setNeedsDisplay()
////                let data = _listInfo[indexPath.section][indexPath.row]
////                let cell = UITableViewCell(style: .default, reuseIdentifier: DomainConst.CONFIGURATION_TABLE_VIEW_CELL)
////                cell.textLabel?.text = data.getValue()
////                cell.textLabel?.font = GlobalConst.BASE_FONT
//                return cell
//                //-- BUG0088-SPJ (NguyenPT 20170516) Can change gas material
//            case 2:     // Third section
//                if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_TOTAL_MONEY_ID {
//                    // Highlight total money
//                    cell.highlightValue()
//                }
//                if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_MATERIAL_ADD_NEW
//                    || (!_listInfo[indexPath.section][indexPath.row].isNotMaterial()) {
//                    cell.highlightName()
//                }
////                if (_listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_SUPPORT_TYPE_ID) {
////                    if _data.getRecord().support_id == DomainConst.NUMBER_ZERO_VALUE {
////                        cell.highlightName()
////                    } else {
////                        // Highlight total money
////                        if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
////                            cell.highlightValue()
////                        }
////                    }
////                }
//                if (_listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_ORDER_TYPE_ID) {
//                    // Highlight total money
//                    if _data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE {
//                        cell.highlightValue()
//                    }
//                }
//                break
//            default:
//                break
//            }
//            cell.setData(data: _listInfo[indexPath.section][indexPath.row])
//            cell.setNeedsDisplay()
//            
//            retCell = cell
//        }
//        
//        return retCell
//    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = _listInfo[indexPath.section][indexPath.row]
        switch indexPath.section {
        case 0:     // Section 0
            break
        case 1:     // Section 1
            if !data.isNotMaterial() {
                let material = _listMaterials[indexPath.row]
                if material.isCylinder() {
                    self.updateCylinderInfo(bean: material)
                    return
                }
            }
            
            break
        case 2:     // Section 2
            break
        default:
            break
        }
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
//        if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_SUPPORT_TYPE_ID
//            && (self._data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE) {
//            self.updateSupportType()
//        }
        
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
        
        //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_CCS_CODE_ID && (self._data.getRecord().allow_update == DomainConst.NUMBER_ONE_VALUE) {
            self.updateCCSCode()
        }
        //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        
        //++ BUG0114-SPJ (NguyenPT 20170624) Add note field
        if _listInfo[indexPath.section][indexPath.row].id == DomainConst.ORDER_INFO_NOTE_ID {
            self.showAlert(message: _data.getRecord().note)
        }
        //-- BUG0114-SPJ (NguyenPT 20170624) Add note field
    }
    
    /**
     * Asks the data source to verify that the given row is editable.
     */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            //++ BUG0117-SPJ (NguyenPT 20170629) Can Add/Change/Delete Gas Family Order
//            if _listMaterials[indexPath.row].isGas() {
//                return false
//            }
            //-- BUG0117-SPJ (NguyenPT 20170629) Can Add/Change/Delete Gas Family Order
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
