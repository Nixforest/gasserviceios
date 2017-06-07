//
//  G05F00S03VC.swift
//  project
//
//  Created by SPJ on 4/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F00S03VC: ParentViewController, UITableViewDataSource, UITableViewDelegate, OrderConfirmDelegate, UISearchBarDelegate {
    // MARK: Properties
    /** Segment button */
    private var _segment:           UISegmentedControl  = UISegmentedControl(
        items: [
            DomainConst.CONTENT00074,
            DomainConst.CONTENT00311,
            //++ BUG0104-SPJ (NguyenPT 20170607) Add new segment
            DomainConst.CONTENT00434
            //-- BUG0104-SPJ (NguyenPT 20170607) Add new segment
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
    private var _type:              Int                     = 1
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Current selection id */
    private var _currentId:         String                  = DomainConst.BLANK
    //++ BUG0104-SPJ (NguyenPT 20170607) Add new view
    /** Search view */
    private var _viewSearch:        UIView = UIView()
    /** Search input view */
    private var _viewInput:         UIView = UIView()
    /** From date value */
    private var _fromDate:          String = CommonProcess.getPrevMonth()
    /** To date value */
    private var _toDate:            String = CommonProcess.getCurrentDate()
    /** Current customer id */
    private var _customerId:        String                  = DomainConst.NUMBER_ZERO_VALUE
    /** Date picker */
    private var _datePickerFrom:    DatePickerView          = DatePickerView()
    /** Date picker */
    private var _datePickerTo:      DatePickerView          = DatePickerView()
    /** Search bar */
    private var _searchBar:         UISearchBar             = UISearchBar()
    /** Search bar table view */
    private var _tblSearchBar:      UITableView             = UITableView()
    /** Data */
    private var _dataCustomer:      [ConfigBean]                    = [ConfigBean]()
    /** Flag begin search */
    private var _beginSearch:       Bool                            = false
    /** Flag search active */
    private var _searchActive:      Bool                            = false
    /** Tap gesture hide keyboard */
    var _gestureHideKeyboard:       UIGestureRecognizer             = UIGestureRecognizer()
    /** Flag check keyboard is show or hide */
    private var _isKeyboardShow:    Bool                            = false
    //-- BUG0104-SPJ (NguyenPT 20170607) Add new view
    
    // MARK: Utility methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
//        var status = DomainConst.ORDER_STATUS_TYPE_NEW
//        switch _type {
//        case 1:
//            status = DomainConst.ORDER_STATUS_TYPE_COMPLETE
//        default:
//            status = DomainConst.ORDER_STATUS_TYPE_NEW
        //        }
        _fromDate = _datePickerFrom.getValue()
        _toDate = _datePickerTo.getValue()
        OrderVIPListRequest.request(action: action,
                                       view: self,
                                       page: _page,
                                       status: String(_type),
                                       from: _fromDate,
                                       to: _toDate,
                                       customerId: _customerId)
    }
    
    /**
     * Reset data
     */
    private func resetData() {
        _data.clearData()
        _datePickerFrom.setValue(value: CommonProcess.getPrevMonth())
        _datePickerTo.setValue(value: CommonProcess.getCurrentDate())
        _customerId     = DomainConst.NUMBER_ZERO_VALUE
        if _searchBar.text != nil {
            _searchBar.text = DomainConst.BLANK
        }
        // Reset current search value
        self._page      = 0
        // Reload table
        _tblView.reloadData()
    }
    
    /**
     * Set up search view
     */
    private func setupSearchView() {
        // Search view
        _viewSearch.frame = CGRect(x: 0, y: self.getTopHeight(),
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: GlobalConst.SCREEN_HEIGHT - self.getTopHeight())
        _viewSearch.isHidden = true
        _viewSearch.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.view.addSubview(_viewSearch)
        let inputWidth = GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN
        // Input view
        _viewInput.frame = CGRect(x: GlobalConst.MARGIN,
                                  y: GlobalConst.MARGIN,
                                  width: inputWidth,
                                  height: DatePickerView.STATIC_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT + GlobalConst.BUTTON_H)
        _viewInput.backgroundColor = UIColor.white
        _viewInput.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        _viewSearch.addSubview(_viewInput)
        var offset: CGFloat = 0.0
        
        // From date
        _datePickerFrom = DatePickerView(frame: CGRect(x: 0,
                                                       y: offset,
                                                       width: inputWidth / 2,
                                                       height: GlobalConst.LABEL_H * 2))
        _datePickerFrom.setTitle(title: DomainConst.CONTENT00412)
        _datePickerFrom.setValue(value: _fromDate)
        _datePickerFrom.showTodayButton(isShow: false)
        _datePickerFrom.setTextAlignment(alignment: .center)
        _viewInput.addSubview(_datePickerFrom)
        
        // To date
        _datePickerTo = DatePickerView(frame: CGRect(x: inputWidth / 2,
                                                     y: offset,
                                                     width: inputWidth / 2,
                                                     height: GlobalConst.LABEL_H * 2))
        _datePickerTo.setTitle(title: DomainConst.CONTENT00413)
        _datePickerTo.setValue(value: _toDate)
        _datePickerTo.showTodayButton(isShow: false)
        _datePickerTo.setTextAlignment(alignment: .center)
        _viewInput.addSubview(_datePickerTo)
        offset += DatePickerView.STATIC_HEIGHT - GlobalConst.MARGIN
        
        // Search bar
        _searchBar.delegate = self
        _searchBar.frame = CGRect(x: 0, y: offset,
                                  width: inputWidth,
                                  height: GlobalConst.SEARCH_BOX_HEIGHT)
        _searchBar.placeholder = DomainConst.CONTENT00435
        //_searchBar.layer.shadowColor = UIColor.black.cgColor
        //_searchBar.layer.shadowOpacity = 0.5
        _searchBar.layer.masksToBounds = false
        _searchBar.showsCancelButton = true
        _searchBar.showsBookmarkButton = false
        _searchBar.searchBarStyle = .default
        _viewInput.addSubview(_searchBar)
        offset += _searchBar.frame.height + GlobalConst.MARGIN
        
        // Search button
        let btnSearch = UIButton()
        btnSearch.frame = CGRect(x: 0, y: offset,
                                 width: _viewInput.frame.width,
                                 height: GlobalConst.BUTTON_H)
        btnSearch.setTitle(DomainConst.CONTENT00287, for: UIControlState())
        btnSearch.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnSearch.setTitleColor(UIColor.white, for: UIControlState())
        btnSearch.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnSearch.addTarget(self, action: #selector(btnSearchTapped(_:)), for: .touchUpInside)
        self._viewInput.addSubview(btnSearch)
        
        // Gesture
        _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        // Show hide result of search bar action
        _tblSearchBar.isHidden = !_searchActive
        _tblSearchBar.frame = CGRect(x: 0, y: _searchBar.frame.maxY,
                                     width: GlobalConst.SCREEN_WIDTH,
                                     height: GlobalConst.CELL_IN_SEARCHBAR_TABLE_HEIGHT * 5)
        _tblSearchBar.delegate = self
        _tblSearchBar.dataSource = self
        _viewSearch.addSubview(_tblSearchBar)
    }
    
    // MARK: Handle events
    /**
     * Handle when tap button Search
     */
    internal func btnSearchTapped(_ sender: AnyObject) {
        self._fromDate  = _datePickerFrom.getValue()
        self._toDate    = _datePickerTo.getValue()
        _data.clearData()
//        resetData()
        requestData(action: #selector(finishSearch(_:)))
    }
    
    /**
     * Handle when finish search order
     */
    internal func finishSearch(_ notification: Notification) {
        _data.clearData()
        _viewSearch.isHidden = true
        setData(notification)
    }
    
    /**
     * Handle tap on Search menu icon
     * - parameter sender: AnyObject
     */
    internal func searchMenuIconTapped(_ sender: AnyObject) {
        if _viewSearch.isHidden {
            _viewSearch.isHidden = false
        } else {
            _viewSearch.isHidden = true
            _datePickerFrom.setValue(value: _fromDate)
            _datePickerTo.setValue(value: _toDate)
        }
    }
    
    /**
     * Handle change value of segment
     */
    internal func segmentChange(_ sender: AnyObject) {
        _type = _segment.selectedSegmentIndex + 1
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
            actionType: ActionTypeVIPCustomerEnum.EMPLOYEE_NHAN_GIAO_HANG.rawValue,
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
            //++ BUG0072-SPJ (NguyenPT 20170424) No need confirm message
//            showAlert(message: DomainConst.CONTENT00322,
//                      okHandler: {
//                        alert in
//                        self.handleRefresh(self)
//                        G05F00S04VC._id = self._currentId
//                        self.pushToView(name: G05F00S04VC.theClassName)
//            },
//                      cancelHandler: {
//                        alert in
//                        self.handleRefresh(self)
//            })
            self.handleRefresh(self)
            G05F00S04VC._id = self._currentId
            self.pushToView(name: G05F00S04VC.theClassName)
            //-- BUG0072-SPJ (NguyenPT 20170424) No need confirm message
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
            action: #selector(finishCancelHandler(_:)),
            view: self,
            actionType: ActionTypeVIPCustomerEnum.EMPLOYEE_HUY_GIAO_HANG.rawValue,
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
        
        // Add search button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.SEARCH_ICON_IMG_NAME,
                                       action: #selector(searchMenuIconTapped(_:)),
                                       target: self)
        // Search view
        setupSearchView()
        
        // Request data from server
        requestData()
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
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Notifies the view controller that its view is about to be added to a view hierarchy.
     */
    override func viewWillAppear(_ animated: Bool) {
//        resetData()
//        requestData()
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
        if tableView == _tblSearchBar {
            return _dataCustomer.count
        }
        return _data.getRecord().count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            if tableView == _tblSearchBar {     // Search result table
                let cell = UITableViewCell()
                cell.textLabel?.text = _dataCustomer[indexPath.row].name
                return cell
            }

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
        if tableView == _tblSearchBar {
            return UITableViewAutomaticDimension
        }
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
        if tableView == _tblSearchBar {
            _searchActive = false
            _tblSearchBar.isHidden = !_searchActive
            _searchBar.resignFirstResponder()
            
            // Update text of search bar
            _searchBar.text = _dataCustomer[indexPath.row].name
            // Clear current data
            clearData()
            // Update customer id
            _customerId = _dataCustomer[indexPath.row].id
            // Request data from server
//            requestData()
        } else if tableView == _tblView {
            G05F00S04VC._id = _data.getRecord()[indexPath.row].id
            self.pushToView(name: G05F00S04VC.theClassName)
        }
    }
    
    /**
     * Hide keyboard.
     */
    func hideKeyboard() {
        // Hide keyboard
        self._viewSearch.endEditing(true)
        // Turn off flag
        _isKeyboardShow = false
        // Remove hide keyboard gesture
        self.view.removeGestureRecognizer(_gestureHideKeyboard)
    }
    
    // MARK: - SearchbarDelegate
    /**
     * Handle begin search
     */
    func beginSearching()  {
        if _beginSearch == false {
            _beginSearch = true
        }
        // Remove all current data
        _dataCustomer.removeAll()
        
        if _searchBar.text != nil {
            // Get keyword
            let keyword = _searchBar.text!.removeSign().lowercased()
            CustomerListRequest.request(action: #selector(finishSearchCustomer(_:)),
                                        view: self,
                                        keyword: keyword)
        }
    }
    
    /**
     * Handle when finish search target
     */
    func finishSearchCustomer(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = SearchCustomerRespModel(jsonString: data)
        if model.isSuccess() {
            _dataCustomer = model.getRecord()
            // Load data for search bar table view
            _tblSearchBar.reloadData()
            // Show
            _tblSearchBar.isHidden = !_searchActive
            // Move to front
            //self.bringSubview(toFront: _tblSearchBar)
            _tblSearchBar.layer.zPosition = 1
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Tells the delegate that the user changed the search text.
     */
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredStr = searchText
        if filteredStr.characters.count > (DomainConst.SEARCH_TARGET_MIN_LENGTH - 1) {
            _beginSearch = false
            _searchActive = true
            // Start count
            /** Timer for search auto complete */
            //            var timer = Timer()
            //            timer.invalidate()
            //            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(beginSearching), userInfo: nil, repeats: false)
            
        } else {
            _beginSearch            = false
            _searchActive           = false
            // Hide search bar table view
            _tblSearchBar.isHidden  = !_searchActive
            // Reset current customer id
            _customerId             = DomainConst.BLANK
        }
    }
    
    /**
     * Tells the delegate that the cancel button was tapped.
     */
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        _searchActive = false
        // Clear textbox
        if _searchBar.text != nil {
            _searchBar.text = DomainConst.BLANK
        }
        _tblSearchBar.isHidden = !_searchActive
        // Hide keyboard
        self.view.endEditing(true)
    }
    
    /**
     * Tells the delegate that the search button was tapped.
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        _searchActive = true
        beginSearching()
    }
    
    /**
     * Tells the delegate when the user begins editing the search text.
     */
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        _searchActive = true
        _isKeyboardShow = true
        self.view.addGestureRecognizer(_gestureHideKeyboard)
    }
    
    /**
     * Tells the delegate that the user finished editing the search text.
     */
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        _searchActive = true
        _isKeyboardShow = false
        // If text is empty
        if (_searchBar.text?.isEmpty)! {
            // Clear cashbook data
            clearData()
            // Reset current customer id
            _customerId = DomainConst.BLANK
            // Request data from server
//            requestData()
        } else {
            self.view.endEditing(true)
        }
    }
}
