//
//  G14F00S01VC.swift
//  project
//
//  Created by SPJ on 12/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G14F00S01VC: BaseParentViewController {
    // MARK: Properties
    /** Segment */
    var _segment:           UISegmentedControl      = UISegmentedControl(
        items: [
            DomainConst.CONTENT00545,
            DomainConst.CONTENT00546
        ]
    )
    /** Information table view */
    var _tblInfo:           UITableView             = UITableView()
    /** Current page */
    var _page:              Int                     = 0
    /** Date from */
    var _dateFrom:          String                  = CommonProcess.getPrevMonth()
    /** Date to */
    var _dateTo:            String                  = CommonProcess.getCurrentDate(withSpliter: DomainConst.SPLITER_TYPE1)
    /** Type */
    var _type:              Int                     = G14F00S01VC.TYPE_REMAIN
    /** Gas remain type */
    var _remainType:        Int                     = G14F00S01VC.REMAIN_TYPE_NORMAL
    /** Current data */
    var _data:              GasRemainListRespModel  = GasRemainListRespModel()
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** New button */
    var _btnNew:                UIButton            = UIButton()
    /** Search view */
    var _viewSearch:            UIView              = UIView()
    /** Search input view */
    var _viewInput:             UIView              = UIView()
    /** Date label */
    var _lblFromDate:           UILabel             = UILabel()
    /** Date textfield */
    var _txtFromDate:           UITextField         = UITextField()
    /** Date label */
    var _lblToDate:             UILabel             = UILabel()
    /** Date textfield */
    var _txtToDate:             UITextField         = UITextField()
    /** Search bar */
    var _searchBar:             UISearchBar         = UISearchBar()
    /** Search bar table view */
    var _tblSearchBar:          UITableView         = UITableView()
    /** Flag begin search */
    var _beginSearch:           Bool                = false
    /** Flag search active */
    var _searchActive:          Bool                = false
    /** Data */
    var _dataCustomer:          [ConfigBean]        = [ConfigBean]()
    /** Current customer Id */
    var _customerId:            String              = DomainConst.NUMBER_ZERO_VALUE
    /** Tap gesture hide keyboard */
    internal var _gestureHideKeyboard:   UIGestureRecognizer = UIGestureRecognizer()
    /** Edit row index path */
    var _editRowIndexPath:      IndexPath           = IndexPath()
    
    // MARK: Static values
    
    // MARK: Constant
    public static let TYPE_REMAIN:              Int = 2
    public static let TYPE_EXPORT:              Int = 1
    public static let REMAIN_TYPE_NORMAL:       Int = 1
    public static let REMAIN_TYPE_STORE_KEEPER: Int = 2
    
    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        self.createNavigationBar(title: DomainConst.CONTENT00547)
        createSegment()
        createInfoTableView()
        createNewButton()
        createSearchView()
        // Gesture
        _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        requestData()
        // Add Add button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.SEARCH_ICON_IMG_NAME,
                                       action: #selector(actionTapped(_:)),
                                       target: self)
        
        self.view.addSubview(_segment)
        self.view.addSubview(_tblInfo)
        self.view.addSubview(_btnNew)
        self.view.addSubview(_viewSearch)
    }
    
    /**
     * Set data
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = GasRemainListRespModel(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
            _tblInfo.reloadData()
        } else {
            showAlert(message: model.message)
        }
    }
    
    // MARK: Event handler    
    /**
     * Handle change value of segment
     */
    internal func segmentChange(_ sender: AnyObject) {
        switch _segment.selectedSegmentIndex {
        case 0:
            _type = G14F00S01VC.TYPE_REMAIN
            break
        case 1:
            _type = G14F00S01VC.TYPE_EXPORT
            break
        default:
            break
        }               
        resetData()
        requestData()
    }
    
    /**
     * Handle when tap on new button
     */
    internal func btnNewTapped(_ sender: AnyObject) {
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheData(_:)),
                                     view: self)
        } else {
            // Open create gas remain view controller
            openCreateGasRemainScreen()
        }
