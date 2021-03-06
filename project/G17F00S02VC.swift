//
//  G17F00S02VC.swift
//  project
//
//  Created by SPJ on 7/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework  
import DLRadioButton
import TagListView

class G17F00S02VC: BaseChildViewController,UISearchBarDelegate,TagListViewDelegate{
    @IBOutlet weak var cltImageMarginTop: NSLayoutConstraint!
    @IBOutlet weak var cltImageHeight: NSLayoutConstraint!
    /** Id */
    internal var _id:                               String = ""
    /** Customer Id */
    internal var _customer_id:                      String = ""
    /** Flag begin search */
    private var _beginSearch:                       Bool                = false
    /** Data json*/
    internal var _dataJson:                         [OrderDetailBean]      = [OrderDetailBean]()
    /** Data Catche */
    var _dataCatche: [OrderDetailBean] = [OrderDetailBean]()
    /** Data */
    internal var _dataCustomer:                     [CustomerBean]      = [CustomerBean]()
    /** Type of search target */
    public static var _type:                        String              = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
    /** Flag search active */
    internal var _searchActive:                     Bool                = false
    /** Flag check keyboard is show or hide */
    internal var _isKeyboardShow:                    Bool                = false
    /** Tap gesture hide keyboard */
    internal var _gestureHideKeyboard:               UIGestureRecognizer = UIGestureRecognizer()
    internal var _data:              CustomerRequestViewResponseModel  = CustomerRequestViewResponseModel()
    /** Refrest control */
    lazy var refreshControl:    UIRefreshControl = {
        let refreshControl =    UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Search Bar */
    @IBOutlet weak var _searchBar: UISearchBar!
    /** Table Search Customer */
    @IBOutlet weak var tblSearch: UITableView!
    /** Height of Button Delete All */
    @IBOutlet weak var heightButtonDeleteAll: NSLayoutConstraint!
    /** Height of View Customer Info */
    @IBOutlet weak var heightCustomerInfoView: NSLayoutConstraint!
    /** Height of Table */
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    /** Height of collection view */
    //@IBOutlet weak var heightColectionView: NSLayoutConstraint!
    //@IBOutlet weak var heightTable: NSLayoutConstraint!
    /** View Customer Info */
    @IBOutlet weak var viewCustomerInfo: UIView!
    /** View Customer Name */
    @IBOutlet weak var viewCustomerName: UIView!
    /** View Customer Address */
    @IBOutlet weak var viewCustomerAddress: UIView!
    /** TextField Note */
    @IBOutlet weak var tfNote: UITextField!
    /** Label Customer Name */
    @IBOutlet weak var lblCustomerName: UILabel!
    /** Label Customer Address */
    @IBOutlet weak var lblCustomerAddress: UILabel!
    /** Button Save */
    @IBOutlet weak var btnSave: UIButton!
    /** Button Cancel */
    @IBOutlet weak var btnCancel: UIButton!
    /** Table Material */
    @IBOutlet weak var tblMaterial: UITableView!
    /** Button Add Material */
    //@IBOutlet weak var btnAddMaterial: UIButton!
    /** Button Delete Info */
    @IBOutlet weak var btnDeleteInfo: UIButton!
    //++ BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
    /** Button Lắp mới */
    @IBOutlet weak var btnInvest: DLRadioButton!
    /** Button Sửa chữa */
    @IBOutlet weak var btnInvest2: DLRadioButton!
    /** Button Di dời */
    @IBOutlet weak var btnInvest3: DLRadioButton!
    /** Action invest */
    /** Click Button Invest Tapped */
    @IBAction func actionInvestTapped(_ sender: DLRadioButton) {
        if sender.tag == 1{
            _action_invest = "1"
        }
        else if sender.tag == 2{
            _action_invest = "2"
        }
        else {
            _action_invest = "3"
        }
    }
    internal var _action_invest:              String = "1" 
    //-- BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
    /** List image add to this order */
    internal var _images:            [UIImage]           = [UIImage]()
    /** Previous images */
    public var _previousImage: [UpholdImageInfoItem] = [UpholdImageInfoItem]()
    /** Click Button Delete info */
    @IBAction func deleteInfo(_ sender: Any) {
        _customer_id = ""
        hideCustomerInforView()
    }
    /** Click Button Delete All Material */
    @IBAction func deleteAllMaterial(_ sender: Any) {
        _dataJson.removeAll()
        heightTable.constant = 0
        tblMaterial.reloadData()
    }
    /** Button Delete All */
    @IBOutlet weak var btnDeleteAll: UIButton!
    /** Image collection view */
    @IBOutlet weak var cltImg: UICollectionView!
    /** Click Button Save */
    @IBAction func save(_ sender: Any) {
        if _dataJson.count == 0{
            showAlert(message: G17Const.MESSAGE_JSON_EMPTY_SUCCESS,
                      okHandler: {
                        alert in
            })
        }
        else{
            var jsonCustomerRequest = [String]()
            for item in _dataJson {
                if !item.module_id.isEmpty {
                    jsonCustomerRequest.append(item.createJsonDataForCustomerRequest())
                }
            }
            var imgDeleted = [String]()
            _previousImage.forEach { (previousImage) in
                imgDeleted.append(previousImage.id)
            }
            CustomerRequestUpdateRequest.request(action: #selector(finishUpdateCustomerRequest(_:)), view: self, id: _id, customerId: _customer_id, json: jsonCustomerRequest.joined(separator: DomainConst.SPLITER_TYPE2), note: tfNote.text!,images: _images,listImgDelete:  imgDeleted.joined(separator: DomainConst.SPLITER_TYPE2), action_invest: _action_invest)
        }
    }
    /** Click Button Cancel */
    @IBAction func cancel(_ sender: Any) {
        self.backButtonTapped(self)
    }
    /** Click Button Add Material */
//    @IBAction func addMaterial(_ sender: Any) {
//        if G17F00S03VC._dataClientCache.count > 0 {
//            self.selectMaterial()
//        } 
//        else{
//            // Request server cache data
//            AppDataClientCacheRequest.request(action: #selector(finishRequestCacheData(_:)),
//                                              view: self)
//            /*CacheDataRequest.request(action: #selector(finishRequestCacheData(_:)),
//             view: self)*/
//        }
//    }
    // Did begin Edit Text field Note
    @IBAction func didBegin(_ sender: Any) {
        _isKeyboardShow = true
        self.view.addGestureRecognizer(_gestureHideKeyboard)
    }
    @IBOutlet weak var tagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        tblSearch.isHidden = true

        self.createNavigationBar(title: DomainConst.CONTENT00585)
        tblMaterial.dataSource = self
        tblMaterial.delegate = self
        //Custom button
        btnDeleteInfo.layer.cornerRadius = 15
        btnDeleteInfo.backgroundColor = GlobalConst.BUTTON_COLOR_YELLOW
        btnSave.layer.cornerRadius = 15
        btnSave.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnCancel.layer.cornerRadius = 15
        btnCancel.backgroundColor = GlobalConst.BUTTON_COLOR_YELLOW
        //Custom Text Field
//        tfNote.layer.borderColor = UIColor.gray.cgColor
//        tfNote.layer.borderWidth = 0.5
//        tfNote.layer.cornerRadius = 5
        tfNote.setBottomBorder()
        // Id
        _id = BaseModel.shared.sharedString
        // Search bar        
        _searchBar.delegate = self
        _searchBar.layer.shadowColor    = UIColor.black.cgColor
        _searchBar.layer.shadowOpacity  = 0.5
        _searchBar.layer.masksToBounds  = false
        _searchBar.showsCancelButton    = true
        _searchBar.showsBookmarkButton  = false
        _searchBar.searchBarStyle       = .default
        _searchBar.backgroundColor      = GlobalConst.BUTTON_COLOR_RED
        _searchBar.removeBackgroundImageView()
        // Gesture
        _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Table Search Bar
        tblSearch.delegate = self
        tblSearch.dataSource = self
        // Do any additional setup after loading the view.
        tblMaterial.addSubview(refreshControl)
        // Add action Add Image button to navigation bar
        /*self.createRightNavigationItem(icon: DomainConst.ADD_MATERIAL_ICON_IMG_NAME,
                                       action: #selector(addImageButtonTapped(_:)), target: self)*/
        //heightColectionView.constant = 0
        // Add action Add Image button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.ADD_MATERIAL_ICON_IMG_NAME,
                                       action: #selector(addImageButtonTapped(_:)), target: self)
        //collectionview
        cltImg.dataSource = self
        cltImg.delegate = self
        cltImageMarginTop.constant = 0
        //cltImageHeight.constant = 0
        //++ BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
        // tag list view
        tagListView.delegate = self
        tagListView.textFont = UIFont.systemFont(ofSize: 17)
        tagListView.tagBackgroundColor = GlobalConst.BUTTON_COLOR_RED
        //custom view
        self.viewCustomerName.layer.addBorder(edge: .bottom,
                                              color: UIColor.darkGray,
                                              thickness: 0.5)
        //request module data
        if _dataCatche.count <= 0 {
            AppDataClientCacheRequest.request(action: #selector(finishRequestCacheData(_:)),
                                              view: self)
        }
        else {
            G17F00S03VC._dataClientCache.removeAll()
            //            model.record.forEach { (moduleParent) in
            //                moduleParent.data.forEach({ (moduleChild) in
            //                    G17F00S03VC._dataClientCache.append(moduleChild)
            //                })
            //            }
            _dataCatche.forEach { (moduleParent) in
                tagListView.addTag(moduleParent.name)
            }
        }
        //request data
        requestData()
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        G17F00S03VC._dataClientCache.removeAll()
        _dataCatche.forEach { (orderDetailBean) in
            if orderDetailBean.name == title{
                //print(orderDetailBean.id)
                orderDetailBean.data.forEach { (moduleChild) in
                    G17F00S03VC._dataClientCache.append(moduleChild)
                }
                if let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "PopTableViewController"){
                    let nav = UINavigationController(rootViewController: popoverContent)
                    self.present(nav, animated: true, completion: nil)
                }
            }
        }
    }    
    //-- BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
    override func viewWillAppear(_ animated: Bool) {
        //++ BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
        if G17F00S03VC._selectedList.count > 0{
            G17F00S03VC._selectedList.forEach { (orderDetailBean) in
                var flag:Int = 0
                _dataJson.forEach({ (dataJson) in
                    if dataJson.module_id == orderDetailBean.module_id{
                        flag = 1
                        return
                    }
                })
                if flag == 0{
                    appendMaterialCylinder(material: orderDetailBean)
                }
            }
        }
        G17F00S03VC._selectedList.removeAll()
        tblMaterial.reloadData()
        if (_data.record.images.count > 0 || self._images.count > 0) && cltImageMarginTop.constant == 0{
            cltImageMarginTop.constant = 10
            cltImageHeight.constant = 133
        }
        cltImg.reloadData()
//        if !PopTableViewController.getSelectedItem().isIdEmpty() {
//            // Add data
//            var flag: Int = 0
//            _dataJson.forEach { (OrderDetail) in
//                if OrderDetail.id ==  PopTableViewController.getSelectedItem().id{
//                    showAlert(message: G17Const.ERROR_SAME_MATERIAL,
//                              okHandler: {
//                                alert in
//                    })
//                    flag = 1
//                    return
//                }  
//            }
//            if flag == 0{
//                //appendMaterialCylinder(MaterialSelectViewController2.getSelectedItem()))
//                appendMaterialCylinder(material: PopTableViewController.getSelectedItem())
//                tblMaterial.reloadData()
//                if cltImageMarginTop.constant == 0{
//                    cltImageMarginTop.constant = 10
//                    cltImageHeight.constant = 133
//                }
//            }
//            //tblMaterial.reloadSections(IndexSet(1...2), with: .automatic)
//            //reset SelectedItem
//            PopTableViewController.setSelectedItem(item: OrderDetailBean())
//        }
        //-- BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
            G17F00S02VC._type = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
    }
    
