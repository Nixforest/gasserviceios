//
//  G05F00S02VC.swift
//  project
//
//  Created by SPJ on 2/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F00S02VC: BaseViewController, UITableViewDataSource, UITableViewDelegate {
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
    /** Order information view */
    private var _viewOrderInfo:     UIView               = UIView()
    /** Order cylinder information view */
    private var _viewOrderCylinderInfo: UIView           = UIView()
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
    
    func setupListMaterial(data: OrderVIPBean = OrderVIPBean()) {
        _listMaterial.removeAll()
        createMaterialTableHeader()
        for item in data.info_gas {
            let materialValue: [(String, Int)] = [
                (item.material_name, 3),
                (item.qty, 1),
                (item.qty_real, 1)
            ]
            _listMaterial.append(materialValue)
        }
        var offset: CGFloat = _segment.frame.maxY
        _tblViewGas.frame = CGRect(x: 0, y: offset,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: CGFloat(_listMaterial.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        
        _listCylinder.removeAll()
        createCylinderTableHeader()
        for item in data.info_vo {
            var gasdu = DomainConst.BLANK
            if !item.kg_has_gas.isEmpty && !item.kg_empty.isEmpty{
                gasdu = String(Int(item.kg_has_gas)! - Int(item.kg_empty)!)
            }
            let cylinderValue: [(String, Int)] = [
                (item.material_name, 4),
                (item.seri, 1),
                (item.kg_empty, 1),
                (item.kg_has_gas, 1),
                (gasdu, 1)
            ]
            self._listCylinder.append(cylinderValue)
        }
        _tblViewCylinder.frame = CGRect(x: 0, y: offset,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: CGFloat(_listCylinder.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
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
            ("Gas", 3),
            ("Số lượng", 1),
            ("Thực tế", 1)
        ]
        self._listMaterial.append(materialHeader)
    }
    
    /**
     * Create header data for material table
     */
    func createCylinderTableHeader() {
        let cylinderHeader: [(String, Int)] = [
            ("Tên", 4),
            ("Serial", 1),
            ("Vỏ", 1),
            ("Cân", 1),
            ("Dư", 1)
        ]
        self._listCylinder.append(cylinderHeader)
    }
    
    private func getStatusString(status: String) -> String {
        var retVal = DomainConst.BLANK
        switch status {
        case DomainConst.ORDER_STATUS_NEW:
            retVal = "Đang xử lý đơn hàng"
            break
        case DomainConst.ORDER_STATUS_PROCESSING:
            retVal = "Đang giao hàng"
            break
        case DomainConst.ORDER_STATUS_COMPLETE:
            retVal = "Đã giao"
            break
        case DomainConst.ORDER_STATUS_CANCEL:
            retVal = "Đã huỷ"
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
                                            value: "#" + data.code_no))
        var status = "Đang giao hàng"
        if !G05F00S01VC.getStatusNumber().isEmpty {
            status = getStatusString(status: G05F00S01VC.getStatusNumber())
        }
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_STATUS_ID,
                                            name: DomainConst.CONTENT00092,
                                            iconPath: DomainConst.ORDER_STATUS_ICON_IMG_NAME,
                                            value: status))
        if !data.name_car.isEmpty {
            _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_CAR_NUMBER_ID,
                                                name: DomainConst.CONTENT00258,
                                                iconPath: DomainConst.ORDER_CAR_NUMBER_ICON_IMG_NAME,
                                                value: data.name_car))
        }
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_PAYMENT_METHOD_ID,
                                            name: DomainConst.CONTENT00259,
                                            iconPath: DomainConst.ORDER_PAYMENT_METHOD_ICON_IMG_NAME,
                                            value: "Tiền mặt"))
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_GAS_MONEY_ID,
                                            name: DomainConst.CONTENT00260,
                                            iconPath: DomainConst.MONEY_ICON_GREY_IMG_NAME,
                                            value: data.total_gas + DomainConst.VIETNAMDONG))
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_GAS_DU_ID,
                                            name: DomainConst.CONTENT00261,
                                            iconPath: DomainConst.MONEY_ICON_GREY_IMG_NAME,
                                            value: data.total_gas_du + DomainConst.VIETNAMDONG))
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_TOTAL_MONEY_ID,
                                            name: DomainConst.CONTENT00262,
                                            iconPath: DomainConst.MONEY_ICON_PAPER_IMG_NAME,
                                            value: data.grand_total + DomainConst.VIETNAMDONG))
        
        //updateLayout(data: data)
    }
    
    internal func segmentChange(_ sender: AnyObject) {
        switch _segment.selectedSegmentIndex {
        case 0:
            self._viewOrderInfo.isHidden         = false
            self._viewOrderCylinderInfo.isHidden = true
            break
        case 1:
            self._viewOrderInfo.isHidden         = true
            self._viewOrderCylinderInfo.isHidden = false
            break
        default:
             break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        OrderVIPViewRequest.requestOrderVIPView(action: #selector(setData(_:)), view: self, id: G05F00S02VC._id)

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
        _viewOrderInfo.addSubview(_tblViewGas)
        _viewOrderCylinderInfo.addSubview(_tblViewCylinder)
        _viewOrderInfo.isHidden = false
        _viewOrderCylinderInfo.isHidden = true
        _scrollView.addSubview(_viewOrderInfo)
        _scrollView.addSubview(_viewOrderCylinderInfo)
        offset = offset + _viewOrderInfo.frame.height + GlobalConst.MARGIN
        
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
        setupNavigationBar(title: DomainConst.CONTENT00232, isNotifyEnable: BaseModel.shared.checkIsLogin())
        self.view.addSubview(_scrollView)
        self.view.makeComponentsColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setData(_ notification: Notification) {
        let data = (notification.object as! OrderVIPCreateRespModel)
        setupListInfo(data: data.getRecord())
        setupListMaterial(data: data.getRecord())
        _lblCustomerName.text = data.getRecord().customer_name
        _tableView.reloadData()
        _tblViewGas.reloadData()
        _tblViewCylinder.reloadData()
        _tbxNote.text = data.getRecord().note_customer
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
            return _listMaterial.count
        } else if tableView == _tblViewCylinder {
            return _listCylinder.count
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
            if indexPath.row == 0 {
                cell.setup(data: _listMaterial[indexPath.row], color: GlobalConst.BUTTON_COLOR_GRAY)
            } else {
                cell.setup(data: _listMaterial[indexPath.row])
            }
            retCell = cell
        } else if tableView == _tblViewCylinder {
            let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.ORDER_DETAIL_TABLE_VIEW_CELL,
                                                     for: indexPath) as! OrderDetailTableViewCell
            //cell.setup(data: _listCylinder[indexPath.row])
            if indexPath.row == 0 {
                cell.setup(data: _listCylinder[indexPath.row], color: GlobalConst.BUTTON_COLOR_GRAY)
            } else {
                cell.setup(data: _listCylinder[indexPath.row])
            }
            retCell = cell
        }
        
        return retCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.CONFIGURATION_TABLE_VIEW_CELL,
                                                 for: indexPath) as! ConfigurationTableViewCell
        cell.setData(data: _listInfo[indexPath.row])
        if _listInfo[indexPath.row].id == DomainConst.EMPLOYEE_INFO_PHONE_ID {
            let phone = _listInfo[indexPath.row].name.normalizatePhoneString()
            self.makeACall(phone: phone)
        }
    }
}
