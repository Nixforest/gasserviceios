//
//  G05F00S03VC.swift
//  project
//
//  Created by SPJ on 4/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F00S03VC: ParentViewController, UITableViewDataSource, UITableViewDelegate, OrderConfirmDelegate {
    // MARK: Properties
    /** Segment button */
    private var _segment:           UISegmentedControl  = UISegmentedControl(
        items: [
            DomainConst.CONTENT00074,
            DomainConst.CONTENT00311
        ])
    /** Table view */
    //@IBOutlet weak var _tblView:    UITableView!
    /** Table view */
    private var _tblView:           UITableView         = UITableView()
    /** Static data */
    private var _data:              OrderVIPListRespModel   = OrderVIPListRespModel()
    /** Current page */
    private var _page:              Int                     = 0
    /** Type: New (0) or Finish (1) */
    private var _type:              Int                     = 0
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Current selection id */
    private var _currentId:         String                  = DomainConst.BLANK
    
    // MARK: Utility methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        var status = DomainConst.ORDER_STATUS_TYPE_NEW
        switch _type {
        case 1:
            status = DomainConst.ORDER_STATUS_TYPE_COMPLETE
        default:
            status = DomainConst.ORDER_STATUS_TYPE_NEW
        }
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
        _tblView.reloadData()
    }
    
    // MARK: Handle events
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
     * Handle tapped event on action button
     */
    public func btnActionTapped(_ sender: AnyObject) {
        _currentId = (sender as! UIButton).accessibilityIdentifier!
        OrderVipSetEventRequest.request(
            action: #selector(finishConfirmHandler(_:)),
            view: self,
            actionType: ActionTypeEnum.EMPLOYEE_NHAN_GIAO_HANG.rawValue,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: _currentId,
            note: DomainConst.BLANK)
    }
    
    /**
     * Handle finish confirm order
     */
    internal func finishConfirmHandler(_ notification: Notification) {
        NotificationCenter.default.removeObserver(self)
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            showAlert(message: DomainConst.CONTENT00322,
                      okHandler: {
                        alert in
                        self.handleRefresh(self)
                        G05F00S04VC._id = self._currentId
                        self.pushToView(name: G05F00S04VC.theClassName)
            },
                      cancelHandler: {
                        alert in
                        self.handleRefresh(self)
            })
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle tapped event on cancel button
     */
    public func btnCancelTapped(_ sender: AnyObject) {
        _currentId = (sender as! UIButton).accessibilityIdentifier!
        OrderVipSetEventRequest.request(
            action: #selector(finishConfirmHandler(_:)),
            view: self,
            actionType: ActionTypeEnum.EMPLOYEE_HUY_GIAO_HANG.rawValue,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: _currentId,
            note: DomainConst.BLANK)
    }
    
    /**
     * Handle finish cancel order
     */
    internal func finishCancelHandler(_ notification: Notification) {
        NotificationCenter.default.removeObserver(self)
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            showAlert(message: DomainConst.CONTENT00323,
                      okHandler: {
                        alert in
                        self.handleRefresh(self)
            })
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle finish refresh
     */
    internal func finishHandleRefresh(_ notification: Notification) {
        setData(notification)
        refreshControl.endRefreshing()
    }
    
    // MARK: Setup layout-control
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        self.resetData()
        requestData(action: #selector(finishHandleRefresh(_:)))
    }
    
    // MARK: Override from UIViewController
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00332)
        
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
        _tblView.register(UINib(nibName: TableCellOrderType.theClassName,
                                bundle: Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)),
                          forCellReuseIdentifier: TableCellOrderType.theClassName)
        _tblView.delegate = self
        _tblView.dataSource = self
        _tblView.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT - offset)
        _tblView.addSubview(refreshControl)
        self.view.addSubview(_tblView)
        // Request data from server
        //requestData()
        self.view.makeComponentsColor()
    }
    
    /**
     * Set data for this view controller
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = OrderVIPListRespModel(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
            self._tblView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Notifies the view controller that its view is about to be added to a view hierarchy.
     */
    override func viewWillAppear(_ animated: Bool) {
        resetData()
        requestData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UITableViewDataSource-Delegate
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
            let cell: TableCellOrderType = tableView.dequeueReusableCell(
                withIdentifier: TableCellOrderType.theClassName)
                as! TableCellOrderType
            //if _data.getRecord().count > indexPath.row {
                cell.setData(vipData: _data.getRecord()[indexPath.row])
                cell.delegate = self
                //cell.selectionStyle = .none
            //}
            return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableCellOrderType.CELL_HEIGHT
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
        G05F00S04VC._id = _data.getRecord()[indexPath.row].id
        self.pushToView(name: G05F00S04VC.theClassName)
    }
}
