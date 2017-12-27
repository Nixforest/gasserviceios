//
//  G07F00S01VC.swift
//  project
//
//  Created by SPJ on 4/7/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G07F00S01VC: ParentViewController, UITableViewDelegate, UITableViewDataSource, OrderConfirmDelegate {
    // MARK: Properties
    /** Segment button */
    private var _segment:           UISegmentedControl  = UISegmentedControl(
        items: [
            DomainConst.CONTENT00074,
            DomainConst.CONTENT00311
        ])
    /** Table view */
    private var _tblView:           UITableView         = UITableView()
    /** Data */
    private var _data:              OrderFamilyListRespModel  = OrderFamilyListRespModel()
    /** Page number */
    private var _page:              Int                 = 0
    /** Type: New (0) or Finish (1) */
    private var _type:              Int                 = 0
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    //++ BUG0081-SPJ (NguyenPT 20170510) UITableView not reload until scroll
    /** Flag check need reload table view at viewDidAppear first time */
    private var _isFirstReload:     Bool                = false
    //++ BUG0081-SPJ (NguyenPT 20170510) UITableView not reload until scroll
    
    // MARK: Methods
    
    /**
     * Request data from server
     * - paramter comletionHandler: Handler when finish request
     */
    //++ BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
    //private func requestData(action: Selector = #selector(setData(_:))) {
    private func requestData(completionHandler: ((Any?)->Void)?) {
        var status = "1"
        switch _type {
        case 1:
            status = "2"
        default:
            status = "1"
        }
//        OrderFamilyListRequest.request(action: action,
//                                       view: self,
//                                       page: String(_page),
//                                       status: status)
        OrderFamilyListRequest.request(view: self, page: String(_page),
                                       status: status,
                                       completionHandler: completionHandler)
    }
    
    /**
     * Request data from server
     */
    private func requestData() {
        requestData(completionHandler: finishRequest)
    }
    //-- BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
    
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
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        self.resetData()
        //++ BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
        //requestData(action: #selector(finishHandleRefresh(_:)))
        requestData(completionHandler: finishHandleRefresh)
        //-- BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
    }
    
    /**
     * Handle finish refresh
     */
    //++ BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
    //internal func finishHandleRefresh(_ notification: Notification) {
        //setData(notification)
    internal func finishHandleRefresh(_ model: Any?) {
        finishRequest(model)
    //-- BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
        refreshControl.endRefreshing()
    }
    
    /**
     * Handle change value of segment
     */
    internal func segmentChange(_ sender: AnyObject) {
        _type = _segment.selectedSegmentIndex
        switch _type {
        case 0:
            break
        case 1:
            break
        default:
            break
        }
        resetData()
        requestData()
    }
    
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        //++ BUG0182-SPJ (NguyenPT 20171219) Create transaction
//        createNavigationBar(title: DomainConst.CONTENT00310)
        createNavigationBar(title: DomainConst.CONTENT00541)
        //-- BUG0182-SPJ (NguyenPT 20171219) Create transaction
        
        // Create content
        var offset: CGFloat = getTopHeight()
        
        // Segment
        let font = UIFont.systemFont(ofSize: GlobalConst.BASE_FONT_SIZE)
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
        offset = offset + _segment.frame.height
        self.view.addSubview(_segment)
        
        // Table View
        _tblView.register(UINib(nibName: OrderEmployeeTableViewCell.theClassName,
                                bundle: Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)),
                          forCellReuseIdentifier: OrderEmployeeTableViewCell.theClassName)
        _tblView.delegate = self
        _tblView.dataSource = self
        _tblView.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT - offset)
        _tblView.addSubview(refreshControl)
        self.view.addSubview(_tblView)
        
        //++ BUG0182-SPJ (NguyenPT 20171219) Create transaction
        // Add Add button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.QUICK_ACTION_ICON_IMG_NAME,
                                       action: #selector(actionTapped(_:)),
                                       target: self)
        //-- BUG0182-SPJ (NguyenPT 20171219) Create transaction
        
        // Request data from server
        requestData()
        self.view.makeComponentsColor()
    }
    
    //++ BUG0182-SPJ (NguyenPT 20171219) Create transaction
    /**
     * Handle tap on Search button
     * - parameter sender: AnyObject
     */
    internal func actionTapped(_ sender: AnyObject) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00436,
                                      message: DomainConst.CONTENT00437,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
        let storeCard = UIAlertAction(title: DomainConst.CONTENT00542,
                                   style: .default, handler: {
                                    action in
                                    self.requestCreateTransaction()
        })
        alert.addAction(storeCard)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = sender as? UIButton
            presenter.sourceRect = sender.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    internal func requestCreateTransaction() {
        showAlert(message: DomainConst.CONTENT00543,
                  okHandler: {
                    alert in
                    TransactionCreateRequest.request(action: #selector(self.finishRequestTransactionCreate),
                                                     view: self)
        }, cancelHandler: {alert in})
        
    }
    
    internal func finishRequestTransactionCreate(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = TransactionCreateResp(jsonString: data)
        if model.isSuccess() {
            G07F00S02VC._id = model.id
            self.pushToView(name: G07F00S02VC.theClassName)
        } else {
            showAlert(message: model.message)
        }
    }
    //-- BUG0182-SPJ (NguyenPT 20171219) Create transaction
    
    //++ BUG0081-SPJ (NguyenPT 20170510) UITableView not reload until scroll
    /**
     * Notifies the view controller that its view was added to a view hierarchy.
     */
    override func viewDidAppear(_ animated: Bool) {
        if !_isFirstReload {
            _isFirstReload = true
            _tblView.reloadData()
        }
    }
    //-- BUG0081-SPJ (NguyenPT 20170510) UITableView not reload until scroll
    
    override func finishRequest(_ model: Any?) {
        let data = model as! String
        let model = OrderFamilyListRespModel(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
            _tblView.reloadData()
        }
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    
    //++ BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
//    override func setData(_ notification: Notification) {
//        let data = (notification.object as! String)
//        let model = OrderFamilyListRespModel(jsonString: data)
//        if model.isSuccess() {
//            _data.total_page = model.total_page
//            _data.total_record = model.total_record
//            _data.append(contentOf: model.getRecord())
//            _tblView.reloadData()
//        }
    //    }
    //-- BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism

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
            let cell: OrderEmployeeTableViewCell = tableView.dequeueReusableCell(
                withIdentifier: OrderEmployeeTableViewCell.theClassName)
                as! OrderEmployeeTableViewCell
            cell.setData(data: _data.getRecord()[indexPath.row])
            cell.delegate = self
            return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return OrderEmployeeTableViewCell.CELL_HEIGHT
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
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        G07F00S02VC._id = _data.getRecord()[indexPath.row].id
        self.pushToView(name: G07F00S02VC.theClassName)
    }
    
    /**
     * Handle tapped event on action button
     */
    public func btnActionTapped(_ sender: AnyObject) {
        OrderFamilyHandleRequest.requestConfirm(
            action: #selector(finishConfirmHandler(_:)),
            view: self,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: (sender as! UIButton).accessibilityIdentifier!)
    }
    
    /**
     * Handle finish confirm order
     */
    internal func finishConfirmHandler(_ notification: Notification) {
        NotificationCenter.default.removeObserver(self)
        let data = (notification.object as! String)
        let model = OrderFamilyViewRespModel(jsonString: data)
        if model.isSuccess() {
            //++ BUG0072-SPJ (NguyenPT 20170424) No need confirm message
//            showAlert(message: DomainConst.CONTENT00322,
//                      okHandler: {
//                        alert in
//                        self.handleRefresh(self)
//                        G07F00S02VC._id = model.getRecord().id
//                        self.pushToView(name: G07F00S02VC.theClassName)
//            },
//                      cancelHandler: {
//                        alert in
//                        self.handleRefresh(self)
//            })
            self.handleRefresh(self)
            G07F00S02VC._id = model.getRecord().id
            self.pushToView(name: G07F00S02VC.theClassName)
            //-- BUG0072-SPJ (NguyenPT 20170424) No need confirm message
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle tapped event on cancel button
     */
    public func btnCancelTapped(_ sender: AnyObject) {
        OrderFamilyHandleRequest.requestCancelConfirm(
            action: #selector(finishCancelHandler(_:)),
            view: self,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: (sender as! UIButton).accessibilityIdentifier!)
    }
    
    /**
     * Handle finish cancel order
     */
    internal func finishCancelHandler(_ notification: Notification) {
        NotificationCenter.default.removeObserver(self)
        let data = (notification.object as! String)
        let model = OrderFamilyViewRespModel(jsonString: data)
        if model.isSuccess() {
            //++ BUG0072-SPJ (NguyenPT 20170424) No need confirm message
//            showAlert(message: DomainConst.CONTENT00323,
//                      okHandler: {
//                        alert in
//                        self.handleRefresh(self)
//            })            
            self.handleRefresh(self)
            //-- BUG0072-SPJ (NguyenPT 20170424) No need confirm message
        } else {
            showAlert(message: model.message)
        }
    }
}
