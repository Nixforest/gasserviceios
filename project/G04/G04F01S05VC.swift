//
//  G04F01S05VC.swift
//  project
//
//  Created by SPJ on 1/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G04F01S05VC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    /** Scroll view */
    @IBOutlet weak var _scrollView: UIScrollView!
    /** Material table view */
    @IBOutlet weak var _tblViewMaterial: UITableView!
    /** Information table view */
    @IBOutlet weak var _tblViewInfo: UITableView!
    /** List of material data */
    private var _listMaterial:  [OrderDetailBean]    = [OrderDetailBean]()
    /** List of information data */
    private var _listInfo:      [ConfigurationModel] = [ConfigurationModel]()
    /** Label phone */
    private var _lblPhone: UILabel          = UILabel()
    /** Label Address */
    private var _lblAddress: UILabel        = UILabel()
    /** Textfield phone */
    private var _txtPhone: UITextField      = UITextField()
    /** Textfield address */
    private var _txtAddress: UITextField    = UITextField()
    /** Button confirm */
    private var _btnConfirm: UIButton       = UIButton()
    /** Button cancel */
    private var _btnCancel: UIButton        = UIButton()
    /** Current transaction data */
    private var _transactionCompleteBean    = TransactionCompleteBean()
    
    // MARK: Methods
    /**
     * Get total money from the other value
     * - returns: Total money
     */
    func getTotalMoney() -> String {
        let fmt         = NumberFormatter()
        fmt.numberStyle = .decimal
        let promotion   = fmt.number(from: DomainConst.PROMOTION_DEFAULT)?.doubleValue
        let discount    = fmt.number(from: DomainConst.DISCOUNT_DEFAULT)?.doubleValue
        let gas         = fmt.number(from: MapViewController._gasSelected.material_price)?.doubleValue
        let total       = (gas! - (promotion! + discount!))
        return String(fmt.string(from: total as NSNumber) ?? DomainConst.BLANK)
    }
    
    /**
     * Update total money form the other value
     * - returns: Total money
     */
    func updateTotalMoney() -> String {
        let fmt         = NumberFormatter()
        fmt.numberStyle = .decimal
        let promotion   = fmt.number(from: self._transactionCompleteBean.promotion_amount)?.doubleValue
        let discount    = fmt.number(from: self._transactionCompleteBean.discount_amount)?.doubleValue
        var gas = 0.0
        for detail in self._transactionCompleteBean.order_detail {
            gas = gas + (fmt.number(from: detail.material_price)?.doubleValue)! * (detail.qty as NSString).doubleValue
        }
        let total       = (gas - (promotion! + discount!))
        return String(fmt.string(from: total as NSNumber) ?? DomainConst.BLANK)
    }
    
    /**
     * Setup list material data
     */
    func setupListMaterial() {
        self._listMaterial.removeAll()
        if !MapViewController._gasSelected.material_id.isEmpty {
            let detailGas = OrderDetailBean(data: MapViewController._gasSelected)
            detailGas.qty = "1"
            self._listMaterial.append(detailGas)
        }
        if !MapViewController._promoteSelected.material_id.isEmpty {
            let detailPromote = OrderDetailBean(data: MapViewController._promoteSelected)
            detailPromote.qty = "1"
            self._listMaterial.append(detailPromote)
        }
    }
    
    /**
     * Update data of list materials
     */
    func updateListMaterial() {
        self._listMaterial.removeAll()
        self._listMaterial.append(contentsOf: self._transactionCompleteBean.order_detail)
    }
    
    /**
     * Setup list information data
     */
    func setupListInfo() {
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_PROMOTION_ID,
                                            name: DomainConst.CONTENT00219,
                                            iconPath: DomainConst.DEFAULT_MATERIAL_IMG_NAME,
                                            value: DomainConst.PROMOTION_DEFAULT + DomainConst.VIETNAMDONG))
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_DISCOUNT_ID,
                                            name: DomainConst.CONTENT00239,
                                            iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                                            value: DomainConst.DISCOUNT_DEFAULT + DomainConst.VIETNAMDONG))
        
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_TOTAL_MONEY_ID,
                                            name: DomainConst.CONTENT00218,
                                            iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                                            value: getTotalMoney() + DomainConst.VIETNAMDONG))
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_NAME_ID,
                                            name: DomainConst.CONTENT00240,
                                            iconPath: DomainConst.AGENT_ICON_IMG_NAME,
                                            value: MapViewController._nearestAgent.info_agent.agent_name))
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_PHONE_ID,
                                            name: DomainConst.CONTENT00241,
                                            iconPath: DomainConst.PHONE_ICON_IMG_NAME,
                                            value: MapViewController._nearestAgent.info_agent.agent_phone))
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_SUPPORT_ID,
                                            name: DomainConst.CONTENT00242,
                                            iconPath: DomainConst.SUPPORT_ICON_IMG_NAME,
                                            value: MapViewController._nearestAgent.info_agent.agent_phone_support))
    }
    
    /**
     * Update data of list information
     */
    func updateListInfo() {
        self._listInfo.removeAll()
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_PROMOTION_ID,
                                            name: DomainConst.CONTENT00219,
                                            iconPath: DomainConst.DEFAULT_MATERIAL_IMG_NAME,
                                            value: self._transactionCompleteBean.promotion_amount + DomainConst.VIETNAMDONG))
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_DISCOUNT_ID,
                                            name: DomainConst.CONTENT00239,
                                            iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                                            value: self._transactionCompleteBean.discount_amount + DomainConst.VIETNAMDONG))
        
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_TOTAL_MONEY_ID,
                                            name: DomainConst.CONTENT00218,
                                            iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                                            value: self._transactionCompleteBean.total + DomainConst.VIETNAMDONG))
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_NAME_ID,
                                            name: DomainConst.CONTENT00240,
                                            iconPath: DomainConst.AGENT_ICON_IMG_NAME,
                                            value: self._transactionCompleteBean.agent_name))
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_PHONE_ID,
                                            name: DomainConst.CONTENT00241,
                                            iconPath: DomainConst.PHONE_ICON_IMG_NAME,
                                            value: MapViewController._nearestAgent.info_agent.agent_phone))
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_SUPPORT_ID,
                                            name: DomainConst.CONTENT00242,
                                            iconPath: DomainConst.SUPPORT_ICON_IMG_NAME,
                                            value: MapViewController._nearestAgent.info_agent.agent_phone_support))
    }

    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationBar(title: DomainConst.CONTENT00217, isNotifyEnable: true)
        setupListMaterial()
        setupListInfo()
        var offset: CGFloat = -getTopHeight()
        // Material table view
        self._tblViewMaterial.translatesAutoresizingMaskIntoConstraints = true
        self._tblViewMaterial.frame = CGRect(x: 0,
                                             y: offset,
                                             width: GlobalConst.SCREEN_WIDTH,
                                             height: GlobalConst.CELL_HEIGHT_SHOW * CGFloat(self._listMaterial.count) * 2/3)
        offset = offset + self._tblViewMaterial.frame.height
        
        // Information table view
        self._tblViewInfo.translatesAutoresizingMaskIntoConstraints = true
        self._tblViewInfo.frame = CGRect(x: 0,
                                         y: offset,
                                         width: GlobalConst.SCREEN_WIDTH,
                                         height: CGFloat(_listInfo.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        offset = offset + self._tblViewInfo.frame.height + GlobalConst.MARGIN
        
        // Label phone
        self._lblPhone.frame = CGRect(x: 0, y: offset,
                                      width: GlobalConst.SCREEN_WIDTH,
                                      height: GlobalConst.LABEL_H)
        self._lblPhone.text = DomainConst.CONTENT00170
        self._lblPhone.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        self._lblPhone.textAlignment = .center
        offset = offset + self._lblPhone.frame.height
        
        // Textfield Phone
        self._txtPhone.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                      y: offset,
                                      width: GlobalConst.BUTTON_W,
                                      height: GlobalConst.BUTTON_H)
        self._txtPhone.font = UIFont.boldSystemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
        self._txtPhone.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        self._txtPhone.text = "0123456789"
        self._txtPhone.textAlignment = .center
        self._txtPhone.layer.borderWidth = 1
        self._txtPhone.layer.borderColor = GlobalConst.MAIN_COLOR.cgColor
        self._txtPhone.textColor = GlobalConst.MAIN_COLOR
        self._txtPhone.isUserInteractionEnabled = false
        offset = offset + self._txtPhone.frame.height
        
        // Label Address
        self._lblAddress.frame = CGRect(x: 0, y: offset,
                                      width: GlobalConst.SCREEN_WIDTH,
                                      height: GlobalConst.LABEL_H)
        self._lblAddress.text = DomainConst.CONTENT00243
        self._lblAddress.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        self._lblAddress.textAlignment = .center
        offset = offset + self._lblAddress.frame.height
        
        // Textfield Address
        self._txtAddress.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                      y: offset,
                                      width: GlobalConst.BUTTON_W,
                                      height: GlobalConst.BUTTON_H)
        self._txtAddress.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self._txtAddress.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        self._txtAddress.text = MapViewController._currentAddress
        self._txtAddress.textAlignment = .center
        self._txtAddress.layer.borderWidth = 1
        self._txtAddress.layer.borderColor = GlobalConst.MAIN_COLOR.cgColor
        self._txtAddress.isUserInteractionEnabled = false
        offset = offset + self._txtAddress.frame.height + GlobalConst.MARGIN
        
        // Button Confirm
        self._btnConfirm.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                        y: offset,
                                        width: GlobalConst.BUTTON_W / 2,
                                        height: GlobalConst.BUTTON_H)
        self._btnConfirm.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self._btnConfirm.setTitle(DomainConst.CONTENT00217.uppercased(), for: UIControlState())
        self._btnConfirm.setTitleColor(UIColor.white, for: UIControlState())
        self._btnConfirm.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self._btnConfirm.addTarget(self, action: #selector(btnConfirmTapped), for: .touchUpInside)
        self._btnConfirm.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        self._btnConfirm.setImage(ImageManager.getImage(named: DomainConst.CONFIRM_IMG_NAME), for: UIControlState())
        self._btnConfirm.imageView?.contentMode = .scaleAspectFit
        
        // Button Cancel
        self._btnCancel.frame = CGRect(x: GlobalConst.SCREEN_WIDTH / 2,
                                        y: offset,
                                        width: GlobalConst.BUTTON_W / 2,
                                        height: GlobalConst.BUTTON_H)
        self._btnCancel.backgroundColor = GlobalConst.BUTTON_COLOR_YELLOW
        self._btnCancel.setTitle(DomainConst.CONTENT00220.uppercased(), for: UIControlState())
        self._btnCancel.setTitleColor(UIColor.white, for: UIControlState())
        self._btnCancel.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self._btnCancel.addTarget(self, action: #selector(btnCancelTapped(_:)), for: .touchUpInside)
        self._btnCancel.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        self._btnCancel.setImage(ImageManager.getImage(named: DomainConst.CANCEL_IMG_NAME), for: UIControlState())
        self._btnCancel.imageView?.contentMode = .scaleAspectFit
        offset = offset + self._btnCancel.frame.height + GlobalConst.MARGIN

        
        // Add to view
        self._scrollView.addSubview(self._lblPhone)
        self._scrollView.addSubview(self._txtPhone)
        self._scrollView.addSubview(self._lblAddress)
        self._scrollView.addSubview(self._txtAddress)
        self._scrollView.addSubview(self._btnConfirm)
        self._scrollView.addSubview(self._btnCancel)
        
        self._scrollView.translatesAutoresizingMaskIntoConstraints = true
        self._scrollView.frame = CGRect(x: 0, y: getTopHeight(),
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: GlobalConst.SCREEN_HEIGHT)
        self._scrollView.contentSize = CGSize(width: GlobalConst.SCREEN_WIDTH,
                                              height: offset + getTopHeight())
        //self._scrollView.backgroundColor = UIColor.blue
    }
    
    /**
     * Handler when transaction complete request is finish
     */
    func finishRequestTransactionCompleteHandler(_ notification: Notification) {
        _transactionCompleteBean = (notification.object as! TransactionCompleteBean)
        updateListMaterial()
        updateListInfo()
        self._tblViewMaterial.reloadData()
        self._tblViewInfo.reloadData()
    }
    
    /**
     * Set data notification
     */
    override func setData(_ notification: Notification) {
        setData()
    }
    
    /**
     * Set data for	phone and request transaction complete
     */
    func setData() {
        _txtPhone.text = BaseModel.shared.user_info?.getPhone()
        requestTransactionComplete()
    }
    
    /**
     * Request transaction complete
     */
    func requestTransactionComplete() {
        var orderDetail = DomainConst.BLANK
        for item in self._listMaterial {
            orderDetail = orderDetail + item.createJsonData()
        }
        orderDetail = String(orderDetail.characters.dropLast())
        OrderTransactionCompleteRequest.requestOrderTransactionComplete(
            action:      #selector(finishRequestTransactionCompleteHandler(_:)),
            view:        self,
            key:         BaseModel.shared.getTransactionData().name,
            id:          BaseModel.shared.getTransactionData().id,
            devicePhone: DomainConst.BLANK,
            firstName:   (BaseModel.shared.user_info?.getName())!,
            phone:       (BaseModel.shared.user_info?.getPhone())!,
            email:       (BaseModel.shared.user_info?.getEmail())!,
            provinceId:  (BaseModel.shared.user_info?.getProvinceId())!,
            districtId:  (BaseModel.shared.user_info?.getDistrictId())!,
            wardId:      (BaseModel.shared.user_info?.getWardId())!,
            streetId:    (BaseModel.shared.user_info?.getStreetId())!,
            houseNum:    (BaseModel.shared.user_info?.getHouseNumber())!,
            note:        DomainConst.BLANK,
            address:     MapViewController._currentAddress,
            orderDetail: orderDetail,
            lat:         String(MapViewController._currentPos.latitude),
            long:        String(MapViewController._currentPos.longitude),
            agentId:     MapViewController._nearestAgent.info_agent.agent_id,
            transactionType: DomainConst.TRANSACTION_TYPE_NORMAL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Handle when tap cancel button
     */
    func btnCancelTapped(_ sender: AnyObject) {
        OrderTransactionCancelRequest.requestOrderTransactionCancel(
            action: #selector(finishRequestTransactionConfirmHandler(_:)),
            view: self)
    }
    
    /**
     * Handle when tap confirm button
     */
    func btnConfirmTapped(_ sender: AnyObject) {
        OrderTransactionConfirmRequest.requestOrderTransactionConfirm(
            action: #selector(finishRequestTransactionConfirmHandler(_:)), view: self,
            address: MapViewController._currentAddress,
            phone: (BaseModel.shared.user_info?.getPhone())!)
    }
    
    /**
     * Handle when finish request transaction confirm/cancel
     */
    func finishRequestTransactionConfirmHandler(_ notification: Notification) {
        // Back to previous view
        self.backButtonTapped(self)
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
        if tableView == _tblViewMaterial {
            return GlobalConst.CELL_HEIGHT_SHOW * 2/3
        } else if tableView == _tblViewInfo {
            
        }
        return UITableViewAutomaticDimension
    }
    
    /**
     * Set number of row in table view
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == _tblViewMaterial {
            return self._listMaterial.count
        } else if tableView == _tblViewInfo {
            return _listInfo.count
        }
        return 0
    }
    
    /**
     * Set content of row in table view
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var retCell = UITableViewCell()
        if tableView == _tblViewMaterial {
            let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.MATERIAL_TABLE_VIEW_CELL,
                                                     for: indexPath) as! MaterialTableViewCell
            cell.setData(data: self._listMaterial[indexPath.row])
            retCell = cell
        } else if tableView == _tblViewInfo {
            let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.CONFIGURATION_TABLE_VIEW_CELL,
                                                     for: indexPath) as! ConfigurationTableViewCell
                
            cell.setData(data: _listInfo[indexPath.row])
            if _listInfo[indexPath.row].id == DomainConst.AGENT_TOTAL_MONEY_ID {
                cell.highlightValue()
            }
            
            retCell = cell
        }
        return retCell
    }
    
    /**
     * Handle when select row in table view
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == _tblViewMaterial {
            if self._listMaterial[indexPath.row].isGas() {
                G04F01S02VC.setData(data: MapViewController._nearestAgent.info_gas)
                self.pushToView(name: G04Const.G04_F01_S02_VIEW_CTRL)
            } else {
                G04F01S03VC.setData(data: MapViewController._nearestAgent.info_promotion)
                self.pushToView(name: G04Const.G04_F01_S03_VIEW_CTRL)
            }
        } else if tableView == _tblViewInfo {
            if _listInfo[indexPath.row].id == DomainConst.AGENT_PHONE_ID ||
                _listInfo[indexPath.row].id == DomainConst.AGENT_SUPPORT_ID {
                if let url = NSURL(string: "tel://\(_listInfo[indexPath.row].getValue().normalizatePhoneString())"), UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }
    }
    
    /**
     * View did appear
     */
    override func viewDidAppear(_ animated: Bool) {
        setupListMaterial()
        // Load data from server
        if BaseModel.shared.user_info == nil {
            // User information does not exist
            RequestAPI.requestUserProfile(action: #selector(setData(_:)), view: self)
        } else {
            setData()
        }
        //self._tblViewMaterial.reloadData()
    }
}
