//
//  G04F00S02VC.swift
//  project
//
//  Created by SPJ on 12/31/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G04F00S02VC: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: Properties
    /** Id */
    public static var _id: String = DomainConst.BLANK
    /** Parent view */
    var _scrollView: UIScrollView = UIScrollView()
    /** Employee */
    var lblEmployee: UILabel = UILabel()
    /** Icon image view */
    var iconImg: UIImageView = UIImageView()
    /** Name */
    var lblName: UILabel = UILabel()
    /** Employee table view */
    @IBOutlet weak var _tblEmployee: UITableView!
    /** Material table view */
    @IBOutlet weak var _tblMaterial: UITableView!
    /** Information table view */
    @IBOutlet weak var _tblInfo: UITableView!
    /** List of information data */
    private var _listEmployee:  [ConfigurationModel] = [ConfigurationModel]()
    /** List of material data */
    private var _listMaterial:  [OrderDetailBean]    = [OrderDetailBean]()
    /** List of information data */
    private var _listInfo:      [ConfigurationModel] = [ConfigurationModel]()
    
    // MARK: Methods
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self, selector: #selector(configItemTap(_:)), name:NSNotification.Name(rawValue: G04Const.NOTIFY_NAME_G04_ORDER_VIEW_CONFIG_ITEM), object: nil)
    }
    
    /**
     * Setup list employee data
     */
    func setupListEmployee(data: OrderBean = OrderBean()) {
        _listEmployee.removeAll()
        _listEmployee.append(ConfigurationModel(id: DomainConst.EMPLOYEE_INFO_PHONE_ID,
                                            name: DomainConst.CONTENT00152,
                                            iconPath: DomainConst.PHONE_ICON_IMG_NAME,
                                            value: data.employee_phone))
        _listEmployee.append(ConfigurationModel(id: DomainConst.EMPLOYEE_INFO_CODE_ID,
                                            name: DomainConst.CONTENT00245,
                                            iconPath: DomainConst.EMPLOYEE_ICON_IMG_NAME,
                                            value: data.employee_code))
    }
    
    /**
     * Setup list material data
     */
    func setupListMaterial(data: OrderBean = OrderBean()) {
        self._listMaterial.append(contentsOf: data.order_detail)
        var offset = self._tblEmployee.frame.maxY
        self._tblMaterial.frame = CGRect(x: 0,
                                         y: offset,
                                         width: GlobalConst.SCREEN_WIDTH,
                                         height: GlobalConst.CELL_HEIGHT_SHOW * CGFloat(self._listMaterial.count) * 2/3)
        offset = offset + self._tblMaterial.frame.height
        
        // Information table view
        self._tblInfo.frame = CGRect(x: 0,
                                     y: offset,
                                     width: GlobalConst.SCREEN_WIDTH,
                                     height: CGFloat(_listInfo.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        offset = offset + self._tblInfo.frame.height + GlobalConst.MARGIN
        
        self._scrollView.contentSize = CGSize(
            width: GlobalConst.SCREEN_WIDTH,
            height: offset)

    }
    
    /**
     * Setup list information data
     */
    func setupListInfo(data: OrderBean = OrderBean()) {
        self._listInfo.removeAll()
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_PROMOTION_ID,
                                            name: DomainConst.CONTENT00219,
                                            iconPath: DomainConst.DEFAULT_MATERIAL_IMG_NAME,
                                            value: data.promotion_amount + DomainConst.VIETNAMDONG))
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_DISCOUNT_ID,
                                            name: DomainConst.CONTENT00239,
                                            iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                                            value: data.discount_amount + DomainConst.VIETNAMDONG))
        _listInfo.append(ConfigurationModel(id: DomainConst.AGENT_TOTAL_MONEY_ID,
                                            name: DomainConst.CONTENT00218,
                                            iconPath: DomainConst.MONEY_ICON_IMG_NAME,
                                            value: data.total + DomainConst.VIETNAMDONG))
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
                                            value: DomainConst.VIETNAMDONG))
    }
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        // Get height of status bar + navigation bar
        // Setup default data
        setupListEmployee()
        setupListMaterial()
        setupListInfo()
        // Offset
        var offset: CGFloat = GlobalConst.MARGIN_CELL_X
        _scrollView.translatesAutoresizingMaskIntoConstraints = true
        _scrollView.frame = CGRect(
            x: 0,
            y: 0,
            width: GlobalConst.SCREEN_WIDTH,
            height: GlobalConst.SCREEN_HEIGHT)
        
        // Label Employee
        lblEmployee.translatesAutoresizingMaskIntoConstraints = true
        lblEmployee.frame = CGRect(x: 0,
                               y: offset,
                               width: GlobalConst.SCREEN_WIDTH,
                               height: GlobalConst.LABEL_H)
        lblEmployee.text          = DomainConst.CONTENT00233
        lblEmployee.textAlignment = .center
        lblEmployee.textColor     = GlobalConst.TEXT_COLOR
        lblEmployee.font          = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        self._scrollView.addSubview(lblEmployee)
        offset += lblEmployee.frame.height
        
        // Icon image
        iconImg.image = ImageManager.getImage(named: DomainConst.ORDER_ICON_IMG_NAME)
        iconImg.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W / 2) / 2,
                               y: offset,
                               width: GlobalConst.LOGIN_LOGO_W / 2,
                               height: GlobalConst.LOGIN_LOGO_H / 2)
        iconImg.contentMode = .scaleAspectFit
        iconImg.translatesAutoresizingMaskIntoConstraints = true
        self._scrollView.addSubview(iconImg)
        offset += iconImg.frame.height
        
        // Label name
        lblName.translatesAutoresizingMaskIntoConstraints = true
        lblName.frame = CGRect(x: 0,
                               y: offset,
                               width: GlobalConst.SCREEN_WIDTH,
                               height: GlobalConst.LABEL_H)
        lblName.text = BaseModel.shared.user_info?.getName()
        lblName.textAlignment = .center
        lblName.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        lblName.textColor = GlobalConst.BUTTON_COLOR_RED
        self._scrollView.addSubview(lblName)
        offset += lblName.frame.height
        
        // Employee table view
        self._tblEmployee.translatesAutoresizingMaskIntoConstraints = true
        self._tblEmployee.frame = CGRect(x: 0,
                                         y: offset,
                                         width: GlobalConst.SCREEN_WIDTH,
                                         height: CGFloat(_listEmployee.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        offset = offset + self._tblEmployee.frame.height
        self._scrollView.addSubview(self._tblEmployee)
        
        // Material table view
        self._tblMaterial.translatesAutoresizingMaskIntoConstraints = true
        self._tblMaterial.frame = CGRect(x: 0,
                                             y: offset,
                                             width: GlobalConst.SCREEN_WIDTH,
                                             height: GlobalConst.CELL_HEIGHT_SHOW * CGFloat(self._listMaterial.count) * 2/3)
        offset = offset + self._tblMaterial.frame.height
        self._scrollView.addSubview(self._tblMaterial)
        
        // Information table view
        self._tblInfo.translatesAutoresizingMaskIntoConstraints = true
        self._tblInfo.frame = CGRect(x: 0,
                                         y: offset,
                                         width: GlobalConst.SCREEN_WIDTH,
                                         height: CGFloat(_listInfo.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        offset = offset + self._tblInfo.frame.height + GlobalConst.MARGIN
        self._scrollView.addSubview(self._tblInfo)
        
        self._scrollView.contentSize = CGSize(
            width: GlobalConst.SCREEN_WIDTH,
            height: offset)
        self.view.addSubview(_scrollView)
        
        // NavBar setup
        setupNavigationBar(title: DomainConst.CONTENT00232, isNotifyEnable: BaseModel.shared.checkIsLogin())
        
        OrderViewRequest.requestOrderView(action: #selector(setData(_:)), view: self, id: G04F00S02VC._id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setData(_ notification: Notification) {
        let model: OrderViewRespModel = (notification.object as! OrderViewRespModel)
        lblName.text = model.getRecord().employee_name
        setupListEmployee(data: model.getRecord())
        setupListMaterial(data: model.getRecord())
        setupListInfo(data: model.getRecord())
        self._tblEmployee.reloadData()
        self._tblMaterial.reloadData()
        self._tblInfo.reloadData()
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
        if tableView == _tblMaterial {
            return GlobalConst.CELL_HEIGHT_SHOW * 2/3
        }
        return UITableViewAutomaticDimension
    }
    
    /**
     * Set number of row in table view
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == _tblMaterial {
            return self._listMaterial.count
        } else if tableView == _tblInfo {
            return _listInfo.count
        } else if tableView == _tblEmployee {
            return _listEmployee.count
        }
        return 0
    }
    
    
    /**
     * Set content of row in table view
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var retCell = UITableViewCell()
        if tableView == _tblMaterial {
            let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.MATERIAL_TABLE_VIEW_CELL,
                                                     for: indexPath) as! MaterialTableViewCell
            cell.setData(data: self._listMaterial[indexPath.row])
            retCell = cell
        } else if tableView == _tblInfo {
            let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.CONFIGURATION_TABLE_VIEW_CELL,
                                                     for: indexPath) as! ConfigurationTableViewCell
            
            cell.setData(data: _listInfo[indexPath.row])
            if _listInfo[indexPath.row].id == DomainConst.AGENT_TOTAL_MONEY_ID {
                cell.highlightValue()
            }
            
            retCell = cell
        } else if tableView == _tblEmployee {
            let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.CONFIGURATION_TABLE_VIEW_CELL,
                                                     for: indexPath) as! ConfigurationTableViewCell
            
            cell.setData(data: _listEmployee[indexPath.row])
            if _listEmployee[indexPath.row].id == DomainConst.EMPLOYEE_INFO_PHONE_ID {
                cell.highlightValue()
            }
            
            retCell = cell
        }
        return retCell
    }

}