//        showAlert(message: DomainConst.CONTENT00362)
    }
    
    /**
     * Handle when change value in From date picker
     * - parameter sender: From date picker
     */
    internal func datePickerChangedFrom(sender: UIDatePicker) {
        _txtFromDate.text = CommonProcess.getDateString(date: sender.date)
    }
    
    /**
     * Handle when change value in To date picker
     * - parameter sender: To date picker
     */
    internal func datePickerChangedTo(sender: UIDatePicker) {
        _txtToDate.text = CommonProcess.getDateString(date: sender.date)
    }
    
    /**
     * Handle tap on Search button
     * - parameter sender: AnyObject
     */
    internal func actionTapped(_ sender: AnyObject) {
//        // Show alert
//        let alert = UIAlertController(title: DomainConst.CONTENT00436,
//                                      message: DomainConst.CONTENT00437,
//                                      preferredStyle: .actionSheet)
//        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
//                                   style: .cancel,
//                                   handler: nil)
//        alert.addAction(cancel)
//        let create = UIAlertAction(title: DomainConst.CONTENT00548,
//                                   style: .default, handler: {
//                                    action in
//        })
//        let search = UIAlertAction(title: DomainConst.CONTENT00287,
//                                   style: .default, handler: {
//                                    action in
//        })
//        alert.addAction(create)
//        alert.addAction(search)
//        if let presenter = alert.popoverPresentationController {
//            presenter.sourceView = sender as? UIButton
//            presenter.sourceRect = sender.bounds
//        }
//        self.present(alert, animated: true, completion: nil)
        if _viewSearch.isHidden {
            _viewSearch.isHidden = false
            _txtFromDate.becomeFirstResponder()
        } else {
            _viewSearch.isHidden = true
            _txtFromDate.resignFirstResponder()
            _txtToDate.resignFirstResponder()
        }
    }
    
    /**
     * Handle when tap button Search
     */
    internal func btnSearchTapped(_ sender: AnyObject) {
        self._dateFrom  = self._txtFromDate.text!
        self._dateTo    = self._txtToDate.text!
        self._page      = 0
        requestData(action: #selector(finishSearch(_:)))
    }
    
    /**
     * Handle when finish request cache data
     */
    internal func finishRequestCacheData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            // Open create gas remain view controller
            openCreateGasRemainScreen()
        } else {
            showAlert(message: model.message)
        }
    }
    
    internal func finishRequestSetExport(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            requestData(action: #selector(finishEditData(_:)))
        } else {
            showAlert(message: model.message)
        }
    }
    
    internal func finishEditData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = GasRemainListRespModel(jsonString: data)
        if model.isSuccess() {
//            _data.total_page = model.total_page
//            _data.total_record = model.total_record
//            _data.append(contentOf: model.getRecord())
            _data.record[_editRowIndexPath.row] = model.getRecord()[_editRowIndexPath.row]
            _tblInfo.reloadRows(at: [_editRowIndexPath], with: .fade)
//            if let visibleIndexPaths = _tblInfo.indexPathsForVisibleRows?.index(of: _editRowIndexPath) {
//                if visibleIndexPaths != NSNotFound {
//                    _tblInfo.reloadRows(at: [_editRowIndexPath], with: .fade)
//                }
//            }
        } else {
            showAlert(message: model.message)
        }
    }
    
    // MARK: Logic
    /**
     * Request data
     */
    internal func requestData(action: Selector = #selector(setData(_:))) {
        GasRemainListRequest.request(
            action: action,
            view: self,
            date_from: _dateFrom,
            date_to: _dateTo,
            type: String(_type),
            page: String(_page),
            gas_remain_type: _remainType,
            customer_id: _customerId)
    }
    
    /**
     * Reset data
     */
    private func resetData() {
        _data.clearData()
        // Reset current search value
        self._page      = 0
        // Reload table
        _tblInfo.reloadData()
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
            _tblSearchBar.layer.zPosition = 1
        } else {
            showAlert(message: model.message)
        }
    }
    
    internal func finishSearch(_ notification: Notification) {
        _data.clearData()
        hideKeyboard()
        _viewSearch.isHidden = true
        _txtFromDate.resignFirstResponder()
        _txtToDate.resignFirstResponder()
        setData(notification)
    }
    
    internal func openCreateGasRemainScreen() {
        let view = G14F01VC(nibName: G14F01VC.theClassName, bundle: nil)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    internal func requestFinish(id: String) {
        GasRemainSetExportRequest.request(
            action: #selector(finishRequestSetExport(_:)),
            view: self,
            id: id)
    }
    
    // MARK: Layout
    // MARK: Segment
    private func createSegment() {
        let font = UIFont.systemFont(ofSize: GlobalConst.BASE_FONT_SIZE)
        _segment.frame = CGRect(x: 0, y: getTopHeight(),
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.BUTTON_H)
        _segment.setTitleTextAttributes([NSFontAttributeName: font],
                                        for: UIControlState())
        _segment.selectedSegmentIndex = 0
        _segment.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        _segment.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        _segment.tintColor = GlobalConst.BUTTON_COLOR_RED
        _segment.addTarget(self, action: #selector(segmentChange(_:)), for: .valueChanged)
    }
    
    // MARK: Information table view
    private func createInfoTableView() {
        _tblInfo.frame = CGRect(
            x: 0, y: _segment.frame.maxY,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height - _segment.frame.maxY - GlobalConst.BUTTON_H - GlobalConst.MARGIN)
        _tblInfo.dataSource = self
        _tblInfo.delegate = self
        _tblInfo.addSubview(refreshControl)
        _tblInfo.register(UINib(nibName: G14F00S01Cell.theClassName, bundle: nil),
                         forCellReuseIdentifier: G14F00S01Cell.theClassName)
    }
    
    // MARK: Create button
    private func createNewButton() {
        CommonProcess.createButtonLayout(btn: _btnNew,
                                         x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                         y:  GlobalConst.SCREEN_HEIGHT - GlobalConst.BUTTON_H - GlobalConst.MARGIN,
                                         text: DomainConst.CONTENT00548.uppercased(),
                                         action: #selector(btnNewTapped(_:)),
                                         target: self,
                                         img: DomainConst.ADD_ICON_IMG_NAME,
                                         tintedColor: UIColor.white)
        _btnNew.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                         left: GlobalConst.MARGIN,
                                                         bottom: GlobalConst.MARGIN,
                                                         right: GlobalConst.MARGIN)
    }
    
    // MARK: Search view
    private func createSearchView() {
        // Search view
        _viewSearch.frame = CGRect(x: 0, y: self.getTopHeight(),
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: GlobalConst.SCREEN_HEIGHT - self.getTopHeight())
        _viewSearch.isHidden = true
        _viewSearch.backgroundColor = UIColor(white: 0, alpha: 0.5)
        // Input view
        _viewInput.frame = CGRect(x: GlobalConst.MARGIN,
                                  y: GlobalConst.MARGIN,
                                  width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN,
                                  height: GlobalConst.LABEL_H * 2 + GlobalConst.EDITTEXT_H * 2 + GlobalConst.BUTTON_H * 2 + GlobalConst.MARGIN * 2)
        _viewInput.backgroundColor = UIColor.white
        _viewInput.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        _viewSearch.addSubview(_viewInput)
        // From label
        let leftMargin = GlobalConst.MARGIN
        var offset = GlobalConst.MARGIN
        _lblFromDate.frame = CGRect(x: leftMargin, y: offset,
                                    width: _viewInput.frame.width - leftMargin,
                                    height: GlobalConst.LABEL_H)
        _lblFromDate.text = DomainConst.CONTENT00282
        _lblFromDate.textColor = UIColor.black
        _lblFromDate.textAlignment = .left
        _lblFromDate.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _viewInput.addSubview(_lblFromDate)
        offset += GlobalConst.LABEL_H
        // From textfield
        _txtFromDate.frame = CGRect(x: leftMargin, y: offset,
                                    width: _viewInput.frame.width - leftMargin,
                                    height: GlobalConst.EDITTEXT_H)
        _txtFromDate.text = self._dateFrom
        _txtFromDate.textColor = UIColor.black
        _txtFromDate.textAlignment = .left
        _txtFromDate.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _txtFromDate.delegate = self
        setLeftImgTextField(textField: _txtFromDate, name: DomainConst.DATETIME_ICON_IMG_NAME)
        _viewInput.addSubview(_txtFromDate)
        offset += GlobalConst.EDITTEXT_H
        
        // To label
        _lblToDate.frame = CGRect(x: leftMargin, y: offset,
                                  width: _viewInput.frame.width - leftMargin,
                                  height: GlobalConst.LABEL_H)
        _lblToDate.text = DomainConst.CONTENT00283
        _lblToDate.textColor = UIColor.black
        _lblToDate.textAlignment = .left
        _lblToDate.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _viewInput.addSubview(_lblToDate)
        offset += GlobalConst.LABEL_H
        // To textfield
        _txtToDate.frame = CGRect(x: leftMargin, y: offset,
                                  width: _viewInput.frame.width - leftMargin,
                                  height: GlobalConst.EDITTEXT_H)
        _txtToDate.text = self._dateTo
        _txtToDate.textColor = UIColor.black
        _txtToDate.textAlignment = .left
        _txtToDate.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _txtToDate.delegate = self
        setLeftImgTextField(textField: _txtToDate, name: DomainConst.DATETIME_ICON_IMG_NAME)
        _viewInput.addSubview(_txtToDate)
        offset += GlobalConst.EDITTEXT_H
        
        // Search bar
        _searchBar.placeholder = DomainConst.CONTENT00060
        _searchBar.frame = CGRect(x: 0,
                                 y: offset,
                                 width: _viewInput.frame.width,
                                 height: GlobalConst.SEARCH_BOX_HEIGHT )
        _searchBar.delegate = self
        self._viewInput.addSubview(_searchBar)
        offset += GlobalConst.SEARCH_BOX_HEIGHT + GlobalConst.MARGIN
        
        // Show hide result of search bar action
        _tblSearchBar.isHidden = !_searchActive
        _tblSearchBar.frame = CGRect(x: 0, y: _searchBar.frame.maxY,
                                     width: _viewInput.frame.width,
                                     height: GlobalConst.CELL_IN_SEARCHBAR_TABLE_HEIGHT * 5)
        _tblSearchBar.delegate = self
        _tblSearchBar.dataSource = self
        
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
        self._viewInput.addSubview(_tblSearchBar)
    }
    
    /**
     * Set left image for textfield
     * - parameter textField: Current textField
     * - parameter name: Image name
     */
    private func setLeftImgTextField(textField: UITextField, name: String) {
        textField.leftViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0,
                                                width: GlobalConst.EDITTEXT_H - GlobalConst.MARGIN,
                                                height: GlobalConst.EDITTEXT_H - GlobalConst.MARGIN))
        let img = ImageManager.getImage(named: name)
        let tinted = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imgView.image = tinted
        imgView.tintColor = UIColor.black
        textField.leftView = imgView
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        // Hide keyboard
        self.view.endEditing(true)
        // Remove hide keyboard gesture
        self.view.removeGestureRecognizer(_gestureHideKeyboard)
    }
    
    /**
     * Tells the responder when one or more fingers touch down in a view or window.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    /**
     * Mark textfield is selected
     * - parameter textField: Current focus textfield
     */
    internal func markSelected(textField: UITextField) {
        let normalColor     = UIColor.black
        let selectedColor   = GlobalConst.BUTTON_COLOR_RED
        var fromColor       = normalColor
        var toColor         = selectedColor
        // Current is from textfield
        if textField == self._txtFromDate {
            fromColor = selectedColor
            toColor = normalColor
        }
        self._lblFromDate.textColor = fromColor
        self._txtFromDate.textColor = fromColor
        self._txtFromDate.leftView?.tintColor = fromColor
        self._lblToDate.textColor = toColor
        self._txtToDate.textColor = toColor
        self._txtToDate.leftView?.tintColor = toColor
    }
}

