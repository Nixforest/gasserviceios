//
//  G02F00S03VC.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework
import Alamofire
import AlamofireImage

class G02F00S03VC: ChildExtViewController, UINavigationControllerDelegate {
    // MARK: Properties
    /** Mode: 0-View/1-Create */
    var _mode:          String                      = DomainConst.NUMBER_ZERO_VALUE
    /** Issue Id */
    var _id:            String                      = DomainConst.BLANK
    /** Present data */
    var _data:          IssueReplyBean              = IssueReplyBean()
    /** List of information data */
    var _listInfo:      [ConfigurationModel]        = [ConfigurationModel]()
    /** Information table view */
    var _tblInfo:       UITableView                 = UITableView()
    /** List material images */
    var _listImgs:      [UIImage]                   = [UIImage]()
    
    // MARK: Static
    public static let MODE_VIEW = DomainConst.NUMBER_ZERO_VALUE
    public static let MODE_REPY = DomainConst.NUMBER_ONE_VALUE
    // MARK: Constant
    var HEADER_HEIGHT:      CGFloat = GlobalConst.LABEL_H * 2
    var SECTION_INFO:       Int     = 0
    var SECTION_IMAGE:      Int     = 1
    
    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        createNavigationBar(title: DomainConst.CONTENT00575)
        createInfoTableView()
        self.view.addSubview(_tblInfo)
    }
    
    // MARK: Request server
    /**
     * Request create reply
     */
    internal func requestCreate(isShowLoading: Bool = true) {
        IssueReplyRequest.request(
            action: #selector(finishCreateRequest(_:)),
            view: self,
            id: self._id,
            message: _data.name,
            chief_monitor_id: DomainConst.BLANK,
            monitor_agent_id: DomainConst.BLANK,
            accounting_id: DomainConst.BLANK,
            listImages: self._listImgs)
    }
    
    /**
     * Load image from server
     */
    internal func loadImageFromServer() {
        _listImgs.removeAll()
        for i in 0..<_data.images.count {
            Alamofire.request(
                _data.images[i].thumb).responseImage(
                    completionHandler: { response in
                        if let img = response.result.value {
                            if self._listImgs.count > i { 
                                self._listImgs.insert(img, at: i)
                            } else {
                                self._listImgs.append(img)
                            }
                            self._tblInfo.reloadData()
                        }
                })
        }
    }
    
    internal func finishCreateRequest(_ notification: Notification) {
        let data = notification.object as! String
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            self.backButtonTapped(self)
        } else {
            showAlert(message: model.message)
        }
    }
    
    
    // MARK: Layout
    // MARK: Information table view
    private func createInfoTableView() {
        _tblInfo.frame = CGRect(
            x: 0, y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height)
        _tblInfo.dataSource = self
        _tblInfo.delegate = self
    }
    
    // MARK: Logic
    /**
     * Handle tap button add new
     */
    internal func addNew(_ sender: AnyObject) {
        requestCreate()
    }
    /**
     * Check user can update data
     * - returns: True if current screen mode is reply, False otherwise
     */
    public func canUpdate() -> Bool {
        if self._mode != G02F00S03VC.MODE_VIEW {
            return true
        }
        return false
    }
    /**
     * Set init data for this screen
     * - parameter data: Data of reply
     */
    public func setData(data: IssueReplyBean) {
        self._data = data
        setupListInfo()
        loadImageFromServer()
    }
    
    /**
     * Set mode
     * - parameter mode: Mode of screen
     */
    public func setMode(mode: String, id: String = DomainConst.BLANK) {
        self._mode = mode
        switch _mode {
        case G02F00S03VC.MODE_VIEW:
            break
        case G02F00S03VC.MODE_REPY:
            setupListInfo()
            if canUpdate() {
                createRightNavigationItem(title: DomainConst.CONTENT00580,
                                          action: #selector(addNew(_:)),
                                          target: self)
            }
            break
        default:
            break
        }
        self._id = id
    }
    
    /**
     * Set update data for first list infor
     */
    private func setupListInfo() {
        _listInfo.removeAll()
        // Name
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CUSTOMER_NAME_ID,
            name: DomainConst.CONTENT00576,
            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
            value: _data.name))
        
        // Created by
        if !_data.created_by.isEmpty {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_CREATED_BY_ID,
                name: DomainConst.CONTENT00572,
                iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
                value: _data.created_by))
        }
    }
    
    /**
     * View image
     * - parameter url: Image url
     * - paremeter image: Image thumbnail
     * - parameter contentMode: Content mode
     */
    internal func viewImage(url: String, image: UIImage, contentMode: UIViewContentMode) {
        zoomIMGViewController.imgPicked = image
        if !url.isEmpty {
            zoomIMGViewController.imageView.getImgFromUrl(link: url, contentMode: contentMode)
        }
        
        self.pushToView(name: DomainConst.ZOOM_IMAGE_VIEW_CTRL)
    }
    
    /**
     * Handle input text
     * - parameter content: Data of item
     */
    internal func inputText(content: String) {
        let title           = DomainConst.CONTENT00428
        let message         = DomainConst.BLANK
        let placeHolder     = DomainConst.BLANK
        let keyboardType    = UIKeyboardType.default
        let value           = content
        var tbxValue: UITextField?
        
        // Create alert
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        // Add textfield
        alert.addTextField(configurationHandler: { textField -> Void in
            tbxValue = textField
            tbxValue?.placeholder       = placeHolder
            tbxValue?.clearButtonMode   = .whileEditing
            tbxValue?.returnKeyType     = .done
            tbxValue?.keyboardType      = keyboardType
            tbxValue?.text              = value
            tbxValue?.textAlignment     = .center
        })
        
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) {
            action -> Void in
            if let newValue = tbxValue?.text, !newValue.isEmpty {
                self._data.name = newValue
                self.setupListInfo()
                self._tblInfo.reloadData()
            } else {
                self.showAlert(message: DomainConst.CONTENT00551,
                               okHandler: {
                                alert in
                                self.inputText(content: content)
                })
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        if let popVC = alert.popoverPresentationController {
            popVC.sourceView = self.view
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Open camera
     */
    internal func openCamera(type: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = type
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    /**
     * Add image
     */
    internal func addImage() {
        // Create alert
        let alert = UIAlertController(title: DomainConst.CONTENT00581,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        let camera = UIAlertAction(title: DomainConst.CONTENT00234,
                                   style: .default,
                                   handler: { alert in
                                    self.openCamera(type: .camera)
        })
        let library = UIAlertAction(title: DomainConst.CONTENT00235,
                                   style: .default,
                                   handler: { alert in
                                    self.openCamera(type: .photoLibrary)
        })
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        if let popVC = alert.popoverPresentationController {
            popVC.sourceView = self.view
        }
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: Protocol - UITableViewDataSource
extension G02F00S03VC: UITableViewDataSource {
    /**
     * Asks the data source to return the number of sections in the table view.
     * - returns: _listInfo.count
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     * - returns: List information count
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return _listInfo.count
        case 1: // For future
            return _listImgs.count
        default:
            break
        }
        
        return 0
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row > self._listInfo.count {
                return UITableViewCell()
            }
            let data = self._listInfo[indexPath.row]
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            cell.textLabel?.text = data.name
            cell.textLabel?.font = GlobalConst.BASE_FONT
            cell.detailTextLabel?.text = data.getValue()
            cell.detailTextLabel?.font = GlobalConst.BASE_FONT
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            cell.detailTextLabel?.numberOfLines = 0
            return cell  
        case 1:     // For future
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            if _listImgs.count > indexPath.row {
                cell.imageView?.image = _listImgs[indexPath.row]
            }
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView?.frame = CGRect(
                x: 50, y: 0,
                width: GlobalConst.ACCOUNT_AVATAR_H / 2,
                height: GlobalConst.ACCOUNT_AVATAR_H / 2)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    /**
     * Asks the delegate for a view object to display in the header of the specified section of the table view.
     */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let header = CustomerInfoHeaderView.init(
            frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: HEADER_HEIGHT))
        var actionText = DomainConst.CONTENT00581
        if self._mode == G02F00S03VC.MODE_VIEW {
            actionText = DomainConst.BLANK
        }
        header.setHeader(bean: ConfigBean.init(id: DomainConst.BLANK, name: DomainConst.CONTENT00579),
                         actionText: actionText)
        header.delegate = self
        return header
    }
    
    /**
     * Asks the delegate for the height to use for the header of a particular section.
     */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return HEADER_HEIGHT
    }
    
    /**
     * Asks the data source to verify that the given row is editable.
     */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {        
        switch indexPath.section {
        case SECTION_INFO:
            return false
        case SECTION_IMAGE:
            if self.canUpdate() {
                return true
            }
        default:
            return false
        }
        return false
    }
}

// MARK: Protocol - UITableViewDelegate
extension G02F00S03VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if self.canUpdate() {
                self.inputText(content: self._data.name)
            }
            return
        case 1:
            if !self.canUpdate() {
                self.viewImage(url: _data.images[indexPath.row].large,
                               image: UIImage(), contentMode: .scaleAspectFit)
            } else {
                self.viewImage(url: DomainConst.BLANK,
                               image: self._listImgs[indexPath.row],
                               contentMode: .scaleAspectFit)
            }
        default:
            break
        }
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    /**
     * Asks the delegate for the actions to display in response to a swipe in the specified row.
     */
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: DomainConst.CONTENT00066) { (action, indexPath) in
            self._listImgs.remove(at: indexPath.row)
            self._tblInfo.reloadData()
        }
        return [delete]
    }
}

// MARK: Protocol - CustomerInfoHeaderViewDelegate
extension G02F00S03VC: CustomerInfoHeaderViewDelegate {    
    func customerInfoHeaderViewDidSelect(object: ConfigBean) {
        if self._mode == G02F00S03VC.MODE_REPY {
            self.addImage()
        }
    }
}

// MARK: Protocol - UIImagePickerControllerDelegate
extension G02F00S03VC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerEditedImage] as? UIImage {
            self._listImgs.append(img)
        }
        self._tblInfo.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}
