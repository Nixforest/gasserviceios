//
//  G12F01S01VC.swift
//  project
//
//  Created by SPJ on 9/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework
import GoogleMaps

class G12F01S01VC: BaseParentViewController {
    // MARK: Properties
    /** Location */
    let locationManager:    CLLocationManager   = CLLocationManager()
    /** Category view */
    var categoryView:           UIView      = UIView()
    /** List of category button */
    var listCategoryButtons:    [UIButton]  = [UIButton]()
    /** Label Order */
    var lblOrder:               UILabel     = UILabel()
    /** Button order */
    var btnOrder:               UIButton    = UIButton()
    /** Button processing */
    var btnProcessing:          UIButton    = UIButton()
    /** Processing view */
    var processingView:         NVActivityIndicatorView? = nil
    /** Button finish */
    var btnFinish:              UIButton    = UIButton()
    /** Explain label */
    var lblExplain:             UILabel     = UILabel()
    /** Processing 1 label */
    var lblProcessing1:         UILabel     = UILabel()
    /** Processing 2 label */
    var lblProcessing2:         UILabel     = UILabel()
    /** Finish 1 label */
    var lblFinish1:             UILabel     = UILabel()
    /** Finish 2 label */
    var lblFinish2:             UILabel     = UILabel()
    /** Finish 3 label */
    var lblFinish3:             UILabel     = UILabel()
    /** Button cancel order */
//    var btnCancelOrder:         CustomButton    = CustomButton(type: UIButtonType.custom)
    var btnCancelOrder:         UIButton    = UIButton(type: UIButtonType.custom)
    /** Button refer */
    var btnRefer:               UIButton    = UIButton()
    /** Actions view */
    var actionsView:            UIView      = UIView()
    /** List of actions button */
    var listActionsButtons:     [UIButton]  = [UIButton]()
    /** List of actions label */
    var listActionsLabels:      [UILabel]   = [UILabel]()
    // Attemp list config
    var listActionsConfig:      [ConfigBean] = [
//        ConfigBean(id: DomainConst.ACTION_TYPE_SELECT_GAS, name: DomainConst.CONTENT00485),
        ConfigBean(id: DomainConst.ACTION_TYPE_SELECT_GAS, name: DomainConst.CONTENT00485),
        ConfigBean(id: DomainConst.ACTION_TYPE_SELECT_PROMOTE, name: DomainConst.CONTENT00486),
        ConfigBean(id: DomainConst.ACTION_TYPE_NONE, name: DomainConst.CONTENT00484),
        ConfigBean(id: DomainConst.ACTION_TYPE_SUPPORT, name: DomainConst.CONTENT00484)
    ]
    /** Address text value */
    var addressText:            String      = DomainConst.BLANK
    /** Flag openned map */
    var isOpenedMap:            Bool        = false
    /** Flag cancel order (By system) */
    var isCancelOrder:          Bool        = false
    /** Mode */
    var mode:                   String      = DomainConst.BLANK
    
    // MARK: Static values
    /** Current position of map view */
    public static var _currentPos       = CLLocationCoordinate2D.init()
    /** Save neares agent information */
    public static var _nearestAgent     = AgentInfoBean()
    /** Material gas select */
    public static var _gasSelected      = MaterialBean()
    /** Material promote select */
    public static var _promoteSelected  = MaterialBean()
    
    // MARK: Constant
    // View mode
    let MODE_ORDER:             String  = DomainConst.NUMBER_ZERO_VALUE
    let MODE_PROCESSING:        String  = DomainConst.NUMBER_ONE_VALUE
    let MODE_FINISH:            String  = DomainConst.NUMBER_TWO_VALUE
    let MODE_MAP:               String  = DomainConst.NUMBER_THREE_VALUE
    let MODE_CANCEL:            String  = DomainConst.NUMBER_FOUR_VALUE
    // Category button
    var CATEGORY_BUTTON_REAL_SIZE_HD    = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_HD
    var CATEGORY_BUTTON_REAL_SIZE_FHD   = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_FHD
    var CATEGORY_BUTTON_REAL_SIZE_FHD_L = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_FHD_L
    
    // Order label
    var ORDER_LABEL_REAL_Y_POS_HD       = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_HD
    var ORDER_LABEL_REAL_Y_POS_FHD      = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_FHD
    var ORDER_LABEL_REAL_Y_POS_FHD_L    = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_FHD_L
    
    // Order button
    var ORDER_BUTTON_REAL_SIZE_HD       = GlobalConst.ORDER_BUTTON_SIZE * BaseViewController.H_RATE_HD
    var ORDER_BUTTON_REAL_SIZE_FHD      = GlobalConst.ORDER_BUTTON_SIZE * BaseViewController.H_RATE_FHD
    var ORDER_BUTTON_REAL_SIZE_FHD_L    = GlobalConst.ORDER_BUTTON_SIZE * BaseViewController.H_RATE_FHD_L
    
    // Category button
    var BUTTON_ACTION_REAL_SIZE_HD    = GlobalConst.BUTTON_ACTION_SIZE * BaseViewController.H_RATE_HD
    var BUTTON_ACTION_REAL_SIZE_FHD   = GlobalConst.BUTTON_ACTION_SIZE * BaseViewController.H_RATE_FHD
    var BUTTON_ACTION_REAL_SIZE_FHD_L = GlobalConst.BUTTON_ACTION_SIZE * BaseViewController.H_RATE_FHD_L
    
