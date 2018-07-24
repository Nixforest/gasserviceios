//
//  G17F00S02VC.swift
//  project
//
//  Created by SPJ on 7/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework  

class G17F00S02VC: BaseChildViewController,UISearchBarDelegate{
    /** Data */
    internal var _id: String = ""
    internal var _customer_id: String = ""
    /** Flag begin search */
    private var _beginSearch:           Bool                = false
    /** Data json*/
    internal var _dataJson:                  [OrderDetailBean]      = [OrderDetailBean]()
    /** Data */
    internal var _dataCustomer:                  [CustomerBean]      = [CustomerBean]()
    /** Type of search target */
    public static var _type:                  String              = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
    /** Flag search active */
    internal var _searchActive:          Bool                = false
    /** Flag check keyboard is show or hide */
    private var _isKeyboardShow:        Bool                = false
    /** Tap gesture hide keyboard */
    private var _gestureHideKeyboard:   UIGestureRecognizer = UIGestureRecognizer()
    
    
    internal var _data:              CustomerRequestViewResponseModel  = CustomerRequestViewResponseModel()
    /** Refrest control */
    lazy var refreshControl:    UIRefreshControl = {
        let refreshControl =    UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    @IBOutlet weak var _searchBar: UISearchBar!
    
    @IBOutlet weak var tblSearch: UITableView!
    
    @IBOutlet weak var heightButtonDeleteAll: NSLayoutConstraint!
    @IBOutlet weak var heightViewThongTinKhachHang: NSLayoutConstraint!
    
    @IBOutlet weak var ViewThongTinKhachHang: UIView!
    @IBOutlet weak var TfGhiChu: UITextField!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblCustomerAddress: UILabel!
    @IBOutlet weak var btnLuu: UIButton!
    @IBOutlet weak var btnHuy: UIButton!
    @IBOutlet weak var tblMaterial: UITableView!
    @IBOutlet weak var btnThemVatTu: UIButton!
    @IBAction func btn_XoaThongTin(_ sender: Any) {
        HideCustomerInforView()
    }
    @IBAction func btn_XoaVatTu(_ sender: Any) {
        _dataJson.removeAll()
        tblMaterial.reloadData()
    }
    @IBOutlet weak var btnDeleteAll: UIButton!
    @IBAction func btn_Luu(_ sender: Any) {
        var jsonCustomerRequest = [String]()
        for item in _dataJson {
            if !item.material_id.isEmpty {
                jsonCustomerRequest.append(item.createJsonDataForCustomerRequest())
            }
        }
        CustomerRequestUpdateRequest.request(action: #selector(finishUpdateCustomerRequest(_:)), view: self, id: _id, customerId: _customer_id, json: jsonCustomerRequest.joined(separator: DomainConst.SPLITER_TYPE2), note: TfGhiChu.text!)
        /*CustomerRequestCreateRequest.request(action: #selector(finishCreateCustomerRequest(_:)), view: self, customerId: _customer_id, json: jsonCustomerRequest.joined(separator: DomainConst.SPLITER_TYPE2),
                                             note: lblNote.text! )*/
    }
    @IBAction func btn_Huy(_ sender: Any) {
        self.backButtonTapped(self)
    }
    
    @IBAction func btn_ThemVattu(_ sender: Any) {
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheData(_:)),
                                     view: self)
        } 
        else{
            self.selectMaterial(type: G17F00S03VC.TYPE_CYLINDER)
        }
    }
    @IBOutlet weak var btnXoaThongTin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSearch.isHidden = true

        self.createNavigationBar(title: DomainConst.CONTENT00585)
        tblMaterial.dataSource = self
        tblMaterial.delegate = self
        //Custom button
        btnXoaThongTin.layer.cornerRadius = 15
        btnLuu.layer.cornerRadius = 15
        
        btnHuy.layer.cornerRadius = 15
        
        //Custom Text Field
        TfGhiChu.layer.borderColor = UIColor.red.cgColor
        TfGhiChu.layer.borderWidth = 1
        TfGhiChu.layer.cornerRadius = 5
        //
        _id = BaseModel.shared.sharedString
        requestData()
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
        tblSearch.delegate = self
        tblSearch.dataSource = self
        
        // Do any additional setup after loading the view.
        tblMaterial.addSubview(refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(G17F00S02VC._type == G17F00S03VC.TYPE_CYLINDER){
            if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                // Add data
                appendMaterialCylinder(material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                tblMaterial.reloadData()
                //tblMaterial.reloadSections(IndexSet(1...2), with: .automatic)
            }
            G17F00S02VC._type = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
        }
    }

    /**
     * append Material Cylinder
     */
    
    private func appendMaterialCylinder(material: OrderDetailBean, isUpdateQty: Bool = true) {
        _dataJson.append(material)
        tblMaterial.reloadData()
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
            CustomerListRequest.request(action: #selector(finishSearch(_:)),
                                        view: self,
                                        keyword: keyword,
                                        type: G17F00S02VC._type)
        }
    }
    
    /**
     * Handle when finish create customer request
     */
    internal func finishUpdateCustomerRequest(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CustomerRequestViewResponseModel(jsonString: data)
        if model.isSuccess() {
            // Clear data at steps
            self.clearData()
            showAlert(message: model.message,
                      okHandler: {
                        alert in
                        //self.backButtonTapped(self)
                        //G08F00S02VC._id = model.record.id
                         self.pushToView(name: G17F00S01VC.theClassName)
            })
        } else {    // Error
            self.showAlert(message: model.message)
        }
    }
    
    /**
     * Handle when finish search target
     */
    func finishSearch(_ notification: Notification) {
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
        _searchBar.isUserInteractionEnabled = true
    }
    
    /**
     * Tells the delegate that the user changed the search text.
     */
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredStr = searchText
        if filteredStr.characters.count > (DomainConst.SEARCH_TARGET_MIN_LENGTH - 1) {
            _beginSearch = false
            _searchActive = true
            //            // Start count
            //            /** Timer for search auto complete */
            //            var timer = Timer()
            //            timer.invalidate()
            //            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(beginSearching), userInfo: nil, repeats: false)
            
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
        if _searchBar.text != nil {
            _searchBar.text = DomainConst.BLANK
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
        if (_searchBar.text?.isEmpty)! {
        } else {
            self.view.endEditing(true)
        }
    }
    
    // MARK: Methods
    /**
     * Reset data
     */
    private func resetData() {
        // Reload table
        tblMaterial.reloadData()
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
    
    // MARK: Request server methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        CustomerRequestViewRequest.request(action: action,
                                     view: self,
                                     id: self._id)
    }
    
    override func setData(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        let model = CustomerRequestViewResponseModel(jsonString: dataStr)
        if model.isSuccess() {
            _data = model
            _dataJson = _data.record.json
            lblCustomerName.text = _data.record.first_name
            lblCustomerAddress.text = _data.record.address
            TfGhiChu.text = _data.record.note
            tblMaterial.reloadData()
            if(_data.record.allow_update == "0"){
            HideIfNotAllowUpdate()
            }
            // set customerId
            _customer_id = _data.record.customer_id
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle when finish request cache data
     */
    internal func finishRequestCacheData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            // Open create store card view controller
            self.selectMaterial(type: G17F00S03VC.TYPE_CYLINDER)
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    
    /**
     * Handle select material
     * - parameter type: Type of material
     * - parameter data: Current selection
     */
    internal func selectMaterial(type: String, data: OrderDetailBean = OrderDetailBean.init()) {
        MaterialSelectViewController.setSelectedItem(item: data)
        G17F00S02VC._type = type
        switch G17F00S02VC._type {
        case G17F00S03VC.TYPE_GAS:                      // Gas
            MaterialSelectViewController.setMaterialData(orderDetails: CacheDataRespModel.record.getGasMaterials())
            //            MaterialSelectViewController.setMaterialDataFromFavourite(key: DomainConst.KEY_SETTING_FAVOURITE_GAS_LOGIN)
            self.pushToView(name: G05F02S01VC.theClassName)
        case G17F00S03VC.TYPE_CYLINDER:                 // Cylinder
            MaterialSelectViewController.setMaterialData(orderDetails: CacheDataRespModel.record.getCylinderMaterials())
            self.pushToView(name: G05F02S01VC.theClassName)
        case G17F00S03VC.TYPE_OTHERMATERIAL:            // The other material
            MaterialSelectViewController.setMaterialData(orderDetails: CacheDataRespModel.record.getAllMaterials())
            self.pushToView(name: G05F02S01VC.theClassName)
        default:
            break
        }
    }
    
    func ShowCustomerInforView(){
        self.heightViewThongTinKhachHang.constant = 128
        self.ViewThongTinKhachHang.isHidden = false
        self.view.layoutIfNeeded()
    }
    
    func HideCustomerInforView(){
        self.heightViewThongTinKhachHang.constant = 0
        self.ViewThongTinKhachHang.isHidden = true
        self.view.layoutIfNeeded()
    }
    func HideIfNotAllowUpdate(){
        self.heightButtonDeleteAll.constant = 0
        self.heightViewThongTinKhachHang.constant = 98
        self.btnXoaThongTin.isHidden = true
        self.view.layoutIfNeeded()
        self.btnLuu.isHidden = true
        self.btnHuy.isHidden = true
        self.TfGhiChu.isUserInteractionEnabled = false
        self.tblMaterial.isUserInteractionEnabled = false
        self.btnDeleteAll.isUserInteractionEnabled = false
        self._searchBar.isUserInteractionEnabled = false
        self.btnThemVatTu.isUserInteractionEnabled = false
        
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        //G08F01S05._selectedValue.removeAll()
        G17F00S02VC._type = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
        //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
    }
}

// MARK: Protocol - UITableViewDataSource
extension G17F00S02VC: UITableViewDataSource{
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if tableView == tblSearch {
            return _dataCustomer.count
        } else  if tableView == tblMaterial {
                return _dataJson.count
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
                
            } else  if tableView == tblMaterial {
                let cell2: MaterialCell2  = tableView.dequeueReusableCell(
                    withIdentifier: "MaterialCell2")
                    as! MaterialCell2
                    // Setting attributes
                cell2.lblTenVatTu.text = _dataJson[indexPath.row].material_name 
                cell2.lblSoLuong.text = String(_dataJson[indexPath.row].qty)
                cell2.delegate = self
                cell2.index = indexPath.row
                cell = cell2
                                    
            }
            
            return cell
            
    }
}

