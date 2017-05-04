//
//  G08F00S02VC.swift
//  project
//
//  Created by SPJ on 5/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G08F00S02VC: ChildViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: Properties
    /** Id */
    public static var _id:          String                      = DomainConst.BLANK
    /** Information table view */
    @IBOutlet weak var _tableView:  UITableView!
    /** List of information data */
    private var _listInfo:          [ConfigurationModel]        = [ConfigurationModel]()
    /** List of material information */
    private var _listMaterial:      [[(String, Int)]]           = [[(String, Int)]]()
    /** Material header */
    private let _materialHeader:    [(String, Int)]             = [(DomainConst.CONTENT00091, G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.0),
                                                                   (DomainConst.CONTENT00335, G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.1),
                                                                   (DomainConst.CONTENT00255, G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.2)]
    /** Current data */
    private var _data:              StoreCardViewRespModel      = StoreCardViewRespModel()
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
        if !G08F00S02VC._id.isEmpty {
            StoreCardViewRequest.request(action: action,
                                         view: self,
                                         id: G08F00S02VC._id)
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
     * Handle finish request data
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = StoreCardViewRespModel(jsonString: data)
        if model.isSuccess() {
            self._data = model
            setupListInfo()
            setupListMaterial()
            _tableView.reloadData()
        }
    }
    
    // MARK: Override from UIViewController
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00354)
        _tableView.addSubview(refreshControl)
        _tableView.frame = CGRect(x: 0,
                                y: 0,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT)
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Utility methods
    /**
     * Set up list information
     */
    private func setupListInfo() {
        self._listInfo.removeAll()
        // In/out date
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CREATED_DATE_ID,
            name: DomainConst.CONTENT00355,
            iconPath: DomainConst.DATETIME_ICON_IMG_NAME,
            value: _data.record.date_delivery))
        let data = _data.record.code_no.components(separatedBy: DomainConst.SPLITER_TYPE1)
        // Code no
        if data.count >= 1 {
            _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_ID_ID,
                                                name: DomainConst.CONTENT00356,
                                                iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
                                                value: DomainConst.ORDER_CODE_PREFIX + data[0]))
        }
        
        // Type of store card
        if data.count >= 2 {
            _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_ID_ID,
                                                name: DomainConst.CONTENT00357,
                                                iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
                                                value: data[1]))
        }
        // Address
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_ADDRESS_ID, name: _data.record.customer_address.normalizateString(),
            iconPath: DomainConst.ADDRESS_ICON_IMG_NAME, value: DomainConst.BLANK))
        // Contact
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CONTACT_ID,
            name: _data.record.customer_name,
            iconPath: DomainConst.AGENT_ICON_IMG_NAME,
            value: DomainConst.BLANK))
        // Note
        if !_data.record.note.isEmpty {
            _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_ID_ID,
                                                name: _data.record.note,
                                                iconPath: DomainConst.PROBLEM_ICON_IMG_NAME,
                                                value: DomainConst.BLANK))
        }
    }
    
    /**
     * Set up list material
     */
    private func setupListMaterial() {
        _listMaterial.removeAll()
        // Header
        _listMaterial.append(_materialHeader)
        // Order detail
        for item in _data.record.order_detail {
            let materialValue: [(String, Int)] = [
                (item.materials_no,     G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.0),
                (item.material_name,    G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.1),
                (item.qty + " x " + item.unit,     G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.2)
            ]
            _listMaterial.append(materialValue)
        }
        // Total
        let total: [(String, Int)] = [
            (DomainConst.BLANK,         G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.0),
            (DomainConst.CONTENT00358,  G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.1),
            (_data.record.total_qty,    G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.2)
        ]
        _listMaterial.append(total)
    }
    
    // MARK: - UITableViewDataSource
    /**
     * The number of sections in the table view.
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            return _listInfo.count
        } else if section == 1 {
            return _listMaterial.count
        }
        return 0
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            switch indexPath.section {
            case 0:
                let cell: ConfigurationTableViewCell = tableView.dequeueReusableCell(
                    withIdentifier: ConfigurationTableViewCell.theClassName)
                    as! ConfigurationTableViewCell
                cell.setData(data: _listInfo[indexPath.row])
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailTableViewCell.theClassName,
                                                         for: indexPath) as! OrderDetailTableViewCell
                if indexPath.row == 0 {
                    cell.setup(data: _listMaterial[indexPath.row], color: GlobalConst.BUTTON_COLOR_GRAY)
                } else {
                    cell.setup(data: _listMaterial[indexPath.row],
                               color: UIColor.white,
                               highlighColumn: [1],
                               alignment: [.left, .left, .left])
                }
                
                return cell
            default:
                break
            }
            return UITableViewCell()
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalConst.CONFIGURATION_ITEM_HEIGHT
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row > 0 && indexPath.row < (_listMaterial.count - 1) {
                showAlert(message: _listMaterial[indexPath.row][1].0)
            }
        }
    }
}
