//
//  G09F00S01VC.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G09F00S01VC: ParentViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Segment button */
    private var _segment:           UISegmentedControl              = UISegmentedControl(
        items: [
            DomainConst.CONTENT00372,
            DomainConst.CONTENT00373
        ])
    /** Search bar */
    private var _searchBar:         UISearchBar                     = UISearchBar()
    /** Search bar table view */
    private var _tblSearchBar:      UITableView                     = UITableView()
    /** Data */
    private var _dataCustomer:      [ConfigBean]                    = [ConfigBean]()
    /** Flag begin search */
    private var _beginSearch:       Bool                            = false
    /** Flag search active */
    private var _searchActive:      Bool                            = false
    /** Static data */
    private var _data:              EmployeeCashBookListRespModel   = EmployeeCashBookListRespModel()
    /** Current page */
    private var _page:              Int                             = 0
    /** Type: In (1) or Out (2) */
    private var _lookup_type:       Int                             = 1
    /** Current customer Id */
    private var _customerId:        String                          = DomainConst.NUMBER_ZERO_VALUE
    /** Table view */
    private var _tblView:           UITableView                     = UITableView()
    /** Refrest control */
    lazy var refreshControl:        UIRefreshControl                = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Timer for search auto complete */
    private var timer:              Timer                           = Timer()
    /** Tap gesture hide keyboard */
    var _gestureHideKeyboard:       UIGestureRecognizer             = UIGestureRecognizer()
    /** Flag check keyboard is show or hide */
    private var _isKeyboardShow:    Bool                            = false
    /** Customer name label */
    private var _lblSummary:        UILabel                         = UILabel()
    /** Cashbook list type: (1) Manage, (2) Schedule */
    public static var _cashBookType:    String                      = DomainConst.CASHBOOK_TYPE_LIST
    
    
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
     * Hide keyboard.
     */
    func hideKeyboard() {
        // Hide keyboard
        self.view.endEditing(true)
        // Turn off flag
        _isKeyboardShow = false
        // Remove hide keyboard gesture
        self.view.removeGestureRecognizer(_gestureHideKeyboard)
    }
    
    /**
     * Handle start create new cashbook
     */
    private func openCreateCashBookScreen() {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00357,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
        for item in CacheDataRespModel.record.getListCashBookType() {
            let action = UIAlertAction(title: item.name,
                                       style: .default, handler: {
                                        action in
                                        self.handleCreateCashBook(id: item.id)
            })
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle create new cashbook with Type id
     * - parameter id: Type id of new cashbook
     */
    internal func handleCreateCashBook(id: String) {
        G09F01VC._typeId = id
        G09F01VC._mode      = DomainConst.NUMBER_ZERO_VALUE
        //++ BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
        G09F01VC._appOrderId = DomainConst.BLANK
        G09F01VC._id = DomainConst.BLANK
        //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
        self.pushToView(name:G09F01VC.theClassName)
    }
    
    /**
     * Handle start create store card
     */
    private func openUpdateCashBookScreen(data: CashBookBean) {
        EmployeeCashBookViewRequest.request(
            action: #selector(finishRequestCashBookView(_:)),
            view: self,
            id: data.id)
    }
    
    // MARK: Event handler
    /**
     * Finish request cashbook view
     */
    internal func finishRequestCashBookView(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = EmployeeCashBookViewRespModel(jsonString: data)
        if model.isSuccess() {
            G09F01VC._typeId    = model.record.master_lookup_id
            G09F01VC._mode      = DomainConst.NUMBER_ONE_VALUE
            G09F01VC._updateData        = model.record
            //++ BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
            G09F01VC._appOrderId = DomainConst.BLANK
            //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
            G09F01S01._selectedValue   = model.record.date_input.replacingOccurrences(
                of: DomainConst.SPLITER_TYPE3,
                with: DomainConst.SPLITER_TYPE1)
            
            G09F01S02._target   = CustomerBean(id: model.record.customer_id,
                                               name: model.record.customer_name,
                                               phone: model.record.customer_phone,
                                               address: model.record.customer_address)
            G09F01S03._selectedValue = model.record.amount
            G09F01S04._selectedValue = model.record.note
            self.pushToView(name: G09F01VC.theClassName)
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Create new event handler
     */
    internal func btnCreateTapped(_ sender: AnyObject) {
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheData(_:)),
                                     view: self)
        } else {
            // Open create cashbook view controller
            openCreateCashBookScreen()
        }
    }
    
    /**
     * Handle when finish request cache data
     */
    internal func finishRequestCacheData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            // Open create cashbook view controller
            openCreateCashBookScreen()
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle when finish request cache data for update cashbook
     */
    internal func finishRequestCacheDataForUpdate(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            if _tblView.indexPathForSelectedRow != nil {
                // Get selected row index
                let selectedRow = (_tblView.indexPathForSelectedRow?.row)!
                openUpdateCashBookScreen(data: _data.getRecord()[selectedRow])
            }
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        EmployeeCashBookListRequest.request(
            action:         action,
            view:           self,
            page:           String(_page),
            lookup_type:    String(_lookup_type),
            type:           G09F00S01VC._cashBookType,
            customer_id:    _customerId)
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
    
    /**
     * Handle change value of segment
     */
    internal func segmentChange(_ sender: AnyObject) {
        switch _segment.selectedSegmentIndex {
        case 0:
            _lookup_type = 1
        case 1:
            _lookup_type = 2
        default:
            break
        }
        resetData()
        requestData()
    }
    
    // MARK: Override methods
    /**
     * Handle finish request data
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = EmployeeCashBookListRespModel(jsonString: data)
        if model.isSuccess() {
            if G09F00S01VC._cashBookType == DomainConst.CASHBOOK_TYPE_LIST {
                // Update summary text
                if (_lblSummary.text?.isBlank)! {
                    _lblSummary.text = model.message
                }
            }
            
            // Update data
            _data.total_page = model.total_page
            _data.total_record = model.total_record
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
        if !BaseModel.shared.sharedString.isEmpty {
            G09F00S01VC._cashBookType = BaseModel.shared.sharedString
        }
        // Navigation
        if G09F00S01VC._cashBookType == DomainConst.CASHBOOK_TYPE_LIST {
            createNavigationBar(title: DomainConst.CONTENT00388)
        } else {
            createNavigationBar(title: DomainConst.CONTENT00400)
        }
        let height = self.getTopHeight()
        var offset: CGFloat = height
        _searchBar.delegate = self
        _searchBar.frame = CGRect(x: 0, y: offset,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.SEARCH_BOX_HEIGHT)
        _searchBar.placeholder = DomainConst.CONTENT00287
        _searchBar.layer.shadowColor = UIColor.black.cgColor
        _searchBar.layer.shadowOpacity = 0.5
        _searchBar.layer.masksToBounds = false
        _searchBar.showsCancelButton = true
        _searchBar.showsBookmarkButton = false
        _searchBar.searchBarStyle = .default
        self.view.addSubview(_searchBar)
        offset += _searchBar.frame.height
        
        if G09F00S01VC._cashBookType == DomainConst.CASHBOOK_TYPE_LIST {
            // Summary information label
            _lblSummary.frame = CGRect(x: 0, y: offset,
                                       width: GlobalConst.SCREEN_WIDTH,
                                       height: GlobalConst.LABEL_H * 2)
            _lblSummary.text = DomainConst.BLANK
            _lblSummary.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
            _lblSummary.textColor = GlobalConst.BUTTON_COLOR_RED
            _lblSummary.textAlignment = .center
            _lblSummary.lineBreakMode = .byWordWrapping
            _lblSummary.numberOfLines = 0
            self.view.addSubview(_lblSummary)
            offset = offset + _lblSummary.frame.height
            
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
        }
        
        // Table View
        _tblView.register(UINib(nibName: CashBookCell.theClassName,
                                bundle: nil),
                          forCellReuseIdentifier: CashBookCell.theClassName)
        _tblView.delegate = self
        _tblView.dataSource = self
        _tblView.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT - offset - GlobalConst.BUTTON_H - GlobalConst.MARGIN)
        _tblView.addSubview(refreshControl)
        self.view.addSubview(_tblView)
        
        // Gesture
        _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        // Show hide result of search bar action
        _tblSearchBar.isHidden = !_searchActive
        _tblSearchBar.frame = CGRect(x: 0, y: _searchBar.frame.maxY,
                                     width: GlobalConst.SCREEN_WIDTH,
                                     height: GlobalConst.CELL_IN_SEARCHBAR_TABLE_HEIGHT * 5)
        _tblSearchBar.delegate = self
        _tblSearchBar.dataSource = self
        self.view.addSubview(_tblSearchBar)
        
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
        // Request data from server
        requestData()
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishCacheData(_:)),
                                     view: self)
        }
        self.view.makeComponentsColor()
    }
    
    
    /**
     * Handle when finish request cache data
     */
    internal func finishCacheData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if !model.isSuccess() {
            showAlert(message: model.message)
        }
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
            // Cashbook table
            let cell: CashBookCell = tableView.dequeueReusableCell(
                withIdentifier: CashBookCell.theClassName)
                as! CashBookCell
            if _data.getRecord().count > indexPath.row {
                cell.setData(data: _data.getRecord()[indexPath.row])
            }
            
            return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == _tblSearchBar {
            return UITableViewAutomaticDimension
        }
        return CashBookCell.CELL_HEIGHT
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
            requestData()
        } else if tableView == _tblView {
//            if _data.getRecord()[indexPath.row].allow_update == DomainConst.NUMBER_ONE_VALUE {
//                // Check cache data is exist
//                if CacheDataRespModel.record.isEmpty() {
//                    // Request server cache data
//                    CacheDataRequest.request(action: #selector(finishRequestCacheDataForUpdate(_:)),
//                                             view: self)
//                } else {
//                    openUpdateCashBookScreen(data: _data.getRecord()[indexPath.row])
//                }
//            }
            G09F00S02VC._id = _data.getRecord()[indexPath.row].id
            self.pushToView(name: G09F00S02VC.theClassName)
        }
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
            CustomerListRequest.request(action: #selector(finishSearch(_:)),
                                        view: self,
                                        keyword: keyword)
        }
    }
    
    /**
     * Handle when finish search target
     */
    func finishSearch(_ notification: Notification) {
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
            requestData()
        } else {
            self.view.endEditing(true)
        }
    }
}
