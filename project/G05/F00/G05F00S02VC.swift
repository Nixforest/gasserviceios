//
//  G05F00S02VC.swift
//  project
//
//  Created by SPJ on 2/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

//++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
//class G05F00S02VC: BaseViewController, UITableViewDataSource, UITableViewDelegate {
class G05F00S02VC: ChildViewController, UITableViewDataSource, UITableViewDelegate {
//-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
    // MARK: Properties
    /** Id */
    public static var _id:          String               = DomainConst.BLANK
    /** Parent view */
    private var _scrollView:        UIScrollView         = UIScrollView()
    /** Information table view */
    @IBOutlet weak var _tableView:  UITableView!
    /** Customer name label */
    private var _lblCustomerName:   UILabel              = UILabel()
    /** List of information data */
    private var _listInfo:          [ConfigurationModel] = [ConfigurationModel]()
    /** Segment control */
    private var _segment:           UISegmentedControl   = UISegmentedControl(items: [DomainConst.CONTENT00253, DomainConst.CONTENT00263])
    //++ BUG0149-SPJ (NguyenPT 20170811) Handle show Gas remain and Sum all cylinder
//    /** Order information view */
//    private var _viewOrderInfo:     UIView               = UIView()
//    /** Order cylinder information view */
//    private var _viewOrderCylinderInfo: UIView           = UIView()
    //-- BUG0149-SPJ (NguyenPT 20170811) Handle show Gas remain and Sum all cylinder
    /** Material table view */
    @IBOutlet weak var _tblViewGas: UITableView!
    /** Cylinder table view */
    @IBOutlet weak var _tblViewCylinder: UITableView!
    /** List of material information */
    private var _listMaterial: [[(String, Int)]]         = [[(String, Int)]]()
    /** List of cylinder information */
    private var _listCylinder: [[(String, Int)]]         = [[(String, Int)]]()
    /** Note textview */
    private var _tbxNote: UITextView                     = UITextView()
    //++ BUG0149-SPJ (NguyenPT 20170727) Handle sum all cylinders
    private var _listCylinderOption: [ConfigurationModel] = [ConfigurationModel]()
//    private let _sumCylinder:       ConfigurationModel   = ConfigurationModel(
//        id: DomainConst.ORDER_INFO_MATERIAL_SUM_ALL_CYLINDER,
//        name: DomainConst.CONTENT00218,
//        iconPath: DomainConst.SUM_ICON_IMG_NAME,
//        value: DomainConst.BLANK)
    /** Data */
    private var _data:              OrderVIPCreateRespModel = OrderVIPCreateRespModel()
    //-- BUG0149-SPJ (NguyenPT 20170727) Handle sum all cylinders
    //++ BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
    /** List of information Material String */
    private var _listMaterialString:          [String] = [String]()
    /** List of information Gas String */
    private var _listGasString:          [String] = [String]()
    //-- BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
    