    // Order cancel button
    var CANCEL_ORDER_BUTTON_REAL_WIDTH_HD    = GlobalConst.BUTTON_CANCEL_ORDER_WIDTH * BaseViewController.W_RATE_HD
    var CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD   = GlobalConst.BUTTON_CANCEL_ORDER_WIDTH * BaseViewController.W_RATE_FHD
    var CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD_L = GlobalConst.BUTTON_CANCEL_ORDER_WIDTH * BaseViewController.W_RATE_FHD_L
    var CANCEL_ORDER_BUTTON_REAL_HEIGHT_HD    = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * BaseViewController.H_RATE_HD / 2
    var CANCEL_ORDER_BUTTON_REAL_HEIGHT_FHD   = GlobalConst.BUTTON_CANCEL_ORDER_WIDTH * BaseViewController.H_RATE_FHD / 2
    var CANCEL_ORDER_BUTTON_REAL_HEIGHT_FHD_L = GlobalConst.BUTTON_CANCEL_ORDER_WIDTH * BaseViewController.H_RATE_FHD_L / 2
    
    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        self.createNavigationBar(title: "1900 1565")
//        openLogin()
        changeMode(value: MODE_ORDER)
        // Location setting
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            locationManager.startUpdatingLocation()
        }
        showBotMsg(note: DomainConst.CONTENT00495, description: DomainConst.CONTENT00495)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isOpenedMap = false
        updateMaterialSelector()
    }
    
    /**
     * Handle update constants
     */
    override func updateConst() {
        super.updateConst()
        // Category button
        CATEGORY_BUTTON_REAL_SIZE_HD    = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_HD
        CATEGORY_BUTTON_REAL_SIZE_FHD   = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_FHD
        CATEGORY_BUTTON_REAL_SIZE_FHD_L = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_FHD_L
        
        // Order label
        ORDER_LABEL_REAL_Y_POS_HD       = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_HD
        ORDER_LABEL_REAL_Y_POS_FHD      = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_FHD
        ORDER_LABEL_REAL_Y_POS_FHD_L    = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_FHD_L
        
        // Order button
        ORDER_BUTTON_REAL_SIZE_HD       = GlobalConst.ORDER_BUTTON_SIZE * BaseViewController.H_RATE_HD
        ORDER_BUTTON_REAL_SIZE_FHD      = GlobalConst.ORDER_BUTTON_SIZE * BaseViewController.H_RATE_FHD
        ORDER_BUTTON_REAL_SIZE_FHD_L    = GlobalConst.ORDER_BUTTON_SIZE * BaseViewController.H_RATE_FHD_L
        
        // Category button
        BUTTON_ACTION_REAL_SIZE_HD    = GlobalConst.BUTTON_ACTION_SIZE * BaseViewController.H_RATE_HD
        BUTTON_ACTION_REAL_SIZE_FHD   = GlobalConst.BUTTON_ACTION_SIZE * BaseViewController.H_RATE_FHD
        BUTTON_ACTION_REAL_SIZE_FHD_L = GlobalConst.BUTTON_ACTION_SIZE * BaseViewController.H_RATE_FHD_L
        
        // Order cancel button
        CANCEL_ORDER_BUTTON_REAL_WIDTH_HD    = GlobalConst.BUTTON_CANCEL_ORDER_WIDTH * BaseViewController.H_RATE_HD
        CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD   = GlobalConst.BUTTON_CANCEL_ORDER_WIDTH * BaseViewController.H_RATE_FHD
        CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD_L = GlobalConst.BUTTON_CANCEL_ORDER_WIDTH * BaseViewController.H_RATE_FHD_L
        
        CANCEL_ORDER_BUTTON_REAL_HEIGHT_HD    = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * BaseViewController.H_RATE_HD / 2
        CANCEL_ORDER_BUTTON_REAL_HEIGHT_FHD   = GlobalConst.BUTTON_CANCEL_ORDER_WIDTH * BaseViewController.H_RATE_FHD / 2
        CANCEL_ORDER_BUTTON_REAL_HEIGHT_FHD_L = GlobalConst.BUTTON_CANCEL_ORDER_WIDTH * BaseViewController.H_RATE_FHD_L / 2
    }
    
    /**
     * Handle set background image
     */
    override func setBackgroundImage() {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPHONE_IMG_NAME)
            break
        case .pad:
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:
                self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPAD_IMG_NAME)
            case .landscapeLeft, .landscapeRight:
                self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPAD_LANDSCAPE_IMG_NAME)
            default:
                self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPAD_IMG_NAME)
            }
            break
        default:
            self.setBackground(bkg: DomainConst.LOGIN_BKG_IPAD_IMG_NAME)
        }
    }
    
    /**
     * Create children views
     */
    override func createChildrenViews() {
        super.createChildrenViews()
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            createCategoryViewHD()
            createOrderHD()
            createOrderButtonHD()
            createExplainLabel()
            createProcessingLabel()
            createFinishLabel()
            createCancelBtnHD()
            createReferBtnHD()
            createActionsViewHD()
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                createCategoryViewFHD()
                createOrderFHD()
                createOrderButtonFHD()
                createExplainLabel()
                createProcessingLabel()
                createFinishLabel()
                createCancelBtnFHD()
                createReferBtnFHD()
                createActionsViewFHD()
                break
            case .landscapeLeft, .landscapeRight:       // Landscape
                createCategoryViewFHD_L()
                createOrderFHD_L()
                createOrderButtonFHD_L()
                createExplainLabel()
                createProcessingLabel()
                createFinishLabel()
                createCancelBtnFHD_L()
                createReferBtnFHD_L()
                createActionsViewFHD_L()
                break
            default:
                break
            }
            
            break
        default:
            break
        }
        self.view.addSubview(categoryView)
        self.view.addSubview(lblOrder)
        self.view.addSubview(btnOrder)
        self.view.addSubview(btnProcessing)
        self.view.addSubview(btnFinish)
        self.view.addSubview(processingView!)
        self.view.addSubview(lblExplain)
        self.view.addSubview(lblProcessing1)
        self.view.addSubview(lblProcessing2)
        self.view.addSubview(lblFinish1)
        self.view.addSubview(lblFinish2)
        self.view.addSubview(lblFinish3)
        self.view.addSubview(actionsView)
        for i in 0..<listActionsConfig.count {
            if listActionsConfig[i].id != DomainConst.ACTION_TYPE_NONE {
                self.view.addSubview(listActionsLabels[i])
            }
        }
        self.view.addSubview(btnCancelOrder)
        self.view.addSubview(btnRefer)
    }
    
    /**
     * Update children views
     */
    override func updateChildrenViews() {
        super.updateChildrenViews()
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            updateCategoryViewHD()
            updateOrderHD()
            updateOrderButtonHD()
            updateExplainLabel()
            updateProcessingLabel()
            updateFinishLabel()
            updateCancelBtnHD()
            updateReferBtnHD()
            updateActionsViewHD()
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                updateCategoryViewFHD()
                updateOrderFHD()
                updateOrderButtonFHD()
                updateExplainLabel()
                updateProcessingLabel()
                updateFinishLabel()
                updateCancelBtnFHD()
                updateReferBtnFHD()
                updateActionsViewFHD()
                break
            case .landscapeLeft, .landscapeRight:       // Landscape
                updateCategoryViewFHD_L()
                updateOrderFHD_L()
                updateOrderButtonFHD_L()
                updateExplainLabel()
                updateProcessingLabel()
                updateFinishLabel()
                updateCancelBtnFHD_L()
                updateReferBtnFHD_L()
                updateActionsViewFHD_L()
                break
            default:
                break
            }
            
            break
        default:
            break
        }
    }
    
    // MARK: Event handler
    /**
     * Handle when tap on cancel order button
     */
    func btnCancelOrderTapped(_ sender: AnyObject) {
        requestCancelTransaction()
    }
    
    /**
     * Handle when tap on category buttons
     * - parameter sender: Button object
     */
    func enableButton(_ sender: AnyObject) {
        // Handle by button identify
        switch ((sender as! UIButton).accessibilityIdentifier!) {
        case DomainConst.CATEGORY_TYPE_VIP, DomainConst.CATEGORY_TYPE_UTILITY:
            showAlert(message: DomainConst.CONTENT00197)
            return
        case DomainConst.CATEGORY_TYPE_GAS:
            break
        default:
            break
        }
        // Release selection from all button
        for btn in self.listCategoryButtons {
            btn.isSelected = false
        }
        // Select current tapped button
        (sender as! UIButton).isSelected = true
    }
    
    /**
     * Handle when tap on actions buttons
     * - parameter sender: Button object
     */
    func actionsButtonTapped(_ sender: AnyObject) {
        // Handle by button identify
        switch ((sender as! UIButton).accessibilityIdentifier!) {
        case DomainConst.ACTION_TYPE_SELECT_GAS:
            G12F01S03VC.setData(data: G12F01S01VC._nearestAgent.info_gas)
            let s03 = G12F01S03VC(nibName: G12F01S03VC.theClassName, bundle: nil)
            self.navigationController?.pushViewController(s03, animated: true)
            return
        case DomainConst.ACTION_TYPE_SELECT_PROMOTE:
            G12F01S03VC.setData(data: G12F01S01VC._nearestAgent.info_promotion)
            let s04 = G12F01S04VC(nibName: G12F01S04VC.theClassName, bundle: nil)
            self.navigationController?.pushViewController(s04, animated: true)
            return
        case DomainConst.ACTION_TYPE_SUPPORT:
            showAlert(message: "DomainConst.ACTION_TYPE_SUPPORT")
            return
        default:
            break
        }
    }
    
    /**
     * Handle order button tapped event
     */
    internal func btnOrderTapped(_ sender: AnyObject) {
        btnOrder.isEnabled = false
//        requestTransactionComplete()
        requestTransactionStart()
        btnOrder.isEnabled = true
    }
    
    /**
     * Handle processing button tapped event
     */
    internal func btnProcessingTapped(_ sender: AnyObject) {
        changeMode(value: MODE_FINISH)
    }
    
    /**
     * Handle finish button tapped event
     */
    internal func btnFinishTapped(_ sender: AnyObject) {
        openOrderDetail(id: DomainConst.BLANK)
        changeMode(value: MODE_ORDER)
    }
    
    /**
     * Handle when tap on refer button
     */
    func btnReferTapped(_ sender: AnyObject) {
        openPromotion()
    }
    
    /**
     * Handler when transaction status request is finish
     */