// MARK: Protocol - UITableViewDataSource
extension G14F00S01VC: UITableViewDataSource {
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
        if tableView == _tblSearchBar {
            return _dataCustomer.count
        }
        return self._data.record.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == _tblSearchBar {     // Search result table
            let cell = UITableViewCell()
            cell.textLabel?.text = _dataCustomer[indexPath.row].name
            return cell
        }
        if indexPath.row > self._data.record.count {
            return UITableViewCell()
        }
        let data = self._data.record[indexPath.row]
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(
            withIdentifier: G14F00S01Cell.theClassName,
            for: indexPath)
        cell.preservesSuperviewLayoutMargins = true
        cell.contentView.preservesSuperviewLayoutMargins = true
        (cell as! G14F00S01Cell).setData(data: data)
        
        return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == _tblSearchBar {
            return UITableViewAutomaticDimension
        }
        return GlobalConst.LABEL_H * 5
    }
}

// MARK: Protocol - UITableViewDelegate
extension G14F00S01VC: UITableViewDelegate {
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
//            clearData()
            // Update customer id
            _customerId = _dataCustomer[indexPath.row].id
            // Request data from server
//            requestData()
        } else if tableView == _tblInfo {
            let view = G14F00S02VC(nibName: G14F00S02VC.theClassName,
                                   bundle: nil)
            view.setId(id: _data.record[indexPath.row].id)
            self.navigationController?.pushViewController(view, animated: true)
        }
