//
//  G18F00S01VC.swift
//  project
//
//  Created by SPJ on 7/25/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework  
import Alamofire

class G18F00S01VC: BaseParentViewController,UISearchBarDelegate, UITextFieldDelegate,UIPickerViewDelegate {
    /** view */
    @IBOutlet var viewLayout: UIView!
    /** Tab New */
    @IBOutlet weak var btnTabNew: UIButton!
    /** Tab Exported */
    @IBOutlet weak var btnExported: UIButton!
    /** Click Tab New */
    @IBAction func btn_New(_ sender: Any) {
        btnTabNew.setTitleColor(UIColor.white, for: .normal)
        btnTabNew.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnExported.setTitleColor(UIColor.red, for: .normal)
        btnExported.backgroundColor = UIColor.white
        _type = "1"
        //_data.clearData()
        resetData()
        requestData()
    }
    /** Click Tab exported */
    @IBAction func btn_Exported(_ sender: Any) {
        btnExported.setTitleColor(UIColor.white, for: .normal)
        btnExported.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnTabNew.setTitleColor(UIColor.red, for: .normal)
        btnTabNew.backgroundColor = UIColor.white
        //_data.clearData()
        resetData()
        _type = "2"
        requestData()
    }
    
    @IBOutlet weak var tblStockKeeper: UITableView!
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Page number */
    internal var _page:              Int                     = 0
    /** Data */
    internal var _data:              StockListResponseModel  = StockListResponseModel()
    /** type */
    internal var _type : String = "1"
    // ++search view
    /** search view */
    @IBOutlet weak var _searchView: UIView!
    /** textfield Fromdate*/
    @IBOutlet weak var _txtFromDate: UITextField!
    /** textfield Todate */
    @IBOutlet weak var _txtToDate: UITextField!
    /** Search Bar */
    @IBOutlet weak var _searchBar: UISearchBar!
    /** PickerView Driver */
    @IBOutlet weak var _pkvDriver: UIPickerView!
    /** PickerView Car */
    @IBOutlet weak var _pkvCar: UIPickerView!
    /** Button Search */
    @IBOutlet weak var _btnSearchCustomer: UIButton!
    /** Button Reset */
    @IBOutlet weak var _btnReset: UIButton!
    /** Table Search Customer */
    @IBOutlet weak var _tblSearch: UITableView!
    /** Flag check keyboard is show or hide */
    private var _isKeyboardShow:        Bool                = false
    /** Tap gesture hide keyboard */
    private var _gestureHideKeyboard:   UIGestureRecognizer = UIGestureRecognizer()
    /** Flag search active */
    internal var _searchActive:         Bool                = false
    /** Flag begin search */
    private var _beginSearch:           Bool                = false
    /** Data Customer*/
    internal var _dataCustomer:         [CustomerBean]      = [CustomerBean]()
    /** Gasremain Car id value */
    internal var _carId:                String = DomainConst.BLANK
    /** Gasremain Driver id  value */
    internal var _driverId:             String = DomainConst.BLANK
    /** Customer id value */
    internal var _customerId:           String = DomainConst.BLANK
    /** From date value */
    private var _fromDate:              String = CommonProcess.getCurrentDate()
    /** To date value */
    private var _toDate:                String = CommonProcess.getCurrentDate()
    private var _dataDriver :           [ConfigBean] = [ConfigBean]()
    private var _dataCar :              [ConfigBean] = [ConfigBean]()
    
