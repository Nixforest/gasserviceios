//
//  G02F00S04VC.swift
//  project
//
//  Created by SPJ on 9/17/18.
//  Copyright © 2018 admin. All rights reserved.
//
//++ BUG0220-SPJ (KhoiVT 20180918) GasService - Add Function Create Issue
import UIKit
import harpyframework

class G02F00S04VC: BaseChildViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    /** Customer Info View Height */
    @IBOutlet weak var heightInfo:            NSLayoutConstraint!
    /** Customer View */
    @IBOutlet weak var viewCustomer:          UIView!
    /** Label Customer Name */
    /** Colection View Image Margin Top */
    @IBOutlet weak var cltImageMarginTop: NSLayoutConstraint!
    /** Colection View Image Height */
    @IBOutlet weak var cltImageHeight: NSLayoutConstraint!
    /** Table View Search */
    @IBOutlet weak var _tblSearchBar: UITableView!
    /** Text Field Title */
    @IBOutlet weak var tfTitle: UITextField!
    /** Colection View Image*/
    @IBOutlet weak var cltImg: UICollectionView!
    /** Textfield Content */
    @IBOutlet weak var tfContent: UITextField!
    /** Search Bar*/
    @IBOutlet weak var _searchbar: UISearchBar!
    /** Button Create Issue */
    @IBOutlet weak var btnCreate: UIButton!
    /** Segment Control */
    @IBOutlet weak var _segmentControl: UISegmentedControl!
    /** Label customer name */
    @IBOutlet weak var lblCustomerName: UILabel!
    /** Label customer address */
    @IBOutlet weak var lblCustomerAddress: UILabel!
    /** Button Delete Customer Info */
    @IBOutlet weak var btnDeleteInfo: UIButton!
    /** List image add to this order */
    internal var _images:                     [UIImage]           = [UIImage]()
    /** Create Issue */
    @IBAction func createIssue(_ sender: Any) {
        if _issueId == DomainConst.BLANK{
            showAlert(message: G02Const.MESSAGE_ERROR_ISSUE_BLANK,
                      okHandler: {
                        alert in
            })
        }
        if  tfTitle.text! == DomainConst.BLANK{
            showAlert(message: G02Const.MESSAGE_ERROR_TITLE_BLANK,
                      okHandler: {
                        alert in
            })
        }
        if tfContent.text! == DomainConst.BLANK{
            showAlert(message: G02Const.MESSAGE_ERROR_CONTENT_BLANK,
                      okHandler: {
                        alert in
            })
        }
        IssueCreateRequest.request(action: #selector(finishCreateIssueRequest(_:)), view: self, title: tfTitle.text!, message: tfContent.text!, problem: _issueId, customerId: _customerId, images: _images)
    }
    /** Delete Customer Info */
    @IBAction func deleteInfo(_ sender: Any) {
        _customerId = DomainConst.BLANK
        hideCustomerInforView()
    }
    /** Data */
    private var _data:                  [CustomerBean]      = [CustomerBean]()
    /** Issue Id */
    var _issueId: String = DomainConst.BLANK
    /** Customer Id */
    var _customerId: String = DomainConst.BLANK
    /** Search type */
    var _searchStyle: String = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
    /** Flag begin search */
    private var _beginSearch:           Bool                = false
    /** Flag check keyboard is show or hide */
    private var _isKeyboardShow:        Bool                = false
    /** Tap gesture hide keyboard */
    private var _gestureHideKeyboard:   UIGestureRecognizer = UIGestureRecognizer()
    /** Flag search active */
    private var _searchActive:          Bool                = false
    /** Segment change */
    @IBAction func segmentValueChange(_ sender: Any) {
        switch _segmentControl.selectedSegmentIndex {
        case 0:
            _searchStyle = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
            break
        case 1:
            _searchStyle = DomainConst.SEARCH_TARGET_TYPE_AGENT
            break
        default:
            break
        }
    }
    /** Button select Issue*/
    @IBOutlet weak var btnSelectIssue: UIButton!
    /** begin Edit Title */
    @IBAction func beginEditTitle(_ sender: Any) {
        _isKeyboardShow = true
        self.view.addGestureRecognizer(_gestureHideKeyboard)
    }
    /** begin Edit Content */
    @IBAction func beginEditContent(_ sender: Any) {
        _isKeyboardShow = true
        self.view.addGestureRecognizer(_gestureHideKeyboard)
    }
    /** select Issue */
    @IBAction func selectIssue(_ sender: Any) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00592,
                                      message: DomainConst.CONTENT00591,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
        for item in BaseModel.shared.getLisIssue() {
            if item.id != DomainConst.BLANK{
                let action = UIAlertAction(title: item.name,
                                           style: .default, handler: {
                                            action in
                                            self._issueId = item.id
                                            self.btnSelectIssue.set(title: item.name)
                                            
                })
                alert.addAction(action)
            }
        }
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = btnSelectIssue
            presenter.sourceRect = btnSelectIssue.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar(title: DomainConst.CONTENT00590)
        self.automaticallyAdjustsScrollViewInsets = false
        // Search bar        
        _searchbar.delegate               = self
        //_searchbar.backgroundColor        = GlobalConst.BUTTON_COLOR_RED
        _searchbar.layer.shadowColor      = UIColor.black.cgColor
        _searchbar.layer.shadowOpacity    = 0.5
        _searchbar.layer.masksToBounds    = false
        _searchbar.showsCancelButton      = true
        _searchbar.showsBookmarkButton    = false
        _searchbar.searchBarStyle         = .default
        //_searchbar.removeBackgroundImageView()
        // Gesture
        _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        // Show hide result of search bar action
        _tblSearchBar.isHidden = !_searchActive
        _tblSearchBar.delegate = self
        _tblSearchBar.dataSource = self
        //segment 
        _segmentControl.tintColor = GlobalConst.BUTTON_COLOR_RED
        //Custom Button
        btnDeleteInfo.layer.cornerRadius = 15
        btnCreate.layer.cornerRadius = 15
        btnCreate.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        // Add action Add Image button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.ADD_MATERIAL_ICON_IMG_NAME,
                                       action: #selector(addImageButtonTapped(_:)), target: self)
        //collectionview
        cltImg.dataSource           = self
        cltImg.delegate             = self
        cltImageMarginTop.constant = 0
        cltImageHeight.constant = 0
        //hide customer ìnfo view
        hideCustomerInforView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self._images.count > 0 {
            cltImageMarginTop.constant = 10
            cltImageHeight.constant = 133
        }
    }
    
    /**
     * Handle when finish create customer request
     */
    internal func finishCreateIssueRequest(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CustomerRequestViewResponseModel(jsonString: data)
        if model.isSuccess() {
            // Clear data at steps
            //self.clearData()
            showAlert(message: G02Const.MESSAGE_CREATE_SUCCESS,
                      okHandler: {
                        alert in
                        //self.backButtonTapped(self)
                        //G08F00S02VC._id = model.record.id
                        let view = G02F00S01VC(nibName: G02F00S01VC.theClassName, bundle: nil)
                        self.push(view, animated: true)
            })
        } else {    // Error
            self.showAlert(message: model.message)
        }
    }
    
    func hideCustomerInforView(){
        self.heightInfo.constant = 0
        self.viewCustomer.isHidden = true
        self.view.layoutIfNeeded()
        //self.heightTable.constant = 173
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
        _data.removeAll()
        
        if _searchbar.text != nil {
            // Get keyword
            let keyword = _searchbar.text!.removeSign().lowercased()
            _searchbar.isUserInteractionEnabled = false
            CustomerListRequest.request(action: #selector(finishSearch(_:)),
                                        view: self,
                                        keyword: keyword,
                                        type: _searchStyle)
        }
    }
    
    /**
     * Handle when finish search target
     */
    func finishSearch(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CustomerListRespModel(jsonString: data)
        if model.isSuccess() {
            _data = model.getRecord()
            if model.getRecord().count > 0{
                // Load data for search bar table view
                _tblSearchBar.reloadData()
                // Show
                _tblSearchBar.isHidden = !_searchActive
                // Move to front
                //self.bringSubview(toFront: _tblSearchBar)
                _tblSearchBar.layer.zPosition = 1
                _segmentControl.isHidden = true
            }
            else{
                _tblSearchBar.isHidden = true
                _segmentControl.isHidden = false
            }
            
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
            //            // Start count
            //            /** Timer for search auto complete */
            //            var timer = Timer()
            //            timer.invalidate()
            //            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(beginSearching), userInfo: nil, repeats: false)
            
        } else {
            _beginSearch = false
            _searchActive = false
            // Hide search bar table view
            _tblSearchBar.isHidden = !_searchActive
            _segmentControl.isHidden = false
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
        _tblSearchBar.isHidden = !_searchActive
        _segmentControl.isHidden = false
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
    
    // MARK: - UITableViewDataSource
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == _tblSearchBar {
            return _data.count
        } 
        return 0
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Target table view
        return UITableViewAutomaticDimension
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = UITableViewCell()
            if tableView == _tblSearchBar {
                if _data.count > indexPath.row {
                    cell.textLabel?.text = _data[indexPath.row].name
                }
                //cell.textLabel?.text = _data[indexPath.row].name
            } 
            return cell
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == _tblSearchBar {
            _searchActive = false
            _tblSearchBar.isHidden = !_searchActive
            _searchbar.resignFirstResponder()
            _segmentControl.isHidden = false
            self.lblCustomerName.text = _data[indexPath.row].name
            self.lblCustomerAddress.text = _data[indexPath.row].address
            _customerId = _data[indexPath.row].id
            self.heightInfo.constant = 135
            self.viewCustomer.isHidden = false
            //self.stepDoneDelegate?.stepDone()
        }
    }
}

