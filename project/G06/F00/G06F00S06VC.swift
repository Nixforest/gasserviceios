//
//  G06F00S06VC.swift
//  project
//
//  Created by SPJ on 6/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F00S06VC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Static data */
    private var _data:              CCSCodeListRespModel = CCSCodeListRespModel()
    /** Current page */
    private var _page:              Int                 = 0
    /** Table view */
    @IBOutlet weak var _tblView: UITableView!
    /** Refrest control */
    lazy var refreshControl:        UIRefreshControl                = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Utility methods
    /**
     * Reset data
     */
    private func resetData() {
        _data.clearData()
        // Reset current search value
        self._page      = 0
        // Reload table
        _tblView.reloadData()
    }
    
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        CCSCodeListRequest.request(action: action,
                                   view: self,
                                   page: String(_page))
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
    
    // MARK: Override methods
    /**
     * Handle finish request data
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CCSCodeListRespModel(jsonString: data)
        if model.isSuccess() {
            // Update data
            _data.total_page    = model.total_page
            _data.total_record  = model.total_record
            _data.append(contentOf: model.getRecord())
            DispatchQueue.main.async {
                self._tblView.reloadData()
            }
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Clear data of view.
     * Reset currentPage value
     * Reset uphold list value
     */
    override func clearData() {
        _page = 0
        _data.clearData()
    }
    
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00445)
//        var offset: CGFloat = self.getTopHeight()
        // Table
        _tblView.addSubview(refreshControl)
        _tblView.frame = CGRect(x: 0,
                                y: 0,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT)
        _tblView.rowHeight = UITableViewAutomaticDimension
        _tblView.estimatedRowHeight = 500
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
    
    
    // MARK: - UITableViewDataSource
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _data.getRecord().count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            var cell = tableView.dequeueReusableCell(
                withIdentifier: G06Const.G06F00S06_TABLE_VIEW_CELL_ID)
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: G06Const.G06F00S06_TABLE_VIEW_CELL_ID)
                cell?.selectionStyle = .none
            }
            // Set title
            cell?.textLabel?.text           = _data.getRecord()[indexPath.row].name
            cell?.textLabel?.textColor      = GlobalConst.MAIN_COLOR
            cell?.textLabel?.textAlignment = .center
            
            return cell!
    }
    
    /**
     * Tells the delegate the table view is about to draw a cell for a particular row.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Total page does not 1
        if self._data.total_page != 1 {
            let lastElement = self._data.getRecord().count - 1
            // Current is the last element
            if indexPath.row == lastElement {
                self._page += 1
                // Page less than total page
                if self._page <= self._data.total_page {
                    requestData()
                }
            }
        }
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
