//
//  G10F00S01VC.swift
//  project
//
//  Created by SPJ on 5/31/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G10F00S01VC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Table view */
    private var _tblView:           UITableView                     = UITableView()
    /** Refrest control */
    lazy var refreshControl:        UIRefreshControl                = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Static data */
    private var _data:              ReportListRespModel   = ReportListRespModel()
    
    // MARK: Utility methods
    /**
     * Reset data
     */
    private func resetData() {
        _data.clearData()
        // Reload table
        _tblView.reloadData()
    }
    
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        ReportListRequest.request(action: action, view: self)
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        self.resetData()
        requestData(action: #selector(finishHandleRefresh(_:)))
    }
    // MARK: Event handler
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
        let model = ReportListRespModel(jsonString: data)
        if model.isSuccess() {
            _data.record = model.record
            DispatchQueue.main.async {
                self._tblView.reloadData()
            }
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Clear data of view.
     */
    override func clearData() {
        _data.clearData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00159)
        let height = self.getTopHeight()
        
        // Table View
        _tblView.register(UITableViewCell.self,
                          forCellReuseIdentifier: "cell")
        _tblView.delegate = self
        _tblView.dataSource = self
        _tblView.frame = CGRect(x: 0, y: 0,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT)
        _tblView.addSubview(refreshControl)
        self.view.addSubview(_tblView)
        // Request data from server
        requestData()
        self.view.makeComponentsColor()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            // Set title
            cell?.textLabel?.text           = _data.getRecord()[indexPath.row].name
            cell?.textLabel?.textColor      = GlobalConst.MAIN_COLOR
            cell?.textLabel?.numberOfLines  = 0
            cell?.textLabel?.lineBreakMode  = .byWordWrapping
            // Set image
            let img = ImageManager.getImage(named: DomainConst.REPORT_SUM_ICON_IMG_NAME)
            let tinted = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            cell?.imageView?.image = tinted
            cell?.imageView?.tintColor = GlobalConst.MAIN_COLOR
            return cell!
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if _data.getRecord().count <= indexPath.row {
            return
        }
        switch _data.getRecord()[indexPath.row].id {
        case DomainConst.KEY_REPORT_INVENTORY:
            self.pushToView(name: G10F00S02VC.theClassName)
        case DomainConst.KEY_REPORT_ORDER_FAMILY:
            self.pushToView(name: G10F00S03VC.theClassName)
        case DomainConst.KEY_REPORT_CASHBOOK:
            self.pushToView(name: G10F00S04VC.theClassName)
        default:
            return
        }
    }
}
