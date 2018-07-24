 //
//  G17F00S03VC.swift
//  project
//
//  Created by SPJ on 7/13/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework  

class G17F00S03VC: BaseChildViewController,UISearchBarDelegate {
    //Constrain height of Info layout component
    internal var _customer_id: String = "" 
    @IBOutlet weak var tblSearch: UITableView!
    @IBOutlet weak var tblMaterial: UITableView!
    /** Flag begin search */
    private var _beginSearch:           Bool                = false
    /** Data */
    internal var _dataCustomer:                  [CustomerBean]      = [CustomerBean]()
    /** Data json*/
    internal var _dataJson:                  [OrderDetailBean]      = [OrderDetailBean]()
    /** Type of search target */
    public static var _type:                  String              = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
    public static let TYPE_NONE:              String = DomainConst.NUMBER_ZERO_VALUE
    public static let TYPE_GAS:               String = "1"
    public static let TYPE_OTHERMATERIAL:     String = "2"
    public static let TYPE_CYLINDER:          String = "3"
    /** Flag search active */
    internal var _searchActive:          Bool                = false
    /** Flag check keyboard is show or hide */
    private var _isKeyboardShow:        Bool                = false
    /** Tap gesture hide keyboard */
    private var _gestureHideKeyboard:   UIGestureRecognizer = UIGestureRecognizer()
    @IBOutlet weak var heightInfo: NSLayoutConstraint!
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    @IBOutlet weak var sbTimKhachHang: UISearchBar!
    @IBOutlet weak var viewThongTinKH: UIView!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblNote: UITextField!
    @IBOutlet weak var btnDeleteInfo: UIButton!
    @IBOutlet weak var imgDeleteAll: UIButton!
    @IBOutlet weak var bntSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnThemVatTu: UIButton!
    
