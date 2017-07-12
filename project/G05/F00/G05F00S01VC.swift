//
//  G05F00S01VC.swift
//  project
//
//  Created by SPJ on 2/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

//++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
//class G05F00S01VC: BaseViewController, UITableViewDataSource, UITableViewDelegate {
class G05F00S01VC: ParentViewController, UITableViewDataSource, UITableViewDelegate {
//-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
    /** Table view */
    @IBOutlet weak var _tableView:  UITableView!
    /** Icon image */
    @IBOutlet weak var iconImg:     UIImageView!
    /** Static data */
    //++ BUG0060-SPJ (NguyenPT 20170421) Not use static variable
    //private static var _data:              OrderVIPListRespModel = OrderVIPListRespModel()
    private var _data:              OrderVIPListRespModel = OrderVIPListRespModel()
    //-- BUG0060-SPJ (NguyenPT 20170421) Not use static variable
    /** Current page */
    private var _page:              Int                   = 0
    //++ BUG0060-SPJ (NguyenPT 20170421) Add refresh control
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    //-- BUG0060-SPJ (NguyenPT 20170421) Add refresh control
    //++ BUG0124-SPJ (NguyenPT 20170711) Add button Add new
    /** Customer name label */
    private var _lblCustomerName:   UILabel              = UILabel()
    //-- BUG0124-SPJ (NguyenPT 20170711) Add button Add new
    