//        let g12f00s02 = G12F00S02VC(nibName: G12F00S02VC.theClassName,
//                                    bundle: nil)
//        g12f00s02.setId(id: self._data.getRecord()[indexPath.row].id)
//        self.navigationController?.pushViewController(
//            g12f00s02,
//            animated: true)
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
                self._page += 1
                // Page less than total page
                if self._page <= _data.total_page {
                    self.requestData()
                }
            }
        }
    }
    
    /**
     * Asks the data source to verify that the given row is editable.
     */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if _data.record[indexPath.row].allow_swipe == 1 {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        _editRowIndexPath = indexPath
        let finish = UITableViewRowAction(style: .default,
                                        title: "Chuyển trạng thái",
                                        handler: {
                                            action, indexPath in
                                            self.requestFinish(id: self._data.record[indexPath.row].id)
        })
        finish.backgroundColor = UIColor.orange
        
        return [finish]
    }
}

// MARK: Protocol - UITextFieldDelegate
extension G14F00S01VC: UITextFieldDelegate {    
    /**
     * Handle start editing
     * - parameter textField: Current focus textfield
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self._txtFromDate {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.setDate(CommonProcess.getDateByString(str: self._txtFromDate.text!),
                               animated: true)
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(datePickerChangedFrom(sender:)), for: .valueChanged)
        } else if textField == self._txtToDate {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            textField.inputView = datePicker
            datePicker.setDate(CommonProcess.getDateByString(str: self._txtToDate.text!),
                               animated: true)
            datePicker.addTarget(self, action: #selector(datePickerChangedTo(sender:)), for: .valueChanged)
        }
        markSelected(textField: textField)
    }
    
    /**
     * Handle finish edit textfield
     * - parameter textField: Current focus textfield
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Protocol - UITextFieldDelegate
extension G14F00S01VC: UISearchBarDelegate {
    /**
     * Tells the delegate that the user changed the search text.
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredStr = searchText
        if filteredStr.characters.count > (DomainConst.SEARCH_TARGET_MIN_LENGTH - 1) {
            _beginSearch = false
            _searchActive = true            
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
     * Tells the delegate when the user begins editing the search text.
     */
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        _searchActive = true
        self.view.addGestureRecognizer(_gestureHideKeyboard)
    }
    
    /**
     * Tells the delegate that the user finished editing the search text.
     */
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        _searchActive = true
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
    
    /**
     * Tells the delegate that the cancel button was tapped.
     */
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
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
}