extension G17F00S02VC: CellTextChangeDelegte{
    func UpdateQuantity(quantity : String, index: Int){
        _dataJson[index].qty = quantity
    }
}

// MARK: - UITableViewDataSource-Delegate
extension G17F00S02VC: UITableViewDelegate {    
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
        /*if _data.total_page != 1 {
         let lastElement = _data.getRecord().count - 1
         // Current is the last element
         if indexPath.row == lastElement {
         self._page += 1
         // Page less than total page
         if self._page <= _data.total_page {
         self.requestData()
         }
         }
         }*/
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblSearch {
            _searchActive = false
            tblSearch.isHidden = !_searchActive
            _searchBar.resignFirstResponder()
            self.lblCustomerName.text = _dataCustomer[indexPath.row].name
            self.lblCustomerAddress.text = _dataCustomer[indexPath.row].address
            self.heightViewThongTinKhachHang.constant = 135
            self.ViewThongTinKhachHang.isHidden = false
            //Set Customer Id
            _customer_id = _dataCustomer[indexPath.row].id
            //_tblTarget.reloadData()
            //self.stepDoneDelegate?.stepDone()
        }

        /*if self._data.getRecord().count > indexPath.row {
         self.openDetail(id: self._data.getRecord()[indexPath.row].id)
         }*/
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
        if editingStyle == .delete{
            _dataJson.remove(at: indexPath.row)
            tblMaterial.deleteRows(at: [indexPath], with: .fade)
            //tblMaterial.reloadData()
            
        }
    }
}
