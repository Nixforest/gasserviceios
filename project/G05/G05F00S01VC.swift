//
//  G05F00S01VC.swift
//  project
//
//  Created by SPJ on 2/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F00S01VC: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    /** Table view */
    @IBOutlet weak var _tableView:  UITableView!
    /** Icon image */
    @IBOutlet weak var iconImg:     UIImageView!
    /** Static data */
    private static var _data:       OrderVIPListRespModel = OrderVIPListRespModel()
    /** Current page */
    private var _page = 0
    
    // MARK: Methods
    //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
//    /**
//     * Handle when tap menu item
//     */
//    func asignNotifyForMenuItem() {
//        NotificationCenter.default.addObserver(self, selector: #selector(configItemTap(_:)), name:NSNotification.Name(rawValue: G05Const.NOTIFY_NAME_G05_ORDER_LIST_CONFIG_ITEM), object: nil)
//    }
    //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
    
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
        iconImg.image = ImageManager.getImage(named: DomainConst.ORDER_ICON_IMG_NAME)
        iconImg.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W / 2) / 2,
                               y: heigh + GlobalConst.MARGIN,
                               width: GlobalConst.LOGIN_LOGO_W / 2,
                               height: GlobalConst.LOGIN_LOGO_H / 2)
        iconImg.translatesAutoresizingMaskIntoConstraints = true
        // Order list view
        _tableView.translatesAutoresizingMaskIntoConstraints = true
        _tableView.frame = CGRect(x: 0,
                                 y: iconImg.frame.maxY,
                                 width: GlobalConst.SCREEN_WIDTH,
                                 height: GlobalConst.SCREEN_HEIGHT - iconImg.frame.maxY)
        _tableView.separatorStyle = .singleLine
        let frameworkBundle = Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)
        _tableView.register(UINib(nibName: DomainConst.TABLE_VIEW_CELL_ORDER_TYPE, bundle: frameworkBundle), forCellReuseIdentifier: DomainConst.TABLE_VIEW_CELL_ORDER_TYPE)
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.contentInset = UIEdgeInsets.zero
        // NavBar setup
        setupNavigationBar(title: DomainConst.CONTENT00231, isNotifyEnable: BaseModel.shared.checkIsLogin())
        OrderVIPListRequest.requestOrderVIPList(action: #selector(setData(_:)), view: self, page: self._page)
        self.view.makeComponentsColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Set data for controls
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! OrderVIPListRespModel)
        G05F00S01VC._data.total_page    = data.total_page
        G05F00S01VC._data.total_record  = data.total_record
        G05F00S01VC._data.append(contentOf: data.getRecord())
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
        return G05F00S01VC._data.getRecord().count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DomainConst.TABLE_VIEW_CELL_ORDER_TYPE) as! TableCellOrderType
        if G05F00S01VC._data.getRecord().count > indexPath.row {
            cell.setData(vipData: G05F00S01VC._data.getRecord()[indexPath.row])
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
        G05F00S02VC._id = G05F00S01VC._data.getRecord()[indexPath.row].id
        self.pushToView(name: G05Const.G05_F00_S02_VIEW_CTRL)
        self.showToast(message: "Open order detail: \(G05F00S02VC._id)")
    }
    
    /**
     * Get status number of item
     * - returns: Status number value
     */
    public static func getStatusNumber() -> String {
        for item in G05F00S01VC._data.getRecord() {
            if item.id == G05F00S02VC._id {
                return item.status_number
            }
        }
        return DomainConst.BLANK
    }
    
    /**
     * Tells the delegate the table view is about to draw a cell for a particular row.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Total page does not 1
        if G05F00S01VC._data.total_page != 1 {
            let lastElement = G05F00S01VC._data.getRecord().count - 1
            // Current is the last element
            if indexPath.row == lastElement {
                self._page += 1
                // Page less than total page
                if self._page <= G05F00S01VC._data.total_page {
                    OrderVIPListRequest.requestOrderVIPList(action: #selector(setData(_:)), view: self, page: self._page)
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
        G05F00S01VC._data = OrderVIPListRespModel()
    }
}