//    internal func finishRequestTransactionStatus(_ notification: Notification) {
    internal func finishRequestTransactionStatus(_ model: Any?) {
//        let data = (notification.object as! String)
        let data = (model as! String)
        let model = OrderViewRespModel(jsonString: data)
        if model.isSuccess() {
            let status = checkStatus(order: model.getRecord())
            // If current order status is finish
            if status == MODE_FINISH {
                changeMode(value: status)
//                return
            } else if status == MODE_MAP {  // Current Order status is has a Employee info
                if !isOpenedMap {
                    isOpenedMap = !isOpenedMap
                    openMap(data: model.getRecord())
                    changeMode(value: status)
                }
            } else if status == MODE_PROCESSING {   // Current order status is NEW
                changeMode(value: status)
            } else if status == MODE_CANCEL {
                if !isCancelOrder {
                    isCancelOrder = !isCancelOrder
                    if let currentVC = BaseViewController.getCurrentViewController() {
                    currentVC.showAlert(message: DomainConst.CONTENT00505,
                              okHandler: {
                                alert in
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: G12Const.NOTIFY_NAME_G12_FINISH_ORDER),
                                                                object: nil)
                                BaseModel.shared.setTransactionData(transaction: TransactionBean.init())
                                self.changeMode(value: self.MODE_ORDER)
                                self.requestTransactionStatus(completionHandler: self.finishRequestTransactionStatus)
                                self.isCancelOrder = false
                                return
                    })
                    }
                }
//                showAlert(message: DomainConst.CONTENT00505)
            } else {
                // Chek if order has finish or something wrong
                if model.getRecord().isEmpty() {
                    // Current view mode is not FINISH
                    if self.mode != MODE_FINISH {
                        changeMode(value: MODE_ORDER)
                    }
                }
            }
        }
        requestTransactionStatus(completionHandler: finishRequestTransactionStatus)
    }
    
    /**
     * Handler when transaction complete request is finish
     */
    func finishRequestTransactionComplete(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = OrderTransactionCompleteRespModel(jsonString: data)
        if model.isSuccess() {
            let transactionData = TransactionBean()
            transactionData.id = model.getRecord().transaction_id
            transactionData.name = BaseModel.shared.getTransactionData().name
            BaseModel.shared.setTransactionData(transaction: transactionData)
//            requestTransactionStatus(completionHandler: finishRequestTransactionStatus)
            changeMode(value: MODE_PROCESSING)
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handler when order config request is finish
     */
    internal func finishRequestOrderConfig(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = OrderConfigRespModel(jsonString: data)
        if model.isSuccess() {
            BaseModel.shared.saveOrderConfig(config: model.getRecord())
            // Start update config
            startUpdateConfig()
        } else {
            showAlert(message: model.message)
        }
    }
    /**
     * Finish request update config
     */
    internal func finishRequestUpdateConfig(_ notification: Notification) {
        LoadingView.shared.showOverlay(view: self.view, className: self.theClassName)
        let data = (notification.object as! String)
        let model = LoginRespModel(jsonString: data)
        LoadingView.shared.hideOverlayView(className: self.theClassName)
        if model.isSuccess() {
            BaseModel.shared.saveTempData(loginModel: model)
//            requestTransactionStart()
            updateNearestAgentInfo()
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Finish request start transaction
     */
    internal func finishStartTransaction(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = OrderTransactionStartRespModel(jsonString: data)
        if model.isSuccess() {
            BaseModel.shared.setTransactionData(transaction: model.getRecord())
            requestTransactionComplete()
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle when finish request transaction confirm/cancel
     */
    func finishRequestTransactionCancelHandler(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            BaseModel.shared.setTransactionData(transaction: TransactionBean.init())
            changeMode(value: MODE_ORDER)
//            requestTransactionStart()
        } else {
            showAlert(message: model.message)
        }
    }
    
    // MARK: Utilities
    /**
     * Start logic of screen
     */
    internal func startLogic() {
        // Check if order config does exist
        if BaseModel.shared.getOrderConfig().isExist() {
            // Start update config
            startUpdateConfig()
        } else {
            requestOrderConfig()
        }
        requestTransactionStatus(completionHandler: finishRequestTransactionStatus)
    }
    
    internal func startUpdateConfig() {
        // Check if user is logged in already
        if !BaseModel.shared.checkIsLogin() {
            NotificationCenter.default.addObserver(
                self, selector: #selector(notifyRequestTransactionStart(_:)),
                name: NSNotification.Name(
                    rawValue: G12Const.NOTIFY_NAME_G12_REQUEST_TRANSACTION_START),
                object: nil)
            openLogin()
        } else {
            // Update config
            UpdateConfigurationRequest.requestUpdateConfiguration(
                action: #selector(finishRequestUpdateConfig(_:)),
                view: self)
        }
    }
    
    internal func notifyRequestTransactionStart(_ notification: Notification) {
        print("notifyRequestTransactionStart")
        requestTransactionStart()
    }
    
    private func requestTransactionStart() {
//        if !BaseModel.shared.checkTransactionKey() {
            OrderTransactionStartRequest.requestOrderTransactionStart(
                action: #selector(finishStartTransaction(_:)),
                view: self)
//        }
    }
    
    /**
     * Request transaction status
     * - parameter id: Id of transaction
     */
    private func requestTransactionStatus(completionHandler: ((Any?)->Void)?) {
//        TransactionStatusRequest.request(
//            action: #selector(finishRequestTransactionStatus(_:)),
//            view: self, id: id)
        if !BaseModel.shared.checkIsLogin() {
            return
        }
        TransactionStatusRequest.requestLoop(view: self,
                                             id: BaseModel.shared.getTransactionData().id,
                                             completionHandler: completionHandler)
    }
    
    /**
     * Request transaction complete
     */
    private func requestTransactionComplete() {
        var userInfo = UserInfoBean()
        if let info = BaseModel.shared.user_info {
            userInfo = info
        }
        let orderDetail = String(getOrderDetail().characters.dropLast())
        
        OrderTransactionCompleteRequest.requestOrderTransactionComplete(
            action: #selector(finishRequestTransactionComplete(_:)),
            view: self,
            key:    BaseModel.shared.getTransactionData().name,
            id:     BaseModel.shared.getTransactionData().id,
            devicePhone:    BaseModel.shared.getCurrentUsername(),
            firstName:      userInfo.getName(),
            phone:          userInfo.getPhone(),
            email:          userInfo.getEmail(),
            provinceId:     userInfo.getProvinceId(),
            districtId:     userInfo.getDistrictId(),
            wardId:         userInfo.getWardId(),
            streetId:       userInfo.getStreetId(),
            houseNum:       userInfo.getHouseNumber(),
            note:           DomainConst.BLANK,
            address:        self.addressText,
            orderDetail:    orderDetail,
            lat:            String(G12F01S01VC._currentPos.latitude),
            long:           String(G12F01S01VC._currentPos.longitude),
            agentId:        MapViewController._nearestAgent.info_agent.agent_id,
            transactionType: DomainConst.TRANSACTION_TYPE_NORMAL)
    }
    
    /**
     * Request order config
     */
    private func requestOrderConfig() {
        OrderConfigRequest.requestOrderConfig(
            action: #selector(finishRequestOrderConfig(_:)),
            view: self)
    }
    
    /**
     * Request cancel transaction
     */
    private func requestCancelTransaction() {
        self.showAlert(message: DomainConst.CONTENT00256,
                       okHandler: {
                        (alert: UIAlertAction!) in
                        OrderTransactionCancelRequest.requestOrderTransactionCancel(
                            action: #selector(self.finishRequestTransactionCancelHandler(_:)),
                            view: self)
        },
                       cancelHandler: {
                        (alert: UIAlertAction!) in
        })
    }
    
    /**
     * Update nearest agent information
     */
    private func updateNearestAgentInfo() {
        var distance = Double.greatestFiniteMagnitude
        // Loop for all agent and find nearest agent from current location
        for item in BaseModel.shared.getAgentListFromOrderConfig() {
            // Get lat and long value from agent information
            let lat: CLLocationDegrees = (item.info_agent.agent_latitude as NSString).doubleValue
            let long: CLLocationDegrees = (item.info_agent.agent_longitude as NSString).doubleValue
            let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let currentDist = calculateDistance(pos1: G12F01S01VC._currentPos, pos2: location)
            // Found a nearer agent
            if distance > currentDist {
                G12F01S01VC._nearestAgent = item
                distance = currentDist
            }
        }
        
        // Check if min distance is outside of max range
//        if distance > BaseModel.shared.getMaxRangeDistantFromOrderConfig() {
//            G12F01S01VC._nearestAgent = AgentInfoBean.init()
//        }
        
        // Not found any agent
        if G12F01S01VC._nearestAgent.isEmpty() {
            // Reset selected materials
            G12F01S01VC._gasSelected     = MaterialBean.init()
            G12F01S01VC._promoteSelected = MaterialBean.init()
        } else {    // Found
            // Save selected gas
            if !G12F01S01VC._nearestAgent.info_gas.isEmpty {
                G12F01S01VC._gasSelected = G12F01S01VC._nearestAgent.info_gas[0]
            }
        }
        updateMaterialSelector()
    }
    
    /**
     * Calculate the distance (in meters) from the receiver’s location to the specified location.
     * - parameter pos1: Receiver’s location
     * - parameter pos2: Specified location
     * - returns: This method measures the distance between the two locations by tracing a line between them that follows the curvature of the Earth. The resulting arc is a smooth curve and does not take into account specific altitude changes between the two locations
     */
    private func calculateDistance(pos1: CLLocationCoordinate2D, pos2: CLLocationCoordinate2D) -> Double {
        let position1 = CLLocation(latitude: pos1.latitude, longitude: pos1.longitude)
        let position2 = CLLocation(latitude: pos2.latitude, longitude: pos2.longitude)
        let distance: CLLocationDistance = position1.distance(from: position2)
        return distance
    }
    
    /**
     * Update material selector view data
     */
    private func updateMaterialSelector() {
        // If found nearest agent information
        if !G12F01S01VC._gasSelected.isEmpty() {
            self.listActionsLabels[0].text = G12F01S01VC._gasSelected.material_name
            //            self.listActionsButtons[0].setImage(tinted, for: UIControlState.selected)
        } else {
            self.listActionsLabels[0].text = self.listActionsConfig[0].name
        }
        // If found nearest agent information
        if !G12F01S01VC._promoteSelected.isEmpty() {
            self.listActionsLabels[1].text = G12F01S01VC._promoteSelected.material_name
//            self.listActionsButtons[1].setImage(tinted, for: UIControlState.selected)
        } else {
            self.listActionsLabels[1].text = self.listActionsConfig[1].name
        }
        btnOrder.isEnabled = true
        self.listActionsButtons[0].isEnabled = true
        self.listActionsButtons[1].isEnabled = true
    }
    
    /**
     * Get order detail
     * - returns: Order detail in json format
     */
    private func getOrderDetail() -> String {
        var retVal = DomainConst.BLANK
        if !G12F01S01VC._gasSelected.isEmpty() {
            let detailGas = OrderDetailBean(
                data: G12F01S01VC._gasSelected,
                qty: DomainConst.NUMBER_ONE_VALUE)
            retVal = retVal + detailGas.createJsonData()
        }
        if !G12F01S01VC._promoteSelected.isEmpty() {
            let detailPromote = OrderDetailBean(
                data: G12F01S01VC._promoteSelected,
                qty: DomainConst.NUMBER_ONE_VALUE)
            retVal = retVal + detailPromote.createJsonData()
        }
        return retVal
    }
    
    /**
     * Check status of current order
     * - parameter order: Order data
     * - returns: Mode value
     */
    private func checkStatus(order: OrderBean) -> String {
        // Status is Cancel
        if order.status_number == DomainConst.ORDER_STATUS_CANCEL {
            return MODE_CANCEL
        }
        // Status is Complete
        if order.status_number == DomainConst.ORDER_STATUS_COMPLETE {
            return MODE_FINISH
        }
        
        // Current employee info does exist
        if !order.employee_code.isEmpty {
            return MODE_MAP
        }
        // Status is new
        if order.status_number == DomainConst.ORDER_STATUS_NEW {
            return MODE_PROCESSING
        }
        return DomainConst.BLANK
    }
    
    /**
     * Handle open map view
     */
    private func openMap(data: OrderBean) {
        let mapView = G12F01S02VC(nibName: G12F01S02VC.theClassName, bundle: nil)
        mapView.setData(bean: data)
        self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    private func openOrderDetail(id: String) {
        let view = G12F00S02VC(nibName: G12F00S02VC.theClassName,
                               bundle: nil)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    internal override func openPromotion() {
        let promotionView = G13F00S01VC(nibName: G13F00S01VC.theClassName, bundle: nil)
        self.navigationController?.pushViewController(promotionView, animated: true)
    }
    
    /**
     * Create category view
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func createCategoryView(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.categoryView.frame = CGRect(x: x, y: y, width: w, height: h)
        self.categoryView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        createCategoryContent()
    }
    
    /**
     * Create category content
     */
    private func createCategoryContent() {
        // Attemp list config
        var listConfig = [ConfigBean]()
        listConfig.append(ConfigBean(id: DomainConst.CATEGORY_TYPE_VIP, name: "  VIP"))
        listConfig.append(ConfigBean(id: DomainConst.CATEGORY_TYPE_GAS, name: "  GAS"))
        listConfig.append(ConfigBean(id: DomainConst.CATEGORY_TYPE_UTILITY, name: "PHỤ KIỆN"))
        // Attemp list image
        var listImg = [(String, String)]()
        listImg.append((DomainConst.CATEGORY_VIP_ICON_IMG_NAME, DomainConst.CATEGORY_VIP_ICON_IMG_NAME))
        listImg.append((DomainConst.CATEGORY_GAS_ICON_IMG_NAME, DomainConst.CATEGORY_GAS_ICON_IMG_NAME))
        listImg.append((DomainConst.CATEGORY_DETAIL_ICON_IMG_NAME, DomainConst.CATEGORY_DETAIL_ICON_IMG_NAME))
        let btnWidth = categoryView.frame.height - GlobalConst.MARGIN
        let margin = GlobalConst.MARGIN
        let count = listConfig.count
        let btnSpace    = (UIScreen.main.bounds.width - 2 * margin - btnWidth) / (CGFloat)(count - 1)
        
        for i in 0..<count {
            // Calculate frame of button
            let frame = CGRect(x: margin + CGFloat(i) * btnSpace, y: margin / 2,
                               width: btnWidth,
                               height: btnWidth)
            let btn = CategoryButton(frame: frame, icon: listImg[i].0, iconActive: listImg[i].1, title: listConfig[i].name, id: listConfig[i].id)
            
            btn.addTarget(self, action: #selector(enableButton), for: .touchUpInside)
            // Select default button
            if listConfig[i].id == DomainConst.CATEGORY_TYPE_GAS {
                btn.isSelected = true
            }
            listCategoryButtons.append(btn)
            self.categoryView.addSubview(btn)
        }
    }
    
    /**
     * Update category content
     */
    private func updateCategoryContent() {
        let btnWidth = categoryView.frame.height - GlobalConst.MARGIN
        let margin = GlobalConst.MARGIN
        let count = listCategoryButtons.count
        let btnSpace    = (UIScreen.main.bounds.width - 2 * margin - btnWidth) / (CGFloat)(count - 1)
        
        for i in 0..<count {
            // Calculate frame of button
            listCategoryButtons[i].frame = CGRect(x: margin + CGFloat(i) * btnSpace, y: margin / 2,
                               width: btnWidth,
                               height: btnWidth + GlobalConst.MARGIN)
        }
    }
    
    /**
     * Create category view (in HD mode)
     */
    private func createCategoryViewHD() {
        createCategoryView(x: 0, y: getTopHeight(),
                           w: UIScreen.main.bounds.width,
                           h: CATEGORY_BUTTON_REAL_SIZE_HD)
    }
    
    /**
     * Create category view (in Full HD mode)
     */
    private func createCategoryViewFHD() {
        createCategoryView(x: 0, y: getTopHeight(),
                           w: UIScreen.main.bounds.width,
                           h: CATEGORY_BUTTON_REAL_SIZE_FHD)
    }
    
    /**
     * Create category view (in Full HD Landscape mode)
     */
    private func createCategoryViewFHD_L() {
        createCategoryView(x: 0, y: getTopHeight(),
                           w: UIScreen.main.bounds.width,
                           h: CATEGORY_BUTTON_REAL_SIZE_FHD_L)
    }
    
    /**
     * Update category view (in HD mode)
     */
    private func updateCategoryViewHD() {
        CommonProcess.updateViewPos(view: categoryView,
                                    x: 0, y: getTopHeight(),
                                    w: UIScreen.main.bounds.width,
                                    h: CATEGORY_BUTTON_REAL_SIZE_HD)
        updateCategoryContent()
    }
    
    /**
     * Update category view (in Full HD mode)
     */
    private func updateCategoryViewFHD() {
        CommonProcess.updateViewPos(view: categoryView,
                                    x: 0,
                                    y: getTopHeight(),
                                    w: UIScreen.main.bounds.width,
                                    h: CATEGORY_BUTTON_REAL_SIZE_FHD)
        updateCategoryContent()
    }
    
    /**
     * Update category view (in Full HD Landscape mode)
     */
    private func updateCategoryViewFHD_L() {
        CommonProcess.updateViewPos(view: categoryView,
                                    x: 0,
                                    y: getTopHeight(),
                                    w: UIScreen.main.bounds.width,
                                    h: CATEGORY_BUTTON_REAL_SIZE_FHD_L)
        updateCategoryContent()
    }
    
    /**
     * Create order label
     */
    private func createOrderLabel() {
        lblOrder.text           = DomainConst.CONTENT00130.uppercased()
        lblOrder.textColor      = UIColor.red
        lblOrder.font           = UIFont.boldSystemFont(ofSize: GlobalConst.NOTIFY_FONT_SIZE)
        lblOrder.textAlignment  = .center
    }
    
    private func createOrderHD() {
        createOrderLabel()
        lblOrder.frame = CGRect(x: 0,
                                y: ORDER_LABEL_REAL_Y_POS_HD,
                                width: UIScreen.main.bounds.width,
                                height: GlobalConst.LABEL_H * 2)
        
    }
    
    private func createOrderFHD() {
        createOrderLabel()
        lblOrder.frame = CGRect(x: 0,
                                y: ORDER_LABEL_REAL_Y_POS_FHD,
                                width: UIScreen.main.bounds.width,
                                height: GlobalConst.LABEL_H * 2)
        
    }
    
    private func createOrderFHD_L() {
        createOrderLabel()
        lblOrder.frame = CGRect(x: 0,
                                y: ORDER_LABEL_REAL_Y_POS_FHD_L,
                                width: UIScreen.main.bounds.width,
                                height: GlobalConst.LABEL_H * 2)
        
    }
    
    private func updateOrderHD() {
        CommonProcess.updateViewPos(view: lblOrder,
                                    x: 0, y: ORDER_LABEL_REAL_Y_POS_HD,
                                    w: UIScreen.main.bounds.width,
                                    h: GlobalConst.LABEL_H * 2)
    }
    
    private func updateOrderFHD() {
        CommonProcess.updateViewPos(view: lblOrder,
                                    x: 0, y: ORDER_LABEL_REAL_Y_POS_FHD,
                                    w: UIScreen.main.bounds.width,
                                    h: GlobalConst.LABEL_H * 2)
    }
    
    private func updateOrderFHD_L() {
        CommonProcess.updateViewPos(view: lblOrder,
                                    x: 0, y: ORDER_LABEL_REAL_Y_POS_FHD_L,
                                    w: UIScreen.main.bounds.width,
                                    h: GlobalConst.LABEL_H * 2)
    }
    
    private func createOrderButton(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.btnOrder.frame = CGRect(x: x, y: y, width: w, height: h)
        self.btnOrder.setImage(ImageManager.getImage(named: DomainConst.ORDER_BUTTON_ICON_IMG_NAME),
                               for: UIControlState())
        self.btnOrder.addTarget(self, action: #selector(btnOrderTapped(_:)),
                                for: .touchUpInside)
        self.btnOrder.isEnabled = false
        self.btnProcessing.frame = CGRect(x: x, y: y, width: w, height: h)
        self.btnProcessing.setImage(ImageManager.getImage(named: DomainConst.PROCESSING_BUTTON_ICON_IMG_NAME),
                               for: UIControlState())
        self.btnProcessing.isUserInteractionEnabled = true
        self.btnProcessing.addTarget(self, action: #selector(btnProcessingTapped(_:)),
                                for: .touchUpInside)
        self.processingView = NVActivityIndicatorView(
            frame: btnProcessing.frame,
            type: NVActivityIndicatorType.ballScaleRippleMultiple)
        processingView?.startAnimating()
        let processingViewTappedRecog = UITapGestureRecognizer(
            target: self,
            action: #selector(handlTappedProcessingView(_:)))
        processingView?.addGestureRecognizer(processingViewTappedRecog)
        self.btnFinish.frame = CGRect(x: x, y: y, width: w, height: h)
        self.btnFinish.setImage(ImageManager.getImage(named: DomainConst.FINISH_BUTTON_ICON_IMG_NAME),
                                for: UIControlState())
        self.btnFinish.addTarget(self, action: #selector(btnFinishTapped(_:)),
                                for: .touchUpInside)
    }
    
    internal func handlTappedProcessingView(_ gestureRecognizer: UITapGestureRecognizer) {
//        openMap(data: OrderBean.init())
        changeMode(value: MODE_FINISH)
    }
    
    private func createOrderButtonHD() {
        self.createOrderButton(
            x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_HD) / 2,
            y: lblOrder.frame.maxY + GlobalConst.MARGIN,
            w: ORDER_BUTTON_REAL_SIZE_HD, h: ORDER_BUTTON_REAL_SIZE_HD)
    }
    
    private func createOrderButtonFHD() {
        self.createOrderButton(
            x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_FHD) / 2,
            y: lblOrder.frame.maxY + GlobalConst.MARGIN,
            w: ORDER_BUTTON_REAL_SIZE_FHD, h: ORDER_BUTTON_REAL_SIZE_FHD)
    }
    
    private func createOrderButtonFHD_L() {
        self.createOrderButton(
            x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_FHD_L) / 2,
            y: lblOrder.frame.maxY + GlobalConst.MARGIN,
            w: ORDER_BUTTON_REAL_SIZE_FHD_L, h: ORDER_BUTTON_REAL_SIZE_FHD_L)
    }
    
    private func updateOrderButtonHD() {
        CommonProcess.updateViewPos(view: btnOrder,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_HD) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_HD, h: ORDER_BUTTON_REAL_SIZE_HD)
        CommonProcess.updateViewPos(view: btnProcessing,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_HD) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_HD, h: ORDER_BUTTON_REAL_SIZE_HD)
        CommonProcess.updateViewPos(view: processingView!,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_HD) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_HD, h: ORDER_BUTTON_REAL_SIZE_HD)
        CommonProcess.updateViewPos(view: btnFinish,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_HD) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_HD, h: ORDER_BUTTON_REAL_SIZE_HD)
    }
    
    private func updateOrderButtonFHD() {
        CommonProcess.updateViewPos(view: btnOrder,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_FHD) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_FHD, h: ORDER_BUTTON_REAL_SIZE_FHD)
        CommonProcess.updateViewPos(view: btnProcessing,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_FHD) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_FHD, h: ORDER_BUTTON_REAL_SIZE_FHD)
        CommonProcess.updateViewPos(view: processingView!,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_FHD) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_FHD, h: ORDER_BUTTON_REAL_SIZE_FHD)
        CommonProcess.updateViewPos(view: btnFinish,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_FHD) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_FHD, h: ORDER_BUTTON_REAL_SIZE_FHD)
    }
    
    private func updateOrderButtonFHD_L() {
        CommonProcess.updateViewPos(view: btnOrder,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_FHD_L) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_FHD_L, h: ORDER_BUTTON_REAL_SIZE_FHD_L)
        CommonProcess.updateViewPos(view: btnProcessing,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_FHD_L) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_FHD_L, h: ORDER_BUTTON_REAL_SIZE_FHD_L)
        CommonProcess.updateViewPos(view: processingView!,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_FHD_L) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_FHD_L, h: ORDER_BUTTON_REAL_SIZE_FHD_L)
        CommonProcess.updateViewPos(view: btnFinish,
                                    x: (UIScreen.main.bounds.width - ORDER_BUTTON_REAL_SIZE_FHD_L) / 2,
                                    y: lblOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: ORDER_BUTTON_REAL_SIZE_FHD_L, h: ORDER_BUTTON_REAL_SIZE_FHD_L)
    }
    
    /**
     * Create explain label
     */
    private func createExplainLabel() {
        lblExplain.frame = CGRect(x: 0,
                                y: btnOrder.frame.maxY + GlobalConst.MARGIN,
                                width: UIScreen.main.bounds.width,
                                height: GlobalConst.LABEL_H)
        lblExplain.text           = DomainConst.CONTENT00483
        lblExplain.textColor      = UIColor.black
        lblExplain.font           = GlobalConst.BASE_FONT
        lblExplain.textAlignment  = .center
    }
    
    /**
     * Update login label
     */
    private func updateExplainLabel() {
        CommonProcess.updateViewPos(view: lblExplain,
                                    x: 0,
                                    y: btnOrder.frame.maxY + GlobalConst.MARGIN,
                                    w: UIScreen.main.bounds.width,
                                    h: GlobalConst.LABEL_H)
    }
    
    /**
     * Create actions view
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func createActionsView(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.actionsView.frame = CGRect(x: x, y: y, width: w, height: h)
        self.actionsView.backgroundColor = UIColor(white: 1, alpha: 0.0)
        createActionsViewContent()
    }
    
    /**
     * Create actions view (in HD mode)
     */
    private func createActionsViewHD() {
        createActionsView(x: 0,
                          y: UIScreen.main.bounds.height - 2 * BUTTON_ACTION_REAL_SIZE_HD,
                          w: UIScreen.main.bounds.width,
                          h: BUTTON_ACTION_REAL_SIZE_HD)
    }
    
    /**
     * Create actions view (in Full HD mode)
     */
    private func createActionsViewFHD() {
        createActionsView(x: 0,
                          y: UIScreen.main.bounds.height - 2 * BUTTON_ACTION_REAL_SIZE_FHD,
                          w: UIScreen.main.bounds.width,
                          h: BUTTON_ACTION_REAL_SIZE_FHD)
    }
    
    /**
     * Create actions view (in Full HD Landscape mode)
     */
    private func createActionsViewFHD_L() {
        createActionsView(x: 0,
                          y: UIScreen.main.bounds.height - 2 * BUTTON_ACTION_REAL_SIZE_FHD_L,
                          w: UIScreen.main.bounds.width,
                          h: BUTTON_ACTION_REAL_SIZE_FHD_L)
    }
    
    /**
     * Update actions view (in HD mode)
     */
    private func updateActionsViewHD() {
        CommonProcess.updateViewPos(
            view: actionsView,
            x: 0,
            y: UIScreen.main.bounds.height - 2 * BUTTON_ACTION_REAL_SIZE_HD,
            w: UIScreen.main.bounds.width,
            h: BUTTON_ACTION_REAL_SIZE_HD)
        updateActionsViewContent()
    }
    
    /**
     * Update actions view (in Full HD mode)
     */
    private func updateActionsViewFHD() {
        CommonProcess.updateViewPos(
            view: actionsView,
            x: 0,
            y: UIScreen.main.bounds.height - 2 * BUTTON_ACTION_REAL_SIZE_FHD,
            w: UIScreen.main.bounds.width,
            h: BUTTON_ACTION_REAL_SIZE_FHD)
        updateActionsViewContent()
    }
    
    /**
     * Update actions view (in Full HD Landscape mode)
     */
    private func updateActionsViewFHD_L() {
        CommonProcess.updateViewPos(
            view: actionsView,
            x: 0,
            y: UIScreen.main.bounds.height - 2 * BUTTON_ACTION_REAL_SIZE_FHD_L,
            w: UIScreen.main.bounds.width,
            h: BUTTON_ACTION_REAL_SIZE_FHD_L)
        updateActionsViewContent()
    }
    
    /**
     * Create actions view content
     */
    private func createActionsViewContent() {
        // Attemp list image
        var listImg = [(String, String)]()
        listImg.append((DomainConst.GAS_BUTTON_ICON_IMG_NAME, DomainConst.GAS_BUTTON_ICON_IMG_NAME))
        listImg.append((DomainConst.PROMOTE_BUTTON_ICON_IMG_NAME, DomainConst.PROMOTE_BUTTON_ICON_IMG_NAME))
        listImg.append((DomainConst.SUPPORT_BUTTON_ICON_IMG_NAME, DomainConst.SUPPORT_BUTTON_ICON_IMG_NAME))
        listImg.append((DomainConst.SUPPORT_BUTTON_ICON_IMG_NAME, DomainConst.SUPPORT_BUTTON_ICON_IMG_NAME))
        let btnWidth = actionsView.frame.height - GlobalConst.MARGIN
        let margin = GlobalConst.MARGIN
        let count = listActionsConfig.count
        let btnSpace    = (UIScreen.main.bounds.width - 2 * margin - btnWidth) / (CGFloat)(count - 1)
        var font = UIFont.smallSystemFontSize
        if UIDevice.current.userInterfaceIdiom == .pad {
            font = UIFont.systemFontSize
        }
        let lblHeight = GlobalConst.LABEL_H * 4
        let lblYPos = actionsView.frame.minY + GlobalConst.LABEL_H - lblHeight
        for i in 0..<count {
            // Calculate frame of button
            let frame = CGRect(x: margin + CGFloat(i) * btnSpace,
                               y: margin / 2,
                               width: btnWidth,
                               height: btnWidth)
            let btn = CategoryButton(frame: frame, icon: listImg[i].0, iconActive: listImg[i].1, title: listActionsConfig[i].name, id: listActionsConfig[i].id, font: font, isUpperText: true)
//            self.adjustImageAndTitleOffsetsForButton(button: btn)
            btn.addTarget(self, action: #selector(actionsButtonTapped), for: .touchUpInside)
            let lbl = CustomLabel(frame: CGRect(x: margin + CGFloat(i) * btnSpace,
                                            y: lblYPos,
                                            width: btnWidth,
                                            height: lblHeight))
            lbl.text = listActionsConfig[i].name
            lbl.font = UIFont.systemFont(ofSize: font)
            lbl.textAlignment = .center
            lbl.textColor = UIColor.black
            lbl.lineBreakMode = .byWordWrapping
            lbl.numberOfLines = 0
            listActionsLabels.append(lbl)
            listActionsButtons.append(btn)
            if listActionsConfig[i].id == DomainConst.ACTION_TYPE_SELECT_GAS
                || listActionsConfig[i].id == DomainConst.ACTION_TYPE_SELECT_PROMOTE {
                btn.isEnabled = false
            }
            if listActionsConfig[i].id != DomainConst.ACTION_TYPE_NONE {
                self.actionsView.addSubview(btn)
//                self.actionsView.addSubview(lbl)
//                self.view.addSubview(lbl)
            }
        }
    }
    
    /**
     * Update actions view content
     */
    private func updateActionsViewContent() {
        let btnWidth = actionsView.frame.height - GlobalConst.MARGIN
        let margin = GlobalConst.MARGIN
        let count = listActionsButtons.count
        let btnSpace    = (UIScreen.main.bounds.width - 2 * margin - btnWidth) / (CGFloat)(count - 1)
        
        let lblHeight = GlobalConst.LABEL_H * 4
        let lblYPos = actionsView.frame.minY + GlobalConst.LABEL_H - lblHeight
        for i in 0..<count {
            // Calculate frame of button
            listActionsButtons[i].frame = CGRect(x: margin + CGFloat(i) * btnSpace,
                                                 y: margin / 2,
                                                 width: btnWidth,
                                                 height: btnWidth)
            listActionsLabels[i].frame = CGRect(x: margin + CGFloat(i) * btnSpace,
                                                y: lblYPos,
                                                width: btnWidth,
                                                height: lblHeight)
        }
    }
    
    /**
     * Create label
     * - parameter label:   Lable view
     * - parameter offset:  Y offset
     * - parameter text:    Lable content
     * - parameter color:   Color of text
     * - parameter isBold:  Flag is bold or not
     */
    private func createLabel(label: UILabel, offset: CGFloat, text: String, color: UIColor = UIColor.black, isBold: Bool = false) {
        label.frame = CGRect(x: 0,
                             y: offset,
                             width: UIScreen.main.bounds.width,
                             height: GlobalConst.LABEL_H)
        label.text          = text
        label.textColor     = color
        if isBold {
            label.font      = GlobalConst.BASE_BOLD_FONT
        } else {
            label.font      = UIFont.italicSystemFont(ofSize: GlobalConst.BASE_FONT_SIZE)
        }
        label.textAlignment  = .center
    }
    
    /**
     * Update label
     * - parameter label:   Lable view
     * - parameter offset:  Y offset
     */
    private func updateLabel(label: UILabel, offset: CGFloat) {
        CommonProcess.updateViewPos(view: label,
                                    x: 0,
                                    y: offset,
                                    w: UIScreen.main.bounds.width,
                                    h: GlobalConst.LABEL_H)
    }
    
    /**
     * Create group label
     */
    private func createProcessingLabel() {
        self.createLabel(label: lblProcessing1,
                         offset: btnProcessing.frame.maxY + GlobalConst.MARGIN,
                         text: DomainConst.CONTENT00487)
        self.createLabel(label: lblProcessing2,
                         offset: lblProcessing1.frame.maxY + GlobalConst.MARGIN,
                         text: DomainConst.CONTENT00488)
    }
    
    /**
     * Update group label
     */
    private func updateProcessingLabel() {
        self.updateLabel(label: lblProcessing1,
                         offset: btnProcessing.frame.maxY + GlobalConst.MARGIN)
        self.updateLabel(label: lblProcessing2,
                         offset: lblProcessing1.frame.maxY + GlobalConst.MARGIN)
        
    }
    
    /**
     * Create cancel order button
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func createCancelOrderBtn(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        btnCancelOrder.frame = CGRect(x: x, y: y, width: w, height: GlobalConst.LABEL_H)
        btnCancelOrder.setTitle(DomainConst.CONTENT00320, for: UIControlState())
        btnCancelOrder.setTitleColor(UIColor.red, for: UIControlState())
        btnCancelOrder.titleLabel?.font = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
        btnCancelOrder.backgroundColor = UIColor(white: 1, alpha: 0.0)
        btnCancelOrder.addTarget(self, action: #selector(btnCancelOrderTapped(_:)), for: .touchUpInside)
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            btnCancelOrder.setImage(ImageManager.getImage(named: DomainConst.CANCEL_ORDER_BUTTON_ICON_IMG_NAME), for: UIControlState())
//        } else {
//            btnCancelOrder.leftImage(image: ImageManager.getImage(named: DomainConst.CANCEL_ORDER_BUTTON_ICON_IMG_NAME)!)
//        }
        btnCancelOrder.setImage(ImageManager.getImage(named: DomainConst.CANCEL_ORDER_BUTTON_ICON_IMG_NAME), for: UIControlState())
        
        btnCancelOrder.imageView?.contentMode = .scaleAspectFit
//        btnCancelOrder.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    /**
     * Create facebook button (in HD mode)
     */
    private func createCancelBtnHD() {
        self.createCancelOrderBtn(
            x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_HD) / 2,
            y: lblProcessing2.frame.maxY + GlobalConst.MARGIN,
            w: CANCEL_ORDER_BUTTON_REAL_WIDTH_HD,
            h: CANCEL_ORDER_BUTTON_REAL_HEIGHT_HD)
    }
    
    /**
     * Create facebook button (in Full HD mode)
     */
    private func createCancelBtnFHD() {
        self.createCancelOrderBtn(
            x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD) / 2,
            y: lblProcessing2.frame.maxY + GlobalConst.MARGIN,
            w: CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD,
            h: CANCEL_ORDER_BUTTON_REAL_HEIGHT_FHD)
    }
    
    /**
     * Create facebook button (in Full HD Landscape mode)
     */
    private func createCancelBtnFHD_L() {
        self.createCancelOrderBtn(
            x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD_L) / 2,
            y: lblProcessing2.frame.maxY + GlobalConst.MARGIN,
            w: CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD_L,
            h: CANCEL_ORDER_BUTTON_REAL_HEIGHT_FHD_L)
    }
    
    /**
     * Update facebook button (in HD mode)
     */
    private func updateCancelBtnHD() {
        CommonProcess.updateViewPos(view: btnCancelOrder,
            x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_HD) / 2,
            y: lblProcessing2.frame.maxY + GlobalConst.MARGIN,
            w: CANCEL_ORDER_BUTTON_REAL_WIDTH_HD,
            h: GlobalConst.LABEL_H)
    }
    
    /**
     * Update facebook button (in Full HD mode)
     */
    private func updateCancelBtnFHD() {
        CommonProcess.updateViewPos(view: btnCancelOrder,
            x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD) / 2,
            y: lblProcessing2.frame.maxY + GlobalConst.MARGIN,
            w: CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD,
            h: GlobalConst.LABEL_H)
    }
    
    /**
     * Update facebook button (in Full HD Landscape mode)
     */
    private func updateCancelBtnFHD_L() {
        CommonProcess.updateViewPos(view: btnCancelOrder,
            x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD_L) / 2,
            y: lblProcessing2.frame.maxY + GlobalConst.MARGIN,
            w: CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD_L,
            h: GlobalConst.LABEL_H)
    }
    
    /**
     * Create group label
     */
    private func createFinishLabel() {
        self.createLabel(label: lblFinish1,
                         offset: btnFinish.frame.maxY + GlobalConst.MARGIN,
                         text: DomainConst.CONTENT00489.uppercased(),
                         color: UIColor.red,
                         isBold: true)
        self.createLabel(label: lblFinish2,
                         offset: lblFinish1.frame.maxY + GlobalConst.MARGIN,
                         text: DomainConst.CONTENT00490)
        self.createLabel(label: lblFinish3,
                         offset: lblFinish2.frame.maxY + GlobalConst.MARGIN,
                         text: DomainConst.CONTENT00491)
    }
    
    /**
     * Update group label
     */
    private func updateFinishLabel() {
        self.updateLabel(label: lblFinish1,
                         offset: btnFinish.frame.maxY + GlobalConst.MARGIN)
        self.updateLabel(label: lblFinish2,
                         offset: lblFinish1.frame.maxY + GlobalConst.MARGIN)
        self.updateLabel(label: lblFinish3,
                         offset: lblFinish2.frame.maxY + GlobalConst.MARGIN)
        
    }
    
    /**
     * Create refer button
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func createReferBtn(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        btnRefer.frame = CGRect(x: x, y: y, width: w,
                                height: GlobalConst.LABEL_H * 3)
        btnRefer.setTitle(DomainConst.CONTENT00492.uppercased(), for: UIControlState())
        btnRefer.setTitleColor(UIColor.red, for: UIControlState())
        btnRefer.titleLabel?.font = UIFont.boldSystemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
        btnRefer.titleLabel?.lineBreakMode = .byWordWrapping
        btnRefer.titleLabel?.textAlignment = .center
        btnRefer.backgroundColor = UIColor.clear
        btnRefer.layer.borderColor = UIColor.red.cgColor
        btnRefer.layer.borderWidth = 1
        btnRefer.addTarget(self, action: #selector(btnReferTapped(_:)), for: .touchUpInside)
    }
    
    /**
     * Create refer button (in HD mode)
     */
    private func createReferBtnHD() {
        self.createReferBtn(
            x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_HD) / 2,
            y: lblFinish3.frame.maxY + GlobalConst.MARGIN,
            w: CANCEL_ORDER_BUTTON_REAL_WIDTH_HD,
            h: CANCEL_ORDER_BUTTON_REAL_HEIGHT_HD * 3)
    }
    
    /**
     * Create refer button (in Full HD mode)
     */
    private func createReferBtnFHD() {
        self.createReferBtn(
            x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD) / 2,
            y: lblFinish3.frame.maxY + GlobalConst.MARGIN,
            w: CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD,
            h: CANCEL_ORDER_BUTTON_REAL_HEIGHT_FHD * 3)
    }
    
    /**
     * Create refer button (in Full HD Landscape mode)
     */
    private func createReferBtnFHD_L() {
        self.createReferBtn(
            x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD_L) / 2,
            y: lblFinish3.frame.maxY + GlobalConst.MARGIN,
            w: CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD_L,
            h: CANCEL_ORDER_BUTTON_REAL_HEIGHT_FHD_L * 3)
    }
    
    /**
     * Update refer button (in HD mode)
     */
    private func updateReferBtnHD() {
        CommonProcess.updateViewPos(view: btnRefer,
                                    x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_HD) / 2,
                                    y: lblFinish3.frame.maxY + GlobalConst.MARGIN,
                                    w: CANCEL_ORDER_BUTTON_REAL_WIDTH_HD,
                                    h: GlobalConst.LABEL_H * 3)
    }
    
    /**
     * Update refer button (in Full HD mode)
     */
    private func updateReferBtnFHD() {
        CommonProcess.updateViewPos(view: btnRefer,
                                    x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD) / 2,
                                    y: lblFinish3.frame.maxY + GlobalConst.MARGIN,
                                    w: CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD,
                                    h: GlobalConst.LABEL_H * 3)
    }
    
    /**
     * Update refer button (in Full HD Landscape mode)
     */
    private func updateReferBtnFHD_L() {
        CommonProcess.updateViewPos(view: btnRefer,
                                    x: (UIScreen.main.bounds.width - CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD_L) / 2,
                                    y: lblFinish3.frame.maxY + GlobalConst.MARGIN,
                                    w: CANCEL_ORDER_BUTTON_REAL_WIDTH_FHD_L,
                                    h: GlobalConst.LABEL_H * 3)
    }
    
    /**
     * Change screen mode
     * - parameter mode: Mode of string
     */
    private func changeMode(value: String) {
        self.mode = value
        switch value {
        case MODE_ORDER:                    // Order mode
            showHideProcessingMode(isShow: false)
            showHideFinishMode(isShow: false)
            showHideOrderMode(isShow: true)
            setBotMsgContent(note: DomainConst.CONTENT00495, description: DomainConst.CONTENT00495)
            break
        case MODE_PROCESSING:               // Processing mode
            showHideOrderMode(isShow: false)
            showHideFinishMode(isShow: false)
            showHideProcessingMode(isShow: true)
            setBotMsgContent(note: DomainConst.CONTENT00496, description: DomainConst.CONTENT00496)
            break
        case MODE_FINISH:                   // Finish mode
            showHideOrderMode(isShow: false)
            showHideProcessingMode(isShow: false)
            showHideFinishMode(isShow: true)
            setBotMsgContent(note: DomainConst.CONTENT00497, description: DomainConst.CONTENT00497)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: G12Const.NOTIFY_NAME_G12_FINISH_ORDER),
                                            object: nil)
            BaseModel.shared.setTransactionData(transaction: TransactionBean.init())
            break
        default:
            break
        }
    }
    
    /**
     * Show/hide children views in order mode
     * - parameter isShow: Flag show or hide
     */
    private func showHideOrderMode(isShow: Bool) {
        lblOrder.isHidden = !isShow
        btnOrder.isHidden = !isShow
        lblExplain.isHidden = !isShow
        for i in 0..<listActionsConfig.count {
            if listActionsConfig[i].id == DomainConst.ACTION_TYPE_SELECT_GAS
                || listActionsConfig[i].id == DomainConst.ACTION_TYPE_SELECT_PROMOTE {
                listActionsButtons[i].isHidden = !isShow
                listActionsLabels[i].isHidden = !isShow
            }
        }
    }
    
    /**
     * Show/hide children views in processing mode
     * - parameter isShow: Flag show or hide
     */
    private func showHideProcessingMode(isShow: Bool) {
        btnProcessing.isHidden = !isShow
        processingView?.isHidden = !isShow
        lblProcessing1.isHidden = !isShow
        lblProcessing2.isHidden = !isShow
        btnCancelOrder.isHidden = !isShow
        for i in 0..<listActionsConfig.count {
            if listActionsConfig[i].id == DomainConst.ACTION_TYPE_SELECT_GAS
                || listActionsConfig[i].id == DomainConst.ACTION_TYPE_SELECT_PROMOTE {
                listActionsButtons[i].isHidden = isShow
                listActionsLabels[i].isHidden = isShow
            }
        }
    }
    
    /**
     * Show/hide children views in finish mode
     * - parameter isShow: Flag show or hide
     */
    private func showHideFinishMode(isShow: Bool) {
        btnFinish.isHidden = !isShow
        lblFinish1.isHidden = !isShow
        lblFinish2.isHidden = !isShow
        lblFinish3.isHidden = !isShow
        btnRefer.isHidden = !isShow
        for i in 0..<listActionsConfig.count {
            listActionsButtons[i].isHidden = isShow
            listActionsLabels[i].isHidden = isShow
        }
    }
}

// MARK: Protocol - NVActivityIndicatorViewable
extension G12F01S01VC: NVActivityIndicatorViewable {
    
}

// MARK: Protocol - CLLocationManagerDelegate
extension G12F01S01VC: CLLocationManagerDelegate {
    /**
     * Tells the delegate that new location data is available.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        if let location: CLLocation = locations.last {
            // Save current location
//            G12F01S01VC._currentPos = location.coordinate
            G12F01S01VC._currentPos = CLLocationCoordinate2D(latitude: 10.819258114124, longitude: 106.724750036821)
            self.startLogic()
            GMSGeocoder().reverseGeocodeCoordinate(location.coordinate, completionHandler: {
                (response, error) in
                if error != nil, response == nil {
                    return
                }
                // Get Address
                if let result = response?.firstResult() {
                    if let lines = result.lines {
                        self.addressText = lines.joined(separator: DomainConst.ADDRESS_SPLITER)
                    }
                }
            })
        }
    }
    
    /**
     * Tells the delegate that the authorization status for the application changed.
     */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    /**
     * Tells the delegate that the location manager was unable to retrieve a location value.
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }
}