    @IBAction func btn_ThemVatTu(_ sender: Any) {
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheData(_:)),
                                     view: self)
        } 
        else{
            self.selectMaterial(type: G17F00S03VC.TYPE_CYLINDER)
        }
        
    }
    @IBAction func img_DeleteAll(_ sender: Any) {
        _dataJson.removeAll()
        tblMaterial.reloadData()
    }
    
    @IBAction func btn_DeleteInfo(_ sender: Any) {
        HideCustomerInforView()
    }
    @IBAction func btn_Save(_ sender: Any) {
        var jsonCustomerRequest = [String]()
        for item in _dataJson {
            if !item.material_id.isEmpty {
                jsonCustomerRequest.append(item.createJsonDataForCustomerRequest())
            }
        }
        CustomerRequestCreateRequest.request(action: #selector(finishCreateCustomerRequest(_:)), view: self, customerId: _customer_id, json: jsonCustomerRequest.joined(separator: DomainConst.SPLITER_TYPE2),
            note: lblNote.text! )
        
    }
    
    @IBAction func btn_Cancel(_ sender: Any) {
        self.backButtonTapped(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar(title: DomainConst.CONTENT00584)
        self.automaticallyAdjustsScrollViewInsets = false
        tblMaterial.dataSource = self
        tblMaterial.delegate = self
        tblMaterial.estimatedRowHeight = 200
        tblMaterial.rowHeight = UITableViewAutomaticDimension
        //hide customer view
        //HideCustomerInforView()
        // Initialization code
        /*viewCustomerRequestCreate.layer.borderColor = UIColor.red.cgColor
        viewCustomerRequestCreate.layer.borderWidth = 1
        viewCustomerRequestCreate.layer.cornerRadius = 5*/
        
        lblNote.layer.borderColor = UIColor.red.cgColor
        lblNote.layer.borderWidth = 1
        lblNote.layer.cornerRadius = 5
        //set Image for btnDelete All
        //imgDeleteAll.image = ImageManager.getImage(named: DomainConst.CLEAR_ALL_ICON_IMG_NAME)
        //Set corner Button Delete Info
        btnDeleteInfo.layer.cornerRadius = 15
        bntSave.layer.cornerRadius = 15
        btnCancel.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
        // Search bar        
        sbTimKhachHang.delegate = self
        sbTimKhachHang.placeholder          = DomainConst.CONTENT00287
        sbTimKhachHang.layer.shadowColor    = UIColor.black.cgColor
        sbTimKhachHang.layer.shadowOpacity  = 0.5
        sbTimKhachHang.layer.masksToBounds  = false
        sbTimKhachHang.showsCancelButton    = true
        sbTimKhachHang.showsBookmarkButton  = false
        sbTimKhachHang.searchBarStyle       = .default
        // Gesture
        _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Table Search Bar
        tblSearch.delegate = self
        tblSearch.dataSource = self
        tblSearch.isHidden = true
        HideCustomerInforView()
        
        //button edit bar
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(G17F00S03VC._type == G17F00S03VC.TYPE_CYLINDER){
            if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                // Add data
                appendMaterialCylinder(material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                tblMaterial.reloadData()
                //tblMaterial.reloadSections(IndexSet(1...2), with: .automatic)
            }
            G17F00S03VC._type = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
        }
    }
    
    private func appendMaterialCylinder(material: OrderDetailBean, isUpdateQty: Bool = true) {
        _dataJson.append(material)
        tblMaterial.reloadData()
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
        G17F00S03VC._type = type
        switch G17F00S03VC._type {
        case G17F00S03VC.TYPE_GAS:                      // Gas
            MaterialSelectViewController.setMaterialData(orderDetails: CacheDataRespModel.record.getGasMaterials())
            //            MaterialSelectViewController.setMaterialDataFromFavourite(key: DomainConst.KEY_SETTING_FAVOURITE_GAS_LOGIN)
            self.pushToView(name: G05F02S01VC.theClassName)
        case G08F01S03.TYPE_CYLINDER:                 // Cylinder
            MaterialSelectViewController.setMaterialData(orderDetails: CacheDataRespModel.record.getCylinderMaterials())
            self.pushToView(name: G05F02S01VC.theClassName)
        case G08F01S03.TYPE_OTHERMATERIAL:            // The other material
            MaterialSelectViewController.setMaterialData(orderDetails: CacheDataRespModel.record.getAllMaterials())
            self.pushToView(name: G05F02S01VC.theClassName)
        default:
            break
        }
    }
    
    /**
     * Handle when finish create customer request
     */
    internal func finishCreateCustomerRequest(_ notification: Notification) {
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
        
        if sbTimKhachHang.text != nil {
            // Get keyword
            let keyword = sbTimKhachHang.text!.removeSign().lowercased()
            sbTimKhachHang.isUserInteractionEnabled = false
            CustomerListRequest.request(action: #selector(finishSearch(_:)),
                                        view: self,
                                        keyword: keyword,
                                        type: G17F00S02VC._type)
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
        sbTimKhachHang.isUserInteractionEnabled = true
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
        if sbTimKhachHang.text != nil {
            sbTimKhachHang.text = DomainConst.BLANK
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
        if (sbTimKhachHang.text?.isEmpty)! {
        } else {
            self.view.endEditing(true)
        }
    }

    func ShowCustomerInforView(){
        self.heightInfo.constant = 127
        self.viewThongTinKH.isHidden = false
        self.view.layoutIfNeeded()
        //self.heightTable.constant = 300
    }
    
    func HideCustomerInforView(){
        self.heightInfo.constant = 0
        self.viewThongTinKH.isHidden = true
        self.view.layoutIfNeeded()
        //self.heightTable.constant = 173
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        //G08F01S05._selectedValue.removeAll()
        G17F00S03VC._type = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
        //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
    }
    
    func changeValue(row: Int, value :  String){
        
    }
}
 
// MARK: Protocol - UITableViewDataSource
extension G17F00S03VC: UITableViewDataSource{
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //return self._data.getRecord().count
        if tableView == tblSearch {
            return _dataCustomer.count
        }
        else  if tableView == tblMaterial {
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
                
            }
            else  if tableView == tblMaterial {
                let cell2: MaterialCell  = tableView.dequeueReusableCell(
                    withIdentifier: "MaterialCell")
                    as! MaterialCell
                // Setting attributes
                cell2.lblMaterialName.text = _dataJson[indexPath.row].material_name
                cell2.tf_quantity.text = _dataJson[indexPath.row].qty
                cell2.delegate = self
                cell2.index = indexPath.row
                //cell2.tf_quantity.addTarget(self, action: #selector(self.changeValue), for: UIControlEvents)
                cell = cell2
                
                
            }
            
            return cell
    }
}
 extension G17F00S03VC: CellTextChangeDelegte{
    func UpdateQuantity(quantity : String, index: Int){
        _dataJson[index].qty = quantity
    }
 }
// MARK: - UITableViewDataSource-Delegate
extension G17F00S03VC: UITableViewDelegate {    
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
        /*if self._data.getRecord().count > indexPath.row {
         self.openDetail(id: self._data.getRecord()[indexPath.row].id)
         }*/
        if tableView == tblSearch {
            _searchActive = false
            tblSearch.isHidden = !_searchActive
            sbTimKhachHang.resignFirstResponder()
            self.lblCustomerName.text = _dataCustomer[indexPath.row].name
            self.lblAddress.text = _dataCustomer[indexPath.row].address
            self.heightInfo.constant = 135
            self.viewThongTinKH.isHidden = false
            
            //Set Customer Id
            _customer_id = _dataCustomer[indexPath.row].id
            //_tblTarget.reloadData()
            //self.stepDoneDelegate?.stepDone()
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
        if editingStyle == .delete{
            _dataJson.remove(at: indexPath.row)
            tblMaterial.deleteRows(at: [indexPath], with: .fade)
            //tblMaterial.reloadData()
            
        }
    }

}