    @IBAction func resetSearchInfo(_ sender: Any) {
        _txtFromDate.text = CommonProcess.getCurrentDate()
        _txtToDate.text   = CommonProcess.getCurrentDate()
        _searchBar.text   = DomainConst.BLANK
        _pkvDriver.selectRow(0, inComponent: 0, animated: true)
        _pkvCar.selectRow(0, inComponent: 0, animated: true)
        _customerId       = DomainConst.BLANK
        _fromDate         = CommonProcess.getCurrentDate()
        _toDate           = CommonProcess.getCurrentDate()
        _driverId         = DomainConst.BLANK
        _carId            = DomainConst.BLANK
        
    }
    // --search view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        //Title for list view
        self.createNavigationBar(title: DomainConst.CONTENT00586)
        // Add Search button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.SEARCH_ICON_IMG_NAME,
                                       action: #selector(searchButtonTapped(_:)), target: self)
        //Custom tab
        btnTabNew.layer.borderColor = UIColor.red.cgColor
        btnTabNew.layer.borderWidth = CGFloat(G18Const.BORDER_WIDTH)
        btnExported.layer.borderColor = UIColor.red.cgColor
        btnExported.layer.borderWidth = CGFloat(G18Const.BORDER_WIDTH)
        //Add delegate for table
        tblStockKeeper.delegate = self
        tblStockKeeper.dataSource = self
        tblStockKeeper.estimatedRowHeight = 400
        tblStockKeeper.rowHeight = UITableViewAutomaticDimension
        tblStockKeeper.addSubview(refreshControl)
        //++For Search View
            // Search bar        
            _searchBar.delegate = self
            _searchBar.placeholder          = DomainConst.CONTENT00287
            _searchBar.layer.shadowColor    = UIColor.black.cgColor
            _searchBar.layer.shadowOpacity  = 0.5
            _searchBar.layer.masksToBounds  = false
            _searchBar.showsCancelButton    = true
            _searchBar.showsBookmarkButton  = false
            _searchBar.searchBarStyle       = .default
            // Gesture
            _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            // Table Search Bar
            _tblSearch.delegate = self
            _tblSearch.dataSource = self
            _tblSearch.isHidden = true
            // From TextField
            _txtFromDate.text = self._fromDate
            _txtFromDate.textColor = UIColor.black
            _txtFromDate.textAlignment = .left
            _txtFromDate.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
            _txtFromDate.delegate = self
            // To TextField
            _txtToDate.text = self._toDate
            _txtToDate.textColor = UIColor.black
            _txtToDate.textAlignment = .left
            _txtToDate.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
            _txtToDate.delegate = self
            // Search Button
            _btnSearchCustomer.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
             _btnSearchCustomer.addTarget(self, action: #selector(btnSearchTapped(_:)), for: .touchUpInside)
            // Search Button
            _btnReset.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
            // Picker view
            _pkvDriver.delegate = self
            _pkvCar.delegate    = self
            // Data for Picker View driver
            _dataDriver.append(ConfigBean(id: "", name: G18Const.DEFAULT_VALUE_DRIVER))
            BaseModel.shared.gas_remain_driver.forEach { (driver) in
            _dataDriver.append(driver)
            }
            // Data for Picker View car
            _dataCar.append(ConfigBean(id: "", name: G18Const.DEFAULT_VALUE_CAR))
            BaseModel.shared.gas_remain_car.forEach { (car) in
            _dataCar.append(car)
        }
        //request data
        requestData()
    }
    