    /**
     * Handle tap on create Customer Request Button
     * - parameter sender: AnyObject
     */
    internal func addImageButtonTapped(_ sender: AnyObject) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00437,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        let actionTakePicture = UIAlertAction(title: "Chụp ảnh",
                                              style: .default, handler: {
                                                action in
                                                self.addImageFromCamera()
        })
        let actionGetPicture = UIAlertAction(title: "Chọn ảnh từ thư viện",
                                             style: .default, handler: {
                                                action in
                                                self.addImageFromLibrary()
        })
        alert.addAction(cancel)
        alert.addAction(actionTakePicture)
        alert.addAction(actionGetPicture)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = sender as! UIButton
            presenter.sourceRect = sender.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle add image from camera
     */
    internal func addImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.camera
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated: true, completion: {
                self.cltImg.reloadData()
            })
        }
    }
    
    /**
     * Handle add image from library
     */
    internal func addImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated: true, completion: {
                self.cltImg.reloadData()
            })
        }
    }
    /**
     * append Material Cylinder
     */
    
    private func appendMaterialCylinder(material: OrderDetailBean, isUpdateQty: Bool = true) {
        _dataJson.append(material)
        heightTable.constant += 48
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
            showAlert(message: G17Const.MESSAGE_UPDATE_SUCCESS,
                      okHandler: {
                        alert in
                        //self.backButtonTapped(self)
                        //G08F00S02VC._id = model.record.id
                         //self.pushToView(name: G17F00S01VC.theClassName)
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
            if viewCustomerInfo.isHidden{
                tagListView.isHidden = true
            }
            else{
                tagListView.isHidden = false
            }
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
            tagListView.isHidden = false
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
        tagListView.isHidden = false
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
            tfNote.text = _data.record.note
            tblMaterial.reloadData()
            //get image for _image
            /*_data.record.images.forEach { (imageItem) in
                loadImage(url: imageItem.large)
            }*/
            _action_invest = _data.record.action_invest
            switch _data.record.action_invest{
                case "1" : self.btnInvest.isSelected = true
                    break
                case "2" : self.btnInvest2.isSelected = true
                    break
                case "3" : self.btnInvest3.isSelected = true
                    break
            default:
                self.btnInvest.isSelected = true
                _action_invest = "1"
            }
            cltImg.reloadData()
            if(_data.record.allow_update == "0"){
            hideIfNotAllowUpdate()
            }
            heightTable.constant = CGFloat(_data.record.json.count * 48)
            if _data.record.images.count > 0 {
                cltImageHeight.constant = 133
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
        let model = AppDataClientCacheResponseModel(jsonString: data)
        if model.isSuccess() {
            // Open create store card view controller
            //self.selectMaterial(type: G17F00S03VC.TYPE_CYLINDER)
            //G17F00S03VC._dataClientCache = model.record
            //self.selectMaterial()
            G17F00S03VC._dataClientCache.removeAll()
//            model.record.forEach { (moduleParent) in
//                moduleParent.data.forEach({ (moduleChild) in
//                    G17F00S03VC._dataClientCache.append(moduleChild)
//                })
//            }
            _dataCatche = model.record
            _dataCatche.forEach { (moduleParent) in
                tagListView.addTag(moduleParent.name)}
            
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    
    /**
     * Handle select material
     * - parameter data: Current selection
     */
//    internal func selectMaterial(data: OrderDetailBean = OrderDetailBean.init()) {
//        MaterialSelectViewController.setSelectedItem(item: data)
//        MaterialSelectViewController.setMaterialData(orderDetails: G17F00S03VC._dataClientCache)
//        self.pushToView(name: G05F02S01VC.theClassName)
//    }
    
    func showCustomerInforView(){
        self.heightCustomerInfoView.constant = 128
        self.viewCustomerInfo.isHidden = false
        self.view.layoutIfNeeded()
    }
    
    func hideCustomerInforView(){
        self.heightCustomerInfoView.constant = 0
        self.viewCustomerInfo.isHidden = true
        self.view.layoutIfNeeded()
    }
    func hideIfNotAllowUpdate(){
        //self.heightButtonDeleteAll.constant = 0
        //self.heightCustomerInfoView.constant = 98
        //self.btnDeleteInfo.isHidden = true
        self.view.layoutIfNeeded()
        self.btnSave.isHidden = true
        self.btnCancel.isHidden = true
        self.tfNote.isUserInteractionEnabled = false
        self.tblMaterial.isUserInteractionEnabled = false
        self.btnDeleteAll.isUserInteractionEnabled = false
        self._searchBar.isUserInteractionEnabled = false
        self.tagListView.isUserInteractionEnabled = false
        self.btnInvest.isUserInteractionEnabled = false
        self.btnInvest2.isUserInteractionEnabled = false
        self.btnInvest3.isUserInteractionEnabled = false
        self.btnDeleteInfo.isUserInteractionEnabled = false
        self.cltImg.isUserInteractionEnabled = false
        //self.btnAddMaterial.isUserInteractionEnabled = false
        
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        //G08F01S05._selectedValue.removeAll()
        G17F00S02VC._type = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
        //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
    }
    
    /**
     * Load Image From Internet and append list uiimage
     */
    
    func loadImage(url: String) {
        let urlImage:URL = URL(string: url)!
        do{
            let data:Data = try Data(contentsOf: urlImage)
            if let image = UIImage(data: data){
                _images.append(image)
            }
        }
        catch{
            print("Download Image Error")
        }
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
                cell2.lblMaterialName.text = _dataJson[indexPath.row].module_name 
                cell2.tfQuantity.text = String(_dataJson[indexPath.row].qty)
                if let quantity = Int(cell2.tfQuantity.text!){
                    if quantity == 999999{
                        cell2.btnIncrease.isHidden = true
                    }
                    else if quantity == 1{
                        cell2.btnReduce.isHidden = true
                    }
                }
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
    func didBeginEdit(){
        _isKeyboardShow = true
        self.view.addGestureRecognizer(_gestureHideKeyboard)
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
            tagListView.isHidden = false
            _searchBar.resignFirstResponder()
            self.lblCustomerName.text = _dataCustomer[indexPath.row].name
            self.lblCustomerAddress.text = _dataCustomer[indexPath.row].address
            self.heightCustomerInfoView.constant = 135
            self.viewCustomerInfo.isHidden = false
            showCustomerInforView()
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
            heightTable.constant -= 48
            tblMaterial.deleteRows(at: [indexPath], with: .fade)
            //tblMaterial.reloadData()
        }
    }
}

// MARK: UIImagePickerControllerDelegate
extension G17F00S02VC: UIImagePickerControllerDelegate {
    /**
     * Tells the delegate that the user picked a still image or movie.
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self._images.append(image)            
        }
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: UINavigationControllerDelegate
extension G17F00S02VC: UINavigationControllerDelegate {
    // Implement methods
}

// MARK: UICollectionViewDataSource
extension G17F00S02VC: UICollectionViewDataSource {
    /**
     * Asks your data source object for the number of items in the specified section.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return _data.record.images.count
        return _data.record.images.count + self._images.count
        //return self._images.count
        //return 10
    }
    
    /**
     * Asks your data source object for the cell that corresponds to the specified item in the collection view.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get current cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell2", for: indexPath) as! ImageCell
        //cell.imgPicture.image = self._images[indexPath.row]
        cell.btnDeletePicture.layer.cornerRadius = 12
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 2
        cell.delegate = self
        //cell.imageView.frame  = CGRect(x: 0,  y: 0,  width: GlobalConst.ACCOUNT_AVATAR_H / 2, height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        if indexPath.row < _data.record.images.count {
         cell.imgPicture.getImgFromUrl(link: _data.record.images[indexPath.row].thumb, contentMode: cell.imgPicture.contentMode)
         } else {
         cell.imgPicture.image = self._images[indexPath.row - _data.record.images.count]
         }
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension G17F00S02VC: UICollectionViewDelegate {
    /**
     * Tells the delegate that the item at the specified index path was selected.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell2", for: indexPath) as! ImageCell
        /** push to zoomIMGVC */
        zoomIMGViewController.imgPicked = cell.imgPicture.image
        //zoomIMGViewController.setPickedImg(img: self._images[indexPath.row])
        if indexPath.row < _data.record.images.count {
         zoomIMGViewController.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].large, contentMode: cell.imgPicture.contentMode)
         } else {
         zoomIMGViewController.setPickedImg(img: self._images[indexPath.row - _data.record.images.count])
         }
        // Move to rating view
        self.pushToView(name: DomainConst.ZOOM_IMAGE_VIEW_CTRL)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        print("Perform")
    }
}
extension G17F00S02VC: ImageDelegte{
    func deleteImage(cell: ImageCell) {
        if let indexPath = cltImg?.indexPath(for: cell){
            if indexPath.row < _data.record.images.count {
                _previousImage.append(_data.record.images[indexPath.row])
                _data.record.images.remove(at: indexPath.row)
            } else {
                _images.remove(at: indexPath.row - _data.record.images.count)
            }
            if _images.count == 0 && _data.record.images.count == 0{
                cltImageMarginTop.constant = 0
                //cltImageHeight.constant = 0
            }
            cltImg.reloadData()
            /*_images.remove(at: indexPath.row)
            cltImg?.deleteItems(at: [indexPath])*/
        }
    }
}

