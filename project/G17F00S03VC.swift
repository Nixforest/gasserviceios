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
    internal var _customer_id:                String = "" 
    @IBOutlet weak var tblSearch:             UITableView!
    @IBOutlet weak var tblMaterial:           UITableView!
    /** Flag begin search */
    private var _beginSearch:                 Bool                = false
    /** Data */
    internal var _dataCustomer:              [CustomerBean]      = [CustomerBean]()
    /** Data json*/
    internal var _dataJson:                  [OrderDetailBean]      = [OrderDetailBean]()
    /** Data Client Cache*/
    public static var _dataClientCache:                  [OrderDetailBean]      = [OrderDetailBean]()
    /** Type of search target */
    public static var _type:                  String              = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
    /** Flag search active */
    internal var _searchActive:               Bool                = false
    /** Flag check keyboard is show or hide */
    internal var _isKeyboardShow:              Bool                = false
    /** Tap gesture hide keyboard */
    internal var _gestureHideKeyboard:         UIGestureRecognizer = UIGestureRecognizer()
    @IBOutlet weak var heightInfo:            NSLayoutConstraint!
    @IBOutlet weak var heightTable:           NSLayoutConstraint!
    /** Customer Searchbar */
    @IBOutlet weak var sbSearchCustomer:      UISearchBar!
    /** Customer View */
    @IBOutlet weak var viewCustomer:          UIView!
    /** Label Customer Name */
    @IBOutlet weak var lblCustomerName:       UILabel!
    /** Label Customer Address */
    @IBOutlet weak var lblAddress:            UILabel!
    /** Label Customer Note */
    @IBOutlet weak var lblNote:               UITextField!
    /** Button Delete Info */
    @IBOutlet weak var btnDeleteInfo:         UIButton!
    /** Button Delete All */
    @IBOutlet weak var imgDeleteAll:          UIButton!
    /** Button Save */
    @IBOutlet weak var bntSave:               UIButton!
    /** Button Cancel */
    @IBOutlet weak var btnCancel:             UIButton!
    /** Button Add supply */
    @IBOutlet weak var btnAddSupply:          UIButton!
    
    /** Click Button Add supply */
    @IBAction func btn_Add_Supply(_ sender: Any) {
        if G17F00S03VC._dataClientCache.count > 0 {
             self.selectMaterial()
            
        } 
        else{
            // Request server cache data
            AppDataClientCacheRequest.request(action: #selector(finishRequestCacheData(_:)),
                                              view: self)
            /*CacheDataRequest.request(action: #selector(finishRequestCacheData(_:)),
                                     view: self)*/
        }

    }
    @IBAction func img_DeleteAll(_ sender: Any) {
        _dataJson.removeAll()
        heightTable.constant = 0
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
    
    
    @IBAction func didBeginEdit(_ sender: Any) {
        _isKeyboardShow = true
        self.view.addGestureRecognizer(_gestureHideKeyboard)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar(title: DomainConst.CONTENT00584)
        self.automaticallyAdjustsScrollViewInsets = false
        tblMaterial.dataSource = self
        tblMaterial.delegate   = self
        tblMaterial.estimatedRowHeight = CGFloat(G18Const.ESTIMATE_ROW_HEIGHT)
        tblMaterial.rowHeight  = UITableViewAutomaticDimension
        //hide customer view
        //HideCustomerInforView()
        // Initialization code
        /*viewCustomerRequestCreate.layer.borderColor = UIColor.red.cgColor
        viewCustomerRequestCreate.layer.borderWidth = 1
        viewCustomerRequestCreate.layer.cornerRadius = 5*/
        lblNote.layer.borderColor  = UIColor.red.cgColor
        lblNote.layer.borderWidth  = CGFloat(G18Const.BORDER_WIDTH)
        lblNote.layer.cornerRadius = CGFloat(G18Const.CORNER_RADIUS_BUTTON)
        //set Image for btnDelete All
        //imgDeleteAll.image = ImageManager.getImage(named: DomainConst.CLEAR_ALL_ICON_IMG_NAME)
        //Set corner Button Delete Info
        btnDeleteInfo.layer.cornerRadius    = CGFloat(G18Const.CORNER_RADIUS_BUTTON_2)
        bntSave.layer.cornerRadius          = CGFloat(G18Const.CORNER_RADIUS_BUTTON_2)
        btnCancel.layer.cornerRadius        = CGFloat(G18Const.CORNER_RADIUS_BUTTON_2)
        // Do any additional setup after loading the view.
        // Search bar        
        sbSearchCustomer.delegate = self
        sbSearchCustomer.layer.shadowColor    = UIColor.black.cgColor
        sbSearchCustomer.layer.shadowOpacity  = 0.5
        sbSearchCustomer.layer.masksToBounds  = false
        sbSearchCustomer.showsCancelButton    = true
        sbSearchCustomer.showsBookmarkButton  = false
        sbSearchCustomer.searchBarStyle       = .default
        // Gesture
        _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Table Search Bar
        tblSearch.delegate = self
        tblSearch.dataSource = self
        tblSearch.isHidden = true
        // Hide Customer View
        HideCustomerInforView()
        // hide tbl material
        heightTable.constant = 0
        //button edit bar
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            if !MaterialSelectViewController.getSelectedItem().isEmpty() {
                // Add data
                var flag: Int = 0
                _dataJson.forEach { (OrderDetail) in
                    if OrderDetail.material_id ==  MaterialSelectViewController.getSelectedItem().material_id{
                        showAlert(message: G17Const.ERROR_SAME_MATERIAL,
                                  okHandler: {
                                    alert in
                        })
                        flag = 1
                        return
                    }  
                }
                if flag == 0{
                    appendMaterialCylinder(material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
                    tblMaterial.reloadData()
                }
                //tblMaterial.reloadSections(IndexSet(1...2), with: .automatic)
                //reset SelectedItem
                MaterialSelectViewController.setSelectedItem(item: OrderDetailBean())
            }
            //G17F00S03VC._type = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
        if BaseModel.shared.currentUpholdDetail.customer_id != "" {
            _customer_id = BaseModel.shared.currentUpholdDetail.customer_id
            ShowCustomerInforView()
            self.lblCustomerName.text = BaseModel.shared.currentUpholdDetail.customer_name
            self.lblAddress.text = BaseModel.shared.currentUpholdDetail.customer_address
            BaseModel.shared.currentUpholdDetail.customer_id = ""
        }
    }
    
    private func appendMaterialCylinder(material: OrderDetailBean, isUpdateQty: Bool = true) {
        _dataJson.append(material)
        heightTable.constant += 48
        tblMaterial.reloadData()
    }
    /**
     * Handle when finish request cache data
     */
    internal func finishRequestCacheData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = AppDataClientCacheResponseModel(jsonString: data)
        if model.isSuccess() {
            // Open create store card view controller
            //self.selectMaterial(type: G17F00S03VC.TYPE_CYLINDER)
            G17F00S03VC._dataClientCache = model.record
            self.selectMaterial()
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
    internal func selectMaterial(data: OrderDetailBean = OrderDetailBean.init()) {
        MaterialSelectViewController.setSelectedItem(item: data)
        MaterialSelectViewController.setMaterialData(orderDetails: G17F00S03VC._dataClientCache)
        self.pushToView(name: G05F02S01VC.theClassName)
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
        
        if sbSearchCustomer.text != nil {
            // Get keyword
            let keyword = sbSearchCustomer.text!.removeSign().lowercased()
            sbSearchCustomer.isUserInteractionEnabled = false
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
        sbSearchCustomer.isUserInteractionEnabled = true
    }
    
    /**
     * Tells the delegate that the user changed the search text.
     */
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredStr = searchText
        if filteredStr.count > (DomainConst.SEARCH_TARGET_MIN_LENGTH - 1) {
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
        if sbSearchCustomer.text != nil {
            sbSearchCustomer.text = DomainConst.BLANK
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
        if (sbSearchCustomer.text?.isEmpty)! {
        } else {
            self.view.endEditing(true)
        }
    }

    func ShowCustomerInforView(){
        self.heightInfo.constant = 127
        self.viewCustomer.isHidden = false
        self.view.layoutIfNeeded()
        //self.heightTable.constant = 300
    }
    
    func HideCustomerInforView(){
        self.heightInfo.constant = 0
        self.viewCustomer.isHidden = true
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
                let quantity: Int = Int(cell2.tf_quantity.text!)!
                if quantity == 1{
                    cell2.btnReduce.isHidden = true
                }
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
    func didBeginEdit(){
        _isKeyboardShow = true
        self.view.addGestureRecognizer(_gestureHideKeyboard)
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
            sbSearchCustomer.resignFirstResponder()
            self.lblCustomerName.text = _dataCustomer[indexPath.row].name
            self.lblAddress.text = _dataCustomer[indexPath.row].address
            self.heightInfo.constant = 135
            self.viewCustomer.isHidden = false
            
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
            heightTable.constant -= 48
            //tblMaterial.reloadData()
            
        }
    }

}

