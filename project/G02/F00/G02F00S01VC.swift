//
//  G02F00S01VC.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class G02F00S01VC: BaseParentViewController {
    // MARK: Properties
    /** Information table view */
    var tblInfo:            UITableView             = UITableView()
    /** Current page */
    var page:               Int                     = 0
    /** Current data */
    var _data:              IssueListRespBean       = IssueListRespBean()
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    // MARK: Static values
    
    // MARK: Constant

    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        self.createNavigationBar(title: DomainConst.CONTENT00131)
        createInfoTableView()
        self.view.addSubview(self.tblInfo)
        // Button create customer
        let btnIssue = UIButton()
        CommonProcess.createButtonLayout(btn: btnIssue,
                                         x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                         y:  GlobalConst.SCREEN_HEIGHT - GlobalConst.BUTTON_H - GlobalConst.MARGIN,
                                         text: DomainConst.CONTENT00590.uppercased(),
                                         action: #selector(self.createIssue(_:)),
                                         target: self,
                                         img: DomainConst.ADD_ICON_IMG_NAME,
                                         tintedColor: UIColor.white)
        btnIssue.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                         left: GlobalConst.MARGIN,
                                                         bottom: GlobalConst.MARGIN,
                                                         right: GlobalConst.MARGIN)
        self.view.addSubview(btnIssue)
        requestData()
    }
    
    internal func createIssue(_ sender: AnyObject) {
        pushToView(name: G02F00S04VC.theClassName)
    }
    
    /**
     * Set data
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = IssueListRespBean(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
            tblInfo.reloadData()
        } else {
            showAlert(message: model.message)
        }
    }
    
    // MARK: Event handler
    
    // MARK: Logic
    /**
     * Request data
     */
    internal func requestData(action: Selector = #selector(setData(_:))) {
        IssueListRequest.request(
            action: action, view: self,
            page: String(self.page),
            type: "1",
            customer_id: "", problem: "")
    }
    
    /**
     * Reset data
     */
    private func resetData() {
        _data.clearData()
        // Reset current search value
        self.page      = 0
        // Reload table
        tblInfo.reloadData()
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
    
    // MARK: Layout
    // MARK: Information table view
    private func createInfoTableView() {
        tblInfo.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height)
        tblInfo.dataSource = self
        tblInfo.delegate = self
        tblInfo.addSubview(refreshControl)
//        tblInfo.register(UINib(nibName: G12F00S01Cell.theClassName, bundle: nil),
//                         forCellReuseIdentifier: G12F00S01Cell.theClassName)
    }
}

// MARK: Protocol - UITableViewDataSource
extension G02F00S01VC: UITableViewDataSource {
    /**
     * Asks the data source to return the number of sections in the table view.
     * - returns: 1 section
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     * - returns: List information count
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._data.record.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > self._data.record.count {
            return UITableViewCell()
        }
        let data = self._data.record[indexPath.row]
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                   reuseIdentifier: "Cell")
        cell.textLabel?.text = data.customer_name
        cell.textLabel?.font = GlobalConst.BASE_BOLD_FONT
        cell.detailTextLabel?.text = data.created_date + " - " + data.problem_text
        cell.detailTextLabel?.font = GlobalConst.BASE_FONT
        
        return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

// MARK: Protocol - UITableViewDataSource
extension G02F00S01VC: UITableViewDelegate {
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = G02F00S02VC(nibName: G02F00S02VC.theClassName,
                               bundle: nil)
        view.setData(id: _data.getRecord()[indexPath.row].id)
        self.push(view, animated: true)
    }
    
    /**
     * Tells the delegate the table view is about to draw a cell for a particular row.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Total page does not 1
        if _data.total_page != 1 {
            let lastElement = _data.getRecord().count - 1
            // Current is the last element
            if indexPath.row == lastElement {
                self.page += 1
                // Page less than total page
                if self.page <= _data.total_page {
                    self.requestData()
                }
            }
        }
    }
}