    // MARK: Methods
    /**
     * Setup list of materials
     */
    func setupListMaterial(data: OrderVIPBean = OrderVIPBean()) {
        _listMaterial.removeAll()
        createMaterialTableHeader()
        for item in data.info_gas {
            let materialValue: [(String, Int)] = [
                (item.material_name, G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.0),
                (item.qty, G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.1),
                (item.qty_real, G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.2)
            ]
            _listMaterial.append(materialValue)
        }
        var offset: CGFloat = _segment.frame.maxY
        _tblViewGas.frame = CGRect(x: 0, y: offset,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: CGFloat(_listMaterial.count + _listGasString.count + 1) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        
        _listCylinder.removeAll()
        createCylinderTableHeader()
        for item in data.info_vo {
            var gasdu = DomainConst.BLANK
            //++ BUG0070-SPJ (NguyenPT 20170426) Handle convert String -> Int
//            if !item.kg_has_gas.isEmpty && !item.kg_empty.isEmpty{
//                gasdu = String(Int(item.kg_has_gas)! - Int(item.kg_empty)!)
//            }
            //++ BUG0149-SPJ (NguyenPT 20170811) Handle show Gas remain and Sum all cylinder
//            if let kgGas = Int(item.kg_has_gas), let kgEmpty = Int(item.kg_empty) {
//                gasdu = String(kgGas - kgEmpty)
//            }
            if !item.kg_has_gas.isEmpty && !item.kg_empty.isEmpty {
                let fKgGas = (item.kg_has_gas as NSString).floatValue
                let fKgEmpty = (item.kg_empty as NSString).floatValue
                gasdu = String(fKgGas - fKgEmpty)
            }
            //-- BUG0149-SPJ (NguyenPT 20170811) Handle show Gas remain and Sum all cylinder
            //-- BUG0070-SPJ (NguyenPT 20170426) Handle convert String -> Int
            let cylinderValue: [(String, Int)] = [
                //++ BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
                (item.material_name, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.0),
                (item.qty,           G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.1),
                (item.seri,          G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.2),
                (item.kg_empty,      G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.3),
                (item.kg_has_gas,    G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.4),
                (gasdu,              G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.5)
                //-- BUG0135-SPJ (NguyenPT 20170727) Add new cylinder with quantity
            ]
            self._listCylinder.append(cylinderValue)
        }
        _tblViewCylinder.frame = CGRect(x: 0, y: offset,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: CGFloat(_listCylinder.count + _listCylinderOption.count + _listMaterialString.count + 1) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        var height = _tblViewGas.frame.height
        if _listMaterial.count < _listCylinder.count {
            height = _tblViewCylinder.frame.height
        }
        offset = offset + height + GlobalConst.MARGIN
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
     * Create header data for material table
     */
    func createMaterialTableHeader() {
        let materialHeader: [(String, Int)] = [
            (DomainConst.CONTENT00333,  G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.0),
            (DomainConst.CONTENT00255,  G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.1),
            (DomainConst.CONTENT00334,  G05Const.TABLE_COLUME_WEIGHT_GAS_INFO.2)
        ]
        self._listMaterial.append(materialHeader)
    }
    
    /**
     * Create header data for material table
     */
    func createCylinderTableHeader() {
        let cylinderHeader: [(String, Int)] = [
            (DomainConst.CONTENT00335, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.0),
            (DomainConst.CONTENT00415, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.1),
            (DomainConst.CONTENT00466, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.2),
            (DomainConst.CONTENT00337, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.3),
            (DomainConst.CONTENT00338, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.4),
            (DomainConst.CONTENT00339, G05Const.TABLE_COLUME_WEIGHT_CYLINDER_INFO.5)
        ]
        self._listCylinder.append(cylinderHeader)
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
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_ID_ID,
                                            name: DomainConst.CONTENT00257,
                                            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
                                            value: DomainConst.ORDER_CODE_PREFIX + data.code_no))
        var status = DomainConst.CONTENT00328
        if !data.status_number.isEmpty {
            status = getStatusString(status: data.status_number)
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
        //++ BUG0086-SPJ (NguyenPT 20170530) Add phone
        // Contact
        if !data.customer_contact.isEmpty {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_CONTACT_ID,
                name: data.customer_contact,
                iconPath: DomainConst.PHONE_IMG_NAME,
                value: DomainConst.BLANK))
        }
        //-- BUG0086-SPJ (NguyenPT 20170530) Add phone
        
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
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_GAS_DU_ID,
                                            name: DomainConst.CONTENT00261,
                                            iconPath: DomainConst.MONEY_ICON_GREY_IMG_NAME,
                                            value: DomainConst.SPLITER_TYPE1 + data.total_gas_du + DomainConst.VIETNAMDONG))
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_TOTAL_MONEY_ID,
                                            name: DomainConst.CONTENT00262,
                                            iconPath: DomainConst.MONEY_ICON_PAPER_IMG_NAME,
                                            value: data.grand_total + DomainConst.VIETNAMDONG))
        
        //updateLayout(data: data)
    }
    
    internal func segmentChange(_ sender: AnyObject) {
        switch _segment.selectedSegmentIndex {
        //++ BUG0149-SPJ (NguyenPT 20170811) Handle show Gas remain and Sum all cylinder
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
        //-- BUG0149-SPJ (NguyenPT 20170811) Handle show Gas remain and Sum all cylinder
        default:
             break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //++ BUG0057-SPJ (NguyenPT 20170414) Handle notification VIP customer order
        if G05F00S02VC._id.isEmpty {
            G05F00S02VC._id = BaseModel.shared.sharedString
        }
        //-- BUG0057-SPJ (NguyenPT 20170414) Handle notification VIP customer order
        //++ BUG0060-SPJ (NguyenPT 20170421) Change name of request
        //OrderVIPViewRequest.requestOrderVIPView(action: #selector(setData(_:)), view: self, id: G05F00S02VC._id)
        OrderVIPViewRequest.request(action: #selector(setData(_:)), view: self, id: G05F00S02VC._id)
        //-- BUG0060-SPJ (NguyenPT 20170421) Change name of request

        // Do any additional setup after loading the view.
        setupListInfo()
        var offset: CGFloat = 0.0
        
        _scrollView.translatesAutoresizingMaskIntoConstraints = true
        _scrollView.frame = CGRect(
            x: 0,
            y: 0,
            width: GlobalConst.SCREEN_WIDTH,
            height: GlobalConst.SCREEN_HEIGHT)
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
        _segment.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.BUTTON_H)
        _segment.setTitleTextAttributes([NSFontAttributeName: font],
                                        for: UIControlState())
        _segment.selectedSegmentIndex = 0
        _segment.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        _segment.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        _segment.tintColor = GlobalConst.BUTTON_COLOR_RED
        _segment.addTarget(self, action: #selector(segmentChange(_:)), for: .valueChanged)
        offset = offset + _segment.frame.height + GlobalConst.MARGIN
        self._scrollView.addSubview(_segment)
        
        // Order information view
        //++ BUG0149-SPJ (NguyenPT 20170811) Handle show Gas remain and Sum all cylinder
//        _viewOrderInfo.addSubview(_tblViewGas)
//        _viewOrderCylinderInfo.addSubview(_tblViewCylinder)
//        _viewOrderInfo.isHidden = false
//        _viewOrderCylinderInfo.isHidden = true
//        _scrollView.addSubview(_viewOrderInfo)
//        _scrollView.addSubview(_viewOrderCylinderInfo)
//        offset = offset + _viewOrderInfo.frame.height + GlobalConst.MARGIN
        _tblViewGas.isHidden = false
        _tblViewCylinder.isHidden = true
        _scrollView.addSubview(_tblViewGas)
        _scrollView.addSubview(_tblViewCylinder)
        offset = offset + _tblViewGas.frame.height + GlobalConst.MARGIN
        _tblViewCylinder.allowsSelection = true
        //_listCylinderOption.append(_sumCylinder)
        //-- BUG0149-SPJ (NguyenPT 20170811) Handle show Gas remain and Sum all cylinder
        
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
        CommonProcess.setBorder(view: _tbxNote)
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        self._scrollView.addSubview(_tbxNote)
        
        // Scrollview content
        self._scrollView.contentSize = CGSize(
            width: GlobalConst.SCREEN_WIDTH,
            height: offset)
        
        // NavBar setup
        //++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        //setupNavigationBar(title: DomainConst.CONTENT00232, isNotifyEnable: BaseModel.shared.checkIsLogin())
        createNavigationBar(title: DomainConst.CONTENT00232)
        //-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        self.view.addSubview(_scrollView)
        self.view.makeComponentsColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setData(_ notification: Notification) {
//        let data = (notification.object as! OrderVIPCreateRespModel)
        let dataStr = (notification.object as! String)
        _data = OrderVIPCreateRespModel(jsonString: dataStr)
        if _data.isSuccess() {
            setupListInfo(data: _data.getRecord())
            setupListMaterial(data: _data.getRecord())
            _lblCustomerName.text = _data.getRecord().customer_name
            _tableView.reloadData()
            //++ BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
            getSumGasInfo()
            _tblViewGas.reloadData()
            self.getSumCylinderInfo()
            _tblViewCylinder.reloadData()
            _tbxNote.text = _data.getRecord().note_customer
            updateLayout()
            //-- BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
        } else {
            showAlert(message: _data.message)
        }
    }
    //++ BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
    private func updateLayout() {
        var offset: CGFloat = _segment.frame.maxY
        _tblViewGas.frame = CGRect(x: 0, y: offset,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: CGFloat(_listMaterial.count + _listGasString.count + 1) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        _tblViewCylinder.frame = CGRect(x: 0, y: offset,
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: CGFloat(_listCylinder.count + _listCylinderOption.count + _listMaterialString.count + 1) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        var height = _tblViewGas.frame.height
        //++ BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
        //        if _listMaterial.count < _listCylinder.count {
        if _tblViewCylinder.frame.height > height {
            //-- BUG0135-SPJ (NguyenPT 20170727) Clear all cylinder
            height = _tblViewCylinder.frame.height
        }
        offset = offset + height + GlobalConst.MARGIN
        // Scrollview content
        self._scrollView.contentSize = CGSize(
            width: GlobalConst.SCREEN_WIDTH,
            height: offset)
    }
    //-- BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View

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
            //++ BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
        case _tblViewGas:
            return 2
        case _tblViewCylinder:
            return 3
            //-- BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
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
        if tableView == _tableView {
            return _listInfo.count
        } else if tableView == _tblViewGas {
            //return _listMaterial.count
            if section == 0 {
                return _listMaterial.count
                //++ BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
            } else if (section == 1) {
                return _listGasString.count
            }
            //-- BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
        } else if tableView == _tblViewCylinder {
            //return _listCylinder.count
            if section == 0 {
                return _listCylinder.count
            } else if (section == 1) {
                return _listCylinderOption.count
            }
            //++ BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
            else if (section == 2) {
                return _listMaterialString.count
            }
            //-- BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
        }
        return _listInfo.count
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
            
            cell.setData(data: _listInfo[indexPath.row])
            if _listInfo[indexPath.row].id == DomainConst.AGENT_TOTAL_MONEY_ID {
                cell.highlightValue()
            }
            
            retCell = cell
        } else if tableView == _tblViewGas {
            let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.ORDER_DETAIL_TABLE_VIEW_CELL,
                                                     for: indexPath) as! OrderDetailTableViewCell
            //++
//            if indexPath.row == 0 {
//                cell.setup(data: _listMaterial[indexPath.row], color: GlobalConst.BUTTON_COLOR_GRAY)
//            } else {
//                cell.setup(data: _listMaterial[indexPath.row])
//            }
            switch indexPath.section {
            case 0:             // Header
                if indexPath.row == 0 {
                    cell.setup(data: _listMaterial[indexPath.row], color: GlobalConst.BUTTON_COLOR_GRAY)
                } else {
                    cell.setup(data: _listMaterial[indexPath.row])
            }
                //++ BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
            case 1:             // gas total info
                if _listGasString.count > indexPath.row  {
                    cell.setup(text: _listGasString[indexPath.row])
                }
                //-- BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
            default:
                break
            }
            //--
            retCell = cell
        } else if tableView == _tblViewCylinder {
            let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.ORDER_DETAIL_TABLE_VIEW_CELL,
                                                     for: indexPath) as! OrderDetailTableViewCell
            //cell.setup(data: _listCylinder[indexPath.row])
//            if indexPath.row == 0 {
//                cell.setup(data: _listCylinder[indexPath.row], color: GlobalConst.BUTTON_COLOR_GRAY)
//            } else {
//                cell.setup(data: _listCylinder[indexPath.row])
//            }
            switch indexPath.section {
                case 0:             // Header
                if indexPath.row == 0 {
                    cell.setup(data: _listCylinder[indexPath.row], color: GlobalConst.BUTTON_COLOR_GRAY)
                } else {
                    cell.setup(data: _listCylinder[indexPath.row])
                }
                case 1:             // Material
                if _listCylinderOption.count > indexPath.row  {
                    cell.setup(config: _listCylinderOption[indexPath.row])
                }
                //++ BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
                case 2:             // Material total info
                if _listMaterialString.count > indexPath.row  {
                    cell.setup(text: _listMaterialString[indexPath.row])
                }
                //-- BUG0216-SPJ (KhoiVT20170808) Gaservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
                default:
                break
            }
            retCell = cell
        }
        
        return retCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.CONFIGURATION_TABLE_VIEW_CELL,
//                                                 for: indexPath) as! ConfigurationTableViewCell
//        cell.setData(data: _listInfo[indexPath.row])
//        if _listInfo[indexPath.row].id == DomainConst.EMPLOYEE_INFO_PHONE_ID {
//            let phone = _listInfo[indexPath.row].name.normalizatePhoneString()
//            self.makeACall(phone: phone)
//        }
        
        switch tableView {
        case _tableView:
            if _listInfo[indexPath.row].id == DomainConst.EMPLOYEE_INFO_PHONE_ID {
                let phone = _listInfo[indexPath.row].name.normalizatePhoneString()
                self.makeACall(phone: phone)
            }
            break
        case _tblViewGas:
            break
        case _tblViewCylinder:
            switch indexPath.section {
            case 0:
                break
            case 1:
                if _listCylinderOption[indexPath.row].id == DomainConst.ORDER_INFO_MATERIAL_SUM_ALL_CYLINDER {
                    //self.getSumCylinder()
                    //self.getSumCylinderInfo()
                }
            default:
                break
            }
            
        default:
            break
        }
    }
    
    /**
     * Show sum all cylinders info 
     */
    private func getSumGasInfo() {
        _listGasString.removeAll()
        // Count number
        var sumCount: [(Int, Double)] = [
            (0, 0.0),
            (0, 0.0),
            (0, 0.0),
            (0, 0.0)
        ]
        // Summary strings
        //var sum: [String] = [String]()
        // Summary all
        var sumAll: (Int, Double) = (0, 0.0)
        // Loop through all info_vo array
        for item in _data.getRecord().info_gas {
            if let n = Int(item.qty_real) {
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
                case DomainConst.GAS_TYPE_ID_6KG:      // Cylinder 6Kg
                    sumCount[0].0 += n
                    sumCount[0].1 += gasRemain
                    break
                case DomainConst.GAS_TYPE_ID_12KG:     // Cylinder 12Kg
                    sumCount[1].0 += n
                    sumCount[1].1 += gasRemain
                    break
                case DomainConst.GAS_TYPE_ID_45KG:     // Cylinder 45Kg
                    sumCount[2].0 += n
                    sumCount[2].1 += gasRemain
                    break
                case DomainConst.GAS_TYPE_ID_50KG:     // Cylinder 50Kg
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
                var str = String.init(format: "%@ %@: %d bình",
                                      "bình",
                                      name,
                                      item.0)
                if !item.1.isZero {
                    str = String.init(format: "%@, gas dư: %.01f kg", str, item.1)
                }
                _listGasString.append(str)
            }
        }
        
        // Sum all
        var str = String.init(format: "%@: %d bình",
                              "Tổng cộng",
                              sumAll.0)
        if !sumAll.1.isZero {
            str = String.init(format: "%@, gas dư: %.01f kg", str, sumAll.1)
        }
        _listGasString.append(str)
        //_listGasString.append(_data.getRecord().info_price)
        _listGasString.append(_data.getRecord().text_summary)
        //showAlert(message: sum.joined(separator: "\n"))
    }
    
    //++ BUG0136-SPJ (NguyenPT 20170727) Handle sum all cylinders
    /**
     * Show sum all cylinders info 
     */
    private func getSumCylinderInfo() {
        _listMaterialString.removeAll()
        // Count number
        var sumCount: [(Int, Double)] = [
            (0, 0.0),
            (0, 0.0),
            (0, 0.0),
            (0, 0.0)
        ]
        // Summary strings
        //var sum: [String] = [String]()
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
                _listMaterialString.append(str)
            }
        }
        
        // Sum all
        var str = String.init(format: "%@: %d vỏ",
                              DomainConst.CONTENT00218,
                              sumAll.0)
        if !sumAll.1.isZero {
            str = String.init(format: "%@, gas dư: %.01f kg", str, sumAll.1)
        }
        _listMaterialString.append(str)
        //_listMaterialString.append(_data.getRecord().info_price)
        _listMaterialString.append(_data.getRecord().text_summary)
        //showAlert(message: sum.joined(separator: "\n"))
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
}
