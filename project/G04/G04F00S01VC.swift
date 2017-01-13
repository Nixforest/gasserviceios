//
//  G04F00S01VC.swift
//  project
//
//  Created by SPJ on 12/28/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

class G04F00S01VC: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: Properties
    /** Icon image view */
    @IBOutlet weak var iconImg:     UIImageView!
    /** Table view */
    @IBOutlet weak var tableView:   UITableView!
    /** Data */
    private static var _data:       OrderListRespModel = OrderListRespModel()
    /**  */
    
    // MARK: Methods
    /**
     * Set data of screen.
     * - parameter jsonString: JSON data
     */
    public func setData(jsonString: String) {
        G04F00S01VC._data = OrderListRespModel(jsonString: jsonString)
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self, selector: #selector(configItemTap(_:)), name:NSNotification.Name(rawValue: G04Const.NOTIFY_NAME_G04_ORDER_LIST_CONFIG_ITEM), object: nil)
    }
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        // Get height of status bar + navigation bar
        let heigh = self.getTopHeight()
        iconImg.image = ImageManager.getImage(named: DomainConst.ORDER_ICON_IMG_NAME)
        iconImg.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W / 2) / 2,
                               y: heigh + GlobalConst.MARGIN,
                               width: GlobalConst.LOGIN_LOGO_W / 2,
                               height: GlobalConst.LOGIN_LOGO_H / 2)
        iconImg.translatesAutoresizingMaskIntoConstraints = true
        // Order list view
        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.frame = CGRect(x: 0,
                                        y: iconImg.frame.maxY,
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: GlobalConst.SCREEN_HEIGHT - iconImg.frame.maxY)
        tableView.separatorStyle = .singleLine
        let frameworkBundle = Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)
        tableView.register(UINib(nibName: DomainConst.TABLE_VIEW_CELL_ORDER_TYPE, bundle: frameworkBundle), forCellReuseIdentifier: DomainConst.TABLE_VIEW_CELL_ORDER_TYPE)
        tableView.dataSource = self
        tableView.delegate = self
        
        // NavBar setup
        setupNavigationBar(title: DomainConst.CONTENT00231, isNotifyEnable: BaseModel.shared.checkIsLogin())
        
        // Notify set data
        NotificationCenter.default.addObserver(self, selector: #selector(setData(_:)), name:NSNotification.Name(rawValue: G04Const.NOTIFY_NAME_G04_ORDER_LIST_SET_DATA), object: nil)
        
        OrderListRequest.requestOrderList(page: "0", view: self)
    }
    
    /**
     * Set data for controls
     */
    override func setData(_ notification: Notification) {
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return G04F00S01VC._data.getRecord().count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DomainConst.TABLE_VIEW_CELL_ORDER_TYPE) as! TableCellOrderType
        //let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        if G04F00S01VC._data.getRecord().count > indexPath.row {
            cell.setData(data: G04F00S01VC._data.getRecord()[indexPath.row])
        }
        return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableCellOrderType.CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushToView(name: G04Const.G04_F00_S02_VIEW_CTRL)
    }
    /**
     * View did appear
     */
    override func viewDidAppear(_ animated: Bool) {
        self.updateNotificationStatus()
        self.tableView.reloadData()
    }
    
    /**
     * Clear data of view.
     * Reset currentPage value
     * Reset uphold list value
     */
    override func clearData() {
        G04F00S01VC._data = OrderListRespModel()
    }
}