    // MARK: Methods
    //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
//    /**
//     * Handle when tap menu item
//     */
//    func asignNotifyForMenuItem() {
//        NotificationCenter.default.addObserver(self, selector: #selector(configItemTap(_:)), name:NSNotification.Name(rawValue: G05Const.NOTIFY_NAME_G05_ORDER_LIST_CONFIG_ITEM), object: nil)
//    }
    //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
    //++ BUG0060-SPJ (NguyenPT 20170421) Add refresh control
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        let status = DomainConst.ORDER_STATUS_TYPE_ALL
        OrderVIPListRequest.request(action: action,
                                       view: self,
                                       page: _page,
                                       status: status)
    }
    
    /**
     * Reset data
     */
    private func resetData() {
        _data.clearData()
        // Reset current search value
        self._page      = 0
        // Reload table
        _tableView.reloadData()
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        self.resetData()
        requestData(action: #selector(finishHandleRefresh(_:)))
    }
    
    /**
     * Handle finish refresh
     */
    internal func finishHandleRefresh(_ notification: Notification) {
        setData(notification)
        refreshControl.endRefreshing()
    }
    //-- BUG0060-SPJ (NguyenPT 20170421) Add refresh control
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
//        // Menu item tap
//        asignNotifyForMenuItem()
        //-- BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
        
        // Get height of status bar + navigation bar
        let heigh = self.getTopHeight()
        
        //++ BUG0124-SPJ (NguyenPT 20170711) Add button Add new
        // Customer name label
        _lblCustomerName.frame = CGRect(x: 0, y: heigh,
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: GlobalConst.LABEL_H * 3)
        _lblCustomerName.text = BaseModel.shared.getUserInfoLogin(id: DomainConst.KEY_FIRST_NAME)
        _lblCustomerName.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        _lblCustomerName.textColor = GlobalConst.BUTTON_COLOR_RED
        _lblCustomerName.textAlignment = .center
        _lblCustomerName.lineBreakMode = .byWordWrapping
        _lblCustomerName.numberOfLines = 0
        self.view.addSubview(_lblCustomerName)
        
//        iconImg.image = ImageManager.getImage(named: DomainConst.ORDER_ICON_IMG_NAME)
//        iconImg.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W / 2) / 2,
//                               y: heigh + GlobalConst.MARGIN,
//                               width: GlobalConst.LOGIN_LOGO_W / 2,
//                               height: GlobalConst.LOGIN_LOGO_H / 2)
//        iconImg.translatesAutoresizingMaskIntoConstraints = true
        iconImg.isHidden = true
        //-- BUG0124-SPJ (NguyenPT 20170711) Add button Add new
        // Order list view
        _tableView.translatesAutoresizingMaskIntoConstraints = true
        _tableView.frame = CGRect(x: 0,
                                  //++ BUG0124-SPJ (NguyenPT 20170711) Add button Add new
                                  //y: iconImg.frame.maxY,
                                  y: _lblCustomerName.frame.maxY,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  //height: GlobalConst.SCREEN_HEIGHT - iconImg.frame.maxY)
                                  height: GlobalConst.SCREEN_HEIGHT - _lblCustomerName.frame.maxY - GlobalConst.BUTTON_H - GlobalConst.MARGIN)
                                  //-- BUG0124-SPJ (NguyenPT 20170711) Add button Add new
        _tableView.separatorStyle = .singleLine
        let frameworkBundle = Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)
        _tableView.register(UINib(nibName: DomainConst.TABLE_VIEW_CELL_ORDER_TYPE, bundle: frameworkBundle), forCellReuseIdentifier: DomainConst.TABLE_VIEW_CELL_ORDER_TYPE)
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.contentInset = UIEdgeInsets.zero
        _tableView.addSubview(refreshControl)
        // NavBar setup
        //++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        //setupNavigationBar(title: DomainConst.CONTENT00231, isNotifyEnable: BaseModel.shared.checkIsLogin())
        createNavigationBar(title: DomainConst.CONTENT00231)
        //-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        //++ BUG0124-SPJ (NguyenPT 20170711) Add button Add new
        // Button create
        let btnCreate = UIButton()
        CommonProcess.createButtonLayout(btn: btnCreate,
                                         x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                         y:  GlobalConst.SCREEN_HEIGHT - GlobalConst.BUTTON_H - GlobalConst.MARGIN,
                                         text: DomainConst.CONTENT00065.uppercased(),
                                         action: #selector(btnCreateTapped(_:)),
                                         target: self,
                                         img: DomainConst.ADD_ICON_IMG_NAME,
                                         tintedColor: UIColor.white)
        btnCreate.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                 left: GlobalConst.MARGIN,
                                                 bottom: GlobalConst.MARGIN,
                                                 right: GlobalConst.MARGIN)
        self.view.addSubview(btnCreate)
        //-- BUG0124-SPJ (NguyenPT 20170711) Add button Add new
        //++ BUG0060-SPJ (NguyenPT 20170421) Change name of request function
        //OrderVIPListRequest.requestOrderVIPList(action: #selector(setData(_:)), view: self, page: self._page)
        requestData()
        //-- BUG0060-SPJ (NguyenPT 20170421) Change name of request function
        self.view.makeComponentsColor()
    }
    
    //++ BUG0124-SPJ (NguyenPT 20170711) Add button Add new
    /**
     * Create new event handler
     */
    internal func btnCreateTapped(_ sender: AnyObject) {
        self.pushToView(name: G05Const.G05_F01_S02_VIEW_CTRL)
    }
    //-- BUG0124-SPJ (NguyenPT 20170711) Add button Add new

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Set data for controls
     */
    override func setData(_ notification: Notification) {
        //++ BUG0060-SPJ (NguyenPT 20170421) Add refresh control
//        let data = (notification.object as! OrderVIPListRespModel)
//        G05F00S01VC._data.total_page    = data.total_page
//        G05F00S01VC._data.total_record  = data.total_record
//        G05F00S01VC._data.append(contentOf: data.getRecord())
        let data = (notification.object as! String)
        let model = OrderVIPListRespModel(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
        }
        //-- BUG0060-SPJ (NguyenPT 20170421) Add refresh control
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
        _tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _data.getRecord().count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DomainConst.TABLE_VIEW_CELL_ORDER_TYPE) as! TableCellOrderType
        if _data.getRecord().count > indexPath.row {
            cell.setData(vipData: _data.getRecord()[indexPath.row])
        }
        return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableCellOrderType.CELL_HEIGHT
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        G05F00S02VC._id = _data.getRecord()[indexPath.row].id
        self.pushToView(name: G05Const.G05_F00_S02_VIEW_CTRL)
        self.showToast(message: "Open order detail: \(G05F00S02VC._id)")
    }
    
//    /**
//     * Get status number of item
//     * - returns: Status number value
//     */
//    public static func getStatusNumber() -> String {
//        for item in _data.getRecord() {
//            if item.id == G05F00S02VC._id {
//                return item.status_number
//            }
//        }
//        return DomainConst.BLANK
//    }
    
    /**
     * Tells the delegate the table view is about to draw a cell for a particular row.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Total page does not 1
        if _data.total_page != 1 {
            let lastElement = _data.getRecord().count - 1
            // Current is the last element
            if indexPath.row == lastElement {
                self._page += 1
                // Page less than total page
                if self._page <= _data.total_page {
                    //++ BUG0060-SPJ (NguyenPT 20170421) Change name of request function
                    //OrderVIPListRequest.requestOrderVIPList(action: #selector(setData(_:)), view: self, page: self._page)
                    OrderVIPListRequest.request(action: #selector(setData(_:)),
                                                view: self,
                                                page: self._page)
                    //-- BUG0060-SPJ (NguyenPT 20170421) Change name of request function
                }
            }
        }
    }
    
    
    /**
     * View did appear
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self._tableView.reloadData()
    }
    
    /**
     * Clear data of view.
     * Reset currentPage value
     * Reset uphold list value
     */
    override func clearData() {
        _data = OrderVIPListRespModel()
    }
}
