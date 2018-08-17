//
//  G17F00S01VC.swift
//  project
//
//  Created by SPJ on 7/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework   
import Alamofire

class G17F00S01VC: BaseParentViewController,UITextFieldDelegate,UISearchBarDelegate {
    /** Search bar */
    @IBOutlet weak var _searchbar:      UISearchBar!
    /** Table Search  */
    @IBOutlet weak var tblSearch:       UITableView!
    /** Flag search active */
    internal var _searchActive:         Bool                = false
    /** Flag check keyboard is show or hide */
    private var _isKeyboardShow:        Bool                = false
    /** Tap gesture hide keyboard */
    private var _gestureHideKeyboard:   UIGestureRecognizer = UIGestureRecognizer()
    /** Flag begin search */
    private var _beginSearch:           Bool                = false
    /** Data */
    internal var _dataCustomer:         [CustomerBean]      = [CustomerBean]()
    /** tbl customer request */
    @IBOutlet weak var tblList:         UITableView!
    /** Search view */
    private var _viewSearch:            UIView              = UIView()
    /** Search input view */
    private var _viewInput:             UIView              = UIView()
    /** Date label */
    private var _lblFromDate:           UILabel             = UILabel()
    /** Date textfield */
    private var _txtFromDate:           UITextField         = UITextField()
    /** Date label */
    private var _lblToDate:             UILabel             = UILabel()
    /** Date textfield */
    private var _txtToDate:             UITextField         = UITextField()
    /** From date value */
    private var _fromDate:              String              = CommonProcess.getFirstDateOfMonth(date: Date())
    /** To date value */
    private var _toDate:                String              = CommonProcess.getCurrentDate()
    /** Customer id value */
    internal var _customerId:           String              = DomainConst.BLANK
    /** Refrest control */
    lazy var refreshControl:            UIRefreshControl    = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Data */
    internal var _data:                 CustomerRequestListResponseModel    = CustomerRequestListResponseModel()
    /** Page number */
    internal var _page:                 Int                                 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        self.createNavigationBar(title: DomainConst.CONTENT00583)
        // Add search button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.SEARCH_ICON_IMG_NAME,
                                       action: #selector(searchButtonTapped(_:)), target: self)
        // table list customer request
        tblList.estimatedRowHeight = CGFloat(G17Const.ESTIMATE_ROW_HEIGHT)
        tblList.rowHeight = UITableViewAutomaticDimension
        tblList.dataSource = self
        tblList.delegate = self
        tblList.addSubview(refreshControl)
        // Search bar        
        _searchbar.delegate = self
        _searchbar.layer.shadowColor    = UIColor.black.cgColor
        _searchbar.layer.shadowOpacity  = 0.5
        _searchbar.layer.masksToBounds  = false
        _searchbar.showsCancelButton    = true
        _searchbar.showsBookmarkButton  = false
        _searchbar.searchBarStyle       = .default
        // Gesture
        _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Table Search Bar
        tblSearch.delegate = self
        tblSearch.dataSource = self
        tblSearch.isHidden = true
        //requestData()
        requestDataForSearch()
        // Button create customer
        let btnCreateCustomer = UIButton()
        CommonProcess.createButtonLayout(btn: btnCreateCustomer,
                                         x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                         y:  GlobalConst.SCREEN_HEIGHT - GlobalConst.BUTTON_H - GlobalConst.MARGIN,
                                         text: DomainConst.CONTENT00584.uppercased(),
                                         action: #selector(self.createCustomerRequest(_:)),
                                         target: self,
                                         img: DomainConst.ADD_ICON_IMG_NAME,
                                         tintedColor: UIColor.white)
        btnCreateCustomer.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                         left: GlobalConst.MARGIN,
                                                         bottom: GlobalConst.MARGIN,
                                                         right: GlobalConst.MARGIN)
        self.view.addSubview(btnCreateCustomer)
        // Search view
        setupSearchView()
    }

    // Handle Search Customer
    
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
        
        if _searchbar.text != nil {
            // Get keyword
            let keyword = _searchbar.text!.removeSign().lowercased()
            _searchbar.isUserInteractionEnabled = false
            CustomerListRequest.request(action: #selector(finishSearchCustomer(_:)),
                                        view: self,
                                        keyword: keyword,
                                        type: G17F00S02VC._type)
        }
    }
    
    /**
     * Handle when finish search target
     */
    func finishSearchCustomer(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CustomerListRespModel(jsonString: data)
        if model.isSuccess() {
            _dataCustomer = model.getRecord()
            // Load data for search bar table view
            tblSearch.reloadData()
            // Show
            tblSearch.isHidden = !_searchActive
            // Move to front
            self.view.bringSubview(toFront: tblSearch)
            tblSearch.layer.zPosition = 1
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
        _searchbar.isUserInteractionEnabled = true
    }
    
    /**
     * Tells the delegate that the user changed the search text.
     */
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredStr = searchText
        if filteredStr.count > (DomainConst.SEARCH_TARGET_MIN_LENGTH - 1) {
            _beginSearch = false
            _searchActive = true
        } else {
            _beginSearch = false
            _searchActive = false
            // Hide search bar table view
            tblSearch.isHidden = !_searchActive
        }
    }
    /**
     * Tells the delegate that the cancel button was tapped.
     */
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        _searchActive = false
        // Clear textbox
        if _searchbar.text != nil {
            _searchbar.text = DomainConst.BLANK
        }
        tblSearch.isHidden = !_searchActive
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
        if (_searchbar.text?.isEmpty)! {
        } else {
            self.view.endEditing(true)
        }
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
        // Input view
        _viewInput.frame = CGRect(x: GlobalConst.MARGIN,
                                  y: GlobalConst.MARGIN,
                                  width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN,
                                  height: GlobalConst.LABEL_H * 2 + GlobalConst.EDITTEXT_H * 2 + GlobalConst.BUTTON_H + GlobalConst.MARGIN)
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
        _txtFromDate.text = CommonProcess.getCurrentDate()
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
        _txtToDate.text = CommonProcess.getCurrentDate()
        _txtToDate.textColor = UIColor.black
        _txtToDate.textAlignment = .left
        _txtToDate.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _txtToDate.delegate = self
        setLeftImgTextField(textField: _txtToDate, name: DomainConst.DATETIME_ICON_IMG_NAME)
        _viewInput.addSubview(_txtToDate)
        offset += GlobalConst.EDITTEXT_H
        
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
     * Handle when tap button Search
     */
    internal func btnSearchTapped(_ sender: AnyObject) {
        self._fromDate  = self._txtFromDate.text!
        self._toDate    = self._txtToDate.text!
        self._page      = 0
        _data.clearData()
        requestDataForSearch()
        hideKeyboard()
        //requestDataForSearch()
        _viewSearch.isHidden = true
    }
    
    internal func finishSearch(_ notification: Notification) {
        _data.clearData()
        hideKeyboard()
        _viewSearch.isHidden = true
        _txtFromDate.resignFirstResponder()
        _txtToDate.resignFirstResponder()
        //setData(notification)
    }
    
    
    // MARK: Methods
    
    /**
     * Handle tap on Search button
     * - parameter sender: AnyObject
     */
    internal func searchButtonTapped(_ sender: AnyObject) {
        if _viewSearch.isHidden {
            _viewSearch.isHidden = false
            _txtFromDate.becomeFirstResponder()
        } else {
            _viewSearch.isHidden = true
            _txtFromDate.resignFirstResponder()
            _txtToDate.resignFirstResponder()
        }
    }
    
    internal func createCustomerRequest(_ sender: AnyObject) {
        pushToView(name: G17F00S03VC.theClassName)
    }
    
    private func requestDataForSearch(completionHandler: ((Any?)->Void)?) {
        CustomerRequestListRequest.request(view: self, page: String(_page), dateFrom: _fromDate, dateTo: _toDate, customerId: _customerId, completionHandler: completionHandler)
        tblList.reloadData()
    }
    /**
     * Request data for search
     */
    internal func requestDataForSearch() {
        requestDataForSearch(completionHandler: finishRequest)
    }
    
    internal func requestData(completionHandler: ((Any?)->Void)?) {
        CustomerRequestListRequest.request(view: self, page: String(_page),
                                           completionHandler: completionHandler)
    }
    /**
     * Request data from server
     */
    internal func requestData() {
        requestData(completionHandler: finishRequest)
    }
    
    
    public override func finishRequest(_ model: Any?) {
        let data = model as! String
        let model = CustomerRequestListResponseModel(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
            tblList.reloadData()
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    
    
    /**
     * Reset data
     */
    private func resetData() {
        _data.clearData()
        // Reset current search value
        self._page              = 0
        _customerId             = ""
        self._fromDate          = CommonProcess.getFirstDateOfMonth(date: Date())
        self._toDate            = CommonProcess.getCurrentDate()
        self._txtFromDate.text  = CommonProcess.getFirstDateOfMonth(date: Date())
        self._txtToDate.text    = CommonProcess.getCurrentDate()
        // Reload table
        tblList.reloadData()
        
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        self.resetData()
        requestDataForSearch(completionHandler: finishHandleRefresh(_:))
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Logic
    /**
     * Handle tap on add button
     * - parameter sender: AnyObject
     */
    internal func actionTapped(_ sender: AnyObject) {
        BaseViewController.getCurrentViewController()?.pushToViewAndClearData(name: "G17F00S03VC")
    }
    
    // MARK: Logic
    internal func openDetail(id: String) {
        BaseModel.shared.sharedString = id
        self.pushToView(name: G17F00S02VC.theClassName)
        
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
            datePicker.setDate(CommonProcess.getDateByString(str: self._txtToDate.text!),
                               animated: true)
            textField.inputView = datePicker
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
    private func markSelected(textField: UITextField) {
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
    extension G17F00S01VC: UITableViewDataSource{
        /**
         * Tells the data source to return the number of rows in a given section of a table view.
         */
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            if tableView == tblSearch {
                return _dataCustomer.count
            }
            else  if tableView == tblList {
                return self._data.getRecord().count
            }
            return 0
        }
        
        /**
         * Asks the data source for a cell to insert in a particular location of the table view.
         */
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
            UITableViewCell {
                var cell = UITableViewCell()
                if tableView == tblSearch {
                    if _dataCustomer.count > indexPath.row {
                        cell.textLabel?.text = _dataCustomer[indexPath.row].name
                    }
                    
                }
                else  if tableView == tblList {
                    let cell2: CustomerRequestCell = tableView.dequeueReusableCell(
                        withIdentifier: "CustomerRequestCell")
                        as! CustomerRequestCell
                    //ell?.textLabel?.text           = _data.getRecord()[indexPath.row].code_no
                    //cell.lblName.text = "Khoi"
                    cell2.lblCode.text = self._data.getRecord()[indexPath.row].code_no
                    cell2.lblName.text = self._data.getRecord()[indexPath.row].first_name
                    cell2.lblDate.text = "🗓\(self._data.getRecord()[indexPath.row].created_date)"
                    cell2.lblAddress.text = "🏚\(self._data.getRecord()[indexPath.row].address)"
                    if _data.getRecord()[indexPath.row].note != ""{
                        cell2.lblNote.text = "📔\(self._data.getRecord()[indexPath.row].note)"
                    }
                    switch self._data.getRecord()[indexPath.row].status{
                    case "1" :
                        cell2.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_NEW_ICON_IMG_NAME)
                        break
                    case "2" :
                        cell2.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_PROCESS_ICON_IMG_NAME)
                        break
                    case "3" : 
                        cell2.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_APPROVE_ICON_IMG_NAME)
                        break
                    case "4" :
                        cell2.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_CANCEL_ICON_IMG_NAME)
                        break
                    default :
                        cell2.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_NEW_ICON_IMG_NAME)
                        break
                    }
                    cell = cell2
                }
                return cell
        }
    }
    // MARK: - UITableViewDataSource-Delegate
extension G17F00S01VC: UITableViewDelegate {    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    /**
     * Tells the delegate the table view is about to draw a cell for a particular row.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Total page does not 1
        if tableView == tblList {
            if _data.total_page != 1 {
                let lastElement = _data.getRecord().count - 1
                // Current is the last element
                if indexPath.row == lastElement {
                    self._page += 1
                    // Page less than total page
                    if self._page <= _data.total_page {
                        requestDataForSearch()
                        //requestDataForSearch(completionHandler: finishRequest)
                    }
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblSearch {
            _searchActive = false
            tblSearch.isHidden = !_searchActive
            _searchbar.resignFirstResponder()
            _customerId = _dataCustomer[indexPath.row].id
            _searchbar.text = _dataCustomer[indexPath.row].name
            _data.clearData()
            requestDataForSearch()
            
        }else if tableView == tblList{
            if self._data.getRecord().count > indexPath.row {
                self.openDetail(id: self._data.getRecord()[indexPath.row].id)
            }
        }
    }
}
    
    
    
    


    
   
     
     
     
     
     