    // MARK: - Picker View Delegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView)->Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int {
        if pickerView == _pkvDriver{
            return _dataDriver.count
        }
        else if pickerView == _pkvCar{
            return _dataCar.count
        }
        return 0
    }
    // goes in lieu of titleForRow if customization is desired
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        if pickerView == _pkvDriver{
            pickerLabel.textColor = .darkGray
            pickerLabel.textAlignment = .center
            pickerLabel.text = String(_dataDriver[row].name)
            pickerLabel.font = UIFont(name:"Helvetica", size: 17)
        }
        else if pickerView == _pkvCar{
            pickerLabel.textColor = .darkGray
            pickerLabel.textAlignment = .center
            pickerLabel.text = String(_dataCar[row].name)
            pickerLabel.font = UIFont(name:"Helvetica", size: 17)
        }
        return pickerLabel
    }
    /*func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == _pkvDriver{
            pickerLabel.text = String(self.degrees[row])
            pickerLabel.font = UIFont(name:"Helvetica", size: 28)
            return _dataDriver[row].name
        }
        else if pickerView == _pkvCar{
            return _dataCar[row].name
        }
        return ""
    }*/
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == _pkvDriver{
            _driverId = _dataDriver[row].id
        }
        else if pickerView == _pkvCar{
            _carId = _dataCar[row].id
        }
    }
    

    /**
     * Handle when tap button Search
     */
    internal func btnSearchTapped(_ sender: AnyObject) {
        self._fromDate  = self._txtFromDate.text!
        self._toDate    = self._txtToDate.text!
        _data.clearData()
        requestData()
        hideKeyboard()
        _searchView.isHidden = true
        _searchBar.text = ""
        tblStockKeeper.alpha = 1
        tblStockKeeper.isUserInteractionEnabled = true
        btnTabNew.isUserInteractionEnabled = true
        btnExported.isUserInteractionEnabled = true
    }
    // MARK: - TextFieldDelegate
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
        //self._lblFromDate.textColor = fromColor
        self._txtFromDate.textColor = fromColor
        self._txtFromDate.leftView?.tintColor = fromColor
        //self._lblToDate.textColor = toColor
        self._txtToDate.textColor = toColor
        self._txtToDate.leftView?.tintColor = toColor
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
            _searchBar.isUserInteractionEnabled = false
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
            _dataCustomer       = model.getRecord()
            // Load data for search bar table view
            _tblSearch.reloadData()
            // Show
            _tblSearch.isHidden = !_searchActive
            // Move to front
            self.view.bringSubview(toFront: _tblSearch)
            _tblSearch.layer.zPosition = 1
            // hide Pickerview and button
            hideWhenSearchCustomer()
            
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
        _searchBar.isUserInteractionEnabled = true
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
            _tblSearch.isHidden = !_searchActive
        }
        _tblSearch.isHidden = true
        // Appear pickerview and button for search
        appearWhenFinishSearchCustomer()
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
        _tblSearch.isHidden = !_searchActive
        // Hide keyboard
        self.view.endEditing(true)
        // Appear pickerview and button for search
        appearWhenFinishSearchCustomer()
        
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
        //self.view.addGestureRecognizer(_gestureHideKeyboard)
    }
    
    /**
     * Tells the delegate that the user finished editing the search text.
     */
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        _searchActive = true
        _isKeyboardShow = false
        // If text is empty
        if (_searchBar.text?.isEmpty)! {
        } else {
            self.view.endEditing(true)
        }
        _tblSearch.isHidden = true
    
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
     * Handle tap on Search button
     * - parameter sender: AnyObject
     */
    internal func searchButtonTapped(_ sender: AnyObject) {
        if _searchView.isHidden == true {
            _searchView.isHidden = false
            // Move to front
            self.view.bringSubview(toFront: _searchView)
            tblStockKeeper.alpha = 0.3
            tblStockKeeper.isUserInteractionEnabled = false
            btnTabNew.isUserInteractionEnabled = false
            btnExported.isUserInteractionEnabled = false
            // custom view
            viewLayout.backgroundColor = UIColor.darkGray
            _txtFromDate.becomeFirstResponder()
        } else {
            _searchView.isHidden = true
            tblStockKeeper.alpha = 1
            tblStockKeeper.isUserInteractionEnabled = true
            btnTabNew.isUserInteractionEnabled = true
            btnExported.isUserInteractionEnabled = true
            // custom view
            viewLayout.backgroundColor = UIColor.white
            _txtFromDate.resignFirstResponder()
            _txtToDate.resignFirstResponder()
        }
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        self.resetData()
        requestData(completionHandler: finishHandleRefresh(_:))
    }
    
    /**
     * Handle finish refresh
     */
    internal func finishHandleRefresh(_ model: Any?) {
        finishRequest(model)
        //-- BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
        refreshControl.endRefreshing()
    }
    
    /**
     * Reset data
     */
    private func resetData() {
        _data.clearData()
        _page            = 0
        // Reset current search value
        self._carId      = ""
        self._driverId   = ""
        self._customerId = ""
        //Reset pickerview
        _pkvDriver.selectRow(0, inComponent: 0, animated: true)
        _pkvCar.selectRow(0, inComponent: 0, animated: true)
        //_fromDate        = CommonProcess.getCurrentDate()
        //_toDate          = CommonProcess.getCurrentDate()
        // Reload table
        tblStockKeeper.reloadData()
    }
    
    /**
     * Request data from server
     */
    internal func requestData() {
        requestData(completionHandler: finishRequest)
    }
    
    private func requestData(completionHandler: ((Any?)->Void)?) {
        StockListRequest.request(view: self, page: String(_page), type: _type, customerId: _customerId, date_from: _fromDate, date_to: _toDate, driver_id: _driverId, car_id: _carId, completionHandler: completionHandler)
    }

    override func finishRequest(_ model: Any?) {
        let data = model as! String
        let model = StockListResponseModel(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
            tblStockKeeper.reloadData()
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    
    internal func openDetail(id: String) {
        BaseModel.shared.sharedString = id
        self.pushToView(name: G18F00S02VC.theClassName)
    }
    
    func hideWhenSearchCustomer(){
        _pkvCar.isUserInteractionEnabled = false
        _pkvDriver.isUserInteractionEnabled = false
        _btnSearchCustomer.isUserInteractionEnabled = false
        _btnReset.isUserInteractionEnabled = false
    }
    
    func appearWhenFinishSearchCustomer(){
        _pkvCar.isUserInteractionEnabled = true
        _pkvDriver.isUserInteractionEnabled = true
        _btnSearchCustomer.isUserInteractionEnabled = true
        _btnReset.isUserInteractionEnabled = true
    }

}

// MARK: Protocol - UITableViewDataSource
extension G18F00S01VC: UITableViewDataSource{
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == _tblSearch {
            return _dataCustomer.count
        }
        else  if tableView == tblStockKeeper {
            return _data.record.count
        }
        return 0
        //return _data.record.count
        
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            var cell = UITableViewCell()
            if tableView == _tblSearch {
                if _dataCustomer.count > indexPath.row {
                    cell.textLabel?.text = _dataCustomer[indexPath.row].name
                }
                
            }
            else  if tableView == tblStockKeeper {
                let cell2: StockKeeperCell  = tableView.dequeueReusableCell(
                    withIdentifier: "StockKeeperCell")
                    as! StockKeeperCell
                cell2.lblName.text = self._data.getRecord()[indexPath.row].customer_name
                cell2.lblDate.text = "🗓\(self._data.getRecord()[indexPath.row].date_delivery)"
                cell2.lblAddress.text = "🏚\(self._data.getRecord()[indexPath.row].customer_address)"
                cell2.lblInfoGas.text = self._data.getRecord()[indexPath.row].name_gas
                cell2.lblCodePrice.text = "\(self._data.getRecord()[indexPath.row].code_no)-\(self._data.getRecord()[indexPath.row].grand_total)"
                switch self._data.getRecord()[indexPath.row].status_number{
                case "1" :
                    cell2.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_NEW_ICON_IMG_NAME)
                    break
                case "3" :
                    cell2.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_PROCESS_ICON_IMG_NAME)
                    break
                case "4" : 
                    cell2.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_APPROVE_ICON_IMG_NAME) 
                    break
                case "5" :
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
extension G18F00S01VC: UITableViewDelegate {    
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
        if tableView == tblStockKeeper{
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
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == _tblSearch{
            _searchActive = false
            _tblSearch.isHidden = !_searchActive
            _searchBar.resignFirstResponder()
            _customerId = _dataCustomer[indexPath.row].id
            _searchBar.text = _dataCustomer[indexPath.row].name
            // Appear pickerview and button for search
            appearWhenFinishSearchCustomer()
            
        }
        else if tableView == tblStockKeeper{          
            if self._data.getRecord().count > indexPath.row {
            self.openDetail(id: self._data.getRecord()[indexPath.row].id)
        }
    }
}
    

    
    /**
     * Asks the data source to verify that the given row is editable.
     */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /**
     * Asks the data source to commit the insertion or deletion of a specified row in the receiver.
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}