// MARK: UIImagePickerControllerDelegate
extension G02F00S04VC: UIImagePickerControllerDelegate {
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
extension G02F00S04VC: UINavigationControllerDelegate {
    // Implement methods
}

// MARK: UICollectionViewDataSource
extension G02F00S04VC: UICollectionViewDataSource {
    /**
     * Asks your data source object for the number of items in the specified section.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return _data.record.images.count
        //return _data.record.images.count + self._images.count
        return self._images.count
    }
    
    /**
     * Asks your data source object for the cell that corresponds to the specified item in the collection view.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get current cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell7", for: indexPath) as! ImageCell
        cell.imgPicture.image = self._images[indexPath.row]
        cell.btnDeletePicture.layer.cornerRadius = 12
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 2
        cell.delegate = self
        //cell.imageView.frame  = CGRect(x: 0,  y: 0,  width: GlobalConst.ACCOUNT_AVATAR_H / 2, height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        /*if indexPath.row < _data.record.images.count {
         cell.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].thumb, contentMode: cell.imageView.contentMode)
         } else {
         cell.imageView.image = self._images[indexPath.row - _data.record.images.count]
         }*/
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension G02F00S04VC: UICollectionViewDelegate {
    /**
     * Tells the delegate that the item at the specified index path was selected.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell7", for: indexPath) as! ImageCell
        /** push to zoomIMGVC */
        zoomIMGViewController.imgPicked = cell.imgPicture.image
        zoomIMGViewController.setPickedImg(img: self._images[indexPath.row])
        /*if indexPath.row < _data.record.images.count {
         zoomIMGViewController.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].large, contentMode: cell.imageView.contentMode)
         } else {
         zoomIMGViewController.setPickedImg(img: self._images[indexPath.row - _data.record.images.count])
         }*/
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
extension G02F00S04VC: ImageDelegte{
    func deleteImage(cell: ImageCell) {
        if let indexPath = cltImg?.indexPath(for: cell){
            _images.remove(at: indexPath.row)
            cltImg?.deleteItems(at: [indexPath])
            if _images.count == 0{
                cltImageMarginTop.constant = 0
                cltImageHeight.constant = 0
            }
        }
    }
}
//++ BUG0220-SPJ (KhoiVT 20180918) GasService - Add Function Create Issue
