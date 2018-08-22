//
//  G11F00S02VC.swift
//  project
//
//  Created by SPJ on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework
//++ BUG0203-SPJ (KhoiVT 20180822) Gasservice - Redesign TicketView Screen, add Image for Reply and show Image for reply item
class G11F00S02VC: BaseChildViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Summary information label */
    //private var _lblSum:            UILabel             = UILabel()
    @IBOutlet weak var _lblSum: UILabel!
    /** Id */
    public static var _id:          String              = DomainConst.BLANK
    /** Current data */
    public var _data:              TicketViewRespModel = TicketViewRespModel()
    /** Table view */
    //private var _tblView:           UITableView         = UITableView()
    @IBOutlet weak var _tblView: UITableView!
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Answer button */
    //private var _btnAnswer:         UIButton            = UIButton()
    @IBOutlet weak var _btnAnswer: UIButton!
    /** Close button */
    //private var _btnClose:          UIButton            = UIButton()
    @IBOutlet weak var _btnClose: UIButton!
    /** Collection View Add */
    @IBOutlet weak var cltImg: UICollectionView!
    /** Send Request Button */
    @IBOutlet weak var btnSendRequest: UIButton!
    /** Content TextView */
    @IBOutlet weak var tvContent: UITextView!
    /** Time reply */
    var _dataReply:                 [TicketReplyBean] = [TicketReplyBean]()
    /** List image add to this order */
    internal var _images:            [UIImage]           = [UIImage]()
    /** Reply View */
    @IBOutlet weak var ReplyView: UIView!
    /** CltvImage height */
    @IBOutlet weak var cltvHeight: NSLayoutConstraint!
    /** Table Reply height */
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    // MARK: Methods
    /**
     * Handle button answer tap event
     */
    @IBAction func btnAnswerTapped(_ sender: Any) {
        if cltvHeight.constant == 0 {
            cltvHeight.constant = 296
        }
        else{
            cltvHeight.constant = 0
        }
    }
    
    @IBAction func btnSendRequestTapped(_ sender: Any) {
        TicketReplyRequest.request(action: #selector(finishReplyRequest(_:)), view: self, id: G11F00S02VC._id, message: tvContent.text, images: _images)
    }
    /*internal func btnAnswerTapped(_ sender: AnyObject) {
        var txtAnswerContent: UITextField?
        // Create alert
        let alert = UIAlertController(title: DomainConst.CONTENT00427,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .alert)
        // Add textfield
        alert.addTextField(configurationHandler: { textField -> Void in
            txtAnswerContent = textField
            txtAnswerContent?.placeholder       = DomainConst.CONTENT00428
            txtAnswerContent?.clearButtonMode   = .whileEditing
            txtAnswerContent?.returnKeyType     = .done
            txtAnswerContent?.textAlignment     = .left
        })
        
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
            if (txtAnswerContent?.text?.isBlank)! {
                self.showAlert(message: DomainConst.CONTENT00429, okTitle: DomainConst.CONTENT00251,
                               okHandler: {_ in
                                self.btnAnswerTapped(self)
                },
                               cancelHandler: {_ in
                                
                })
            } else {
                self.requestAnswer(content: (txtAnswerContent?.text)!)
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }*/
    
    /**
     * Handle button close tap event
     */
    @IBAction func btnCloseTapped(_ sender: Any) {
        showAlert(message: DomainConst.CONTENT00430, okHandler: {
            alert in
            self.requestClose()
        }, cancelHandler: {
            alert in
            // Do nothing
        })
    }
    /*internal func btnCloseTapped(_ sender: AnyObject) {
        showAlert(message: DomainConst.CONTENT00430, okHandler: {
            alert in
            self.requestClose()
        }, cancelHandler: {
            alert in
            // Do nothing
        })
    }*/
    
    /**
     * Handle request close ticket
     */
    internal func requestClose() {
        TicketCloseRequest.request(action: #selector(finishCloseRequest(_:)),
                                   view: self,
                                   id: G11F00S02VC._id)
    }
    
    /**
     * Handle request reply ticket
     */
    /*internal func requestAnswer(content: String) {
        TicketReplyRequest.request(action: #selector(finishReplyRequest(_:)),
                                   view: self,
                                   id: G11F00S02VC._id,
                                   message: content)
    }*/
    
    /**
     * Handle when finish reply request
     */
    internal func finishReplyRequest(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            showAlert(message: model.message, okHandler: {
                alert in
                self.requestData()
            })
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle when finish close request
     */
    internal func finishCloseRequest(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            showAlert(message: model.message, okHandler: {
                alert in
                self.backButtonTapped(self)
            })
        } else {
            showAlert(message: model.message)
        }
    }
        
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        if !G11F00S02VC._id.isEmpty {
            TicketViewRequest.request(action: action,
                                                view: self,
                                                id: G11F00S02VC._id)
        }
    }
    
    /**
     * Handle finish refresh
     */
    internal func finishHandleRefresh(_ notification: Notification) {
        setData(notification)
        refreshControl.endRefreshing()
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        requestData(action: #selector(finishHandleRefresh(_:)))
    }
    
    // MARK: Override from UIViewController
    /**
     * Handle finish request data
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = TicketViewRespModel(jsonString: data)
        if model.isSuccess() {
            self._data = model
            self._lblSum.text = model.record.title.capitalizingFirstLetter()
            _btnAnswer.isEnabled = model.record.can_reply == DomainConst.NUMBER_ONE_VALUE
            _btnClose.isEnabled = model.record.can_close == DomainConst.NUMBER_ONE_VALUE
            _dataReply = model.record.list_reply
            _images.removeAll()
            cltImg.reloadData()
            cltvHeight.constant = 0
            tblHeight.constant = CGFloat(_dataReply.count * 300)
            self._tblView.reloadData()
        } else {
            showAlert(message: model.message)
        }
    }
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        //++ BUG0049-SPJ (NguyenPT 20170622) Handle notification
        if G11F00S02VC._id.isEmpty {
            G11F00S02VC._id = BaseModel.shared.sharedString
        }
        //-- BUG0049-SPJ (NguyenPT 20170622) Handle notification
        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00426)
        //Custom button
        //setupButton(button: _btnAnswer, icon: DomainConst.TICKET_REPLY_ICON_IMG_NAME)
        //setupButton(button: _btnClose, icon: DomainConst.TICKET_CLOSE_ICON_IMG_NAME)
        _btnClose.layer.cornerRadius        = 2
        _btnAnswer.layer.cornerRadius       = 2
        btnSendRequest.layer.cornerRadius   = 15
        //Custom textview
        //textview
        let color = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        tvContent.layer.borderColor = color
        tvContent.layer.borderWidth = 1.0
        tvContent.layer.cornerRadius = 5.0
        //tvContent.placeholderText = "Nhập nội dung trả lời"
        //Custome Reply View
        ReplyView.layer.borderWidth = 1
        ReplyView.layer.borderColor = UIColor.red.cgColor
        ReplyView.layer.cornerRadius = 5.0
        /*var offset: CGFloat = getTopHeight()
        
        // Summary information label
        _lblSum.frame = CGRect(x: 0, y: offset,
                               width: GlobalConst.SCREEN_WIDTH,
                               height: GlobalConst.LABEL_H * 2)
        _lblSum.text = "ABC"//DomainConst.BLANK
        _lblSum.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        _lblSum.textColor = GlobalConst.BUTTON_COLOR_RED
        _lblSum.textAlignment = .center
        _lblSum.lineBreakMode = .byWordWrapping
        _lblSum.numberOfLines = 0
        self.view.addSubview(_lblSum)
        offset = offset + _lblSum.frame.height
        
        // Answer button
        setupButton(button: _btnAnswer,
                    x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                    y: offset, title: DomainConst.CONTENT00311,
                    icon: DomainConst.TICKET_REPLY_ICON_IMG_NAME, color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnAnswerTapped(_:)))
        setupButton(button: _btnClose, x: GlobalConst.SCREEN_WIDTH / 2,
                    y: offset, title: DomainConst.CONTENT00220,
                    icon: DomainConst.TICKET_CLOSE_ICON_IMG_NAME, color: GlobalConst.BUTTON_COLOR_YELLOW,
                    action: #selector(btnCloseTapped(_:)))
        offset += _btnAnswer.frame.height
        self.view.addSubview(_btnAnswer)
        self.view.addSubview(_btnClose
        )
        */
        // Table View
        /*_tblView.register(UINib(nibName: G11F00S01Cell.theClassName, bundle: nil), forCellReuseIdentifier: G11F00S01Cell.theClassName)
        _tblView.delegate = self
        _tblView.dataSource = self
        _tblView.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT - offset)
        _tblView.addSubview(refreshControl)
        self.view.addSubview(_tblView)*/
        _tblView.delegate = self
        _tblView.dataSource = self
        _tblView.estimatedRowHeight = 500
        _tblView.rowHeight = UITableViewAutomaticDimension
        // Request data from server
        requestData()
        self.view.makeComponentsColor()
        // Add action Add Image button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.ADD_MATERIAL_ICON_IMG_NAME,
                                       action: #selector(addImageButtonTapped(_:)), target: self)
        //collectionview
        cltImg.dataSource = self
        cltImg.delegate = self
        cltvHeight.constant = 0
        //cltImg.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell5")
        /*let nib = UINib(nibName: "ImageCell", bundle:nil)
        self.cltImg.register(nib, forCellWithReuseIdentifier: "ImageCell5")*/
        
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
     * Setup button for this view
     * - parameter button:  Button to setup
     * - parameter x:       X position of button
     * - parameter y:       Y position of button
     * - parameter title:   Title of button
     * - parameter icon:    Icon of button
     * - parameter color:   Color of button
     * - parameter action:  Action of button
     */
    /*private func setupButton(button: UIButton, x: CGFloat, y: CGFloat, title: String,
                             icon: String, color: UIColor, action: Selector) {
        button.clipsToBounds = true
        button.frame = CGRect(x: x,
                              y: y,
                              width: GlobalConst.BUTTON_W / 2,
                              height: GlobalConst.BUTTON_H)
        button.imageView?.contentMode   = .scaleAspectFit
        button.setImage(ImageManager.getImage(named: icon), for: UIControlState())
        button.addTarget(self, action: action, for: .touchUpInside)
    }*/
    private func setupButton(button: UIButton,
                             icon: String) {
        button.clipsToBounds = true
        button.imageView?.contentMode   = .scaleAspectFit
        button.setImage(ImageManager.getImage(named: icon), for: UIControlState())
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    // MARK: - UITableViewDataSource-Delegate
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _dataReply.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            /*let cell: G11F00S01Cell = tableView.dequeueReusableCell(
                withIdentifier: G11F00S01Cell.theClassName)
                as! G11F00S01Cell
            if _data.record.list_reply.count > indexPath.row {
                cell.setData(dataReply: _data.record.list_reply[indexPath.row])
            }*/
            let cell: ReplyCell = tableView.dequeueReusableCell(
                withIdentifier: ReplyCell.theClassName)
                as! ReplyCell
            if _data.record.list_reply.count > indexPath.row {
                cell.lblName.text = "\(_data.record.list_reply[indexPath.row].name)[\(_data.record.list_reply[indexPath.row].position)]"
                cell.lblDate.text = "Ngày gửi: \(_data.record.list_reply[indexPath.row].created_date)"
                cell.lblReply.text = _data.record.list_reply[indexPath.row].content
            }
            cell.cltv.dataSource = self
            cell.cltv.delegate   = self
            return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? ReplyCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        G01F00S05VC._id = _data.getRecord()[indexPath.row].id
        //        self.pushToView(name: G01F00S05VC.theClassName)
    }
}

// MARK: UIImagePickerControllerDelegate
extension G11F00S02VC: UIImagePickerControllerDelegate {
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
extension G11F00S02VC: UINavigationControllerDelegate {
    // Implement methods
}

// MARK: UICollectionViewDataSource
extension G11F00S02VC: UICollectionViewDataSource {
    /**
     * Asks your data source object for the number of items in the specified section.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return _data.record.images.count
        //return _data.record.images.count + self._images.count
        if collectionView == cltImg {
            return self._images.count
        }
        else{
            return _data.record.list_reply[collectionView.tag].images.count
        }
        return 0
        
        //ImageCellReply
    }
    
    /**
     * Asks your data source object for the cell that corresponds to the specified item in the collection view.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get current cell
        /*let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell5", for: indexPath) as! ImageCell
        if collectionView == cltImg {
            cell.imgPicture.image = self._images[indexPath.row]
            cell.btnDeletePicture.layer.cornerRadius = 12
            cell.layer.borderColor = UIColor.red.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 2
            cell.delegate = self
        }*/
        var cell0 = UICollectionViewCell()
        if collectionView == cltImg {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell5", for: indexPath) as! ImageCell
            cell.imgPicture.image = self._images[indexPath.row]
            cell.btnDeletePicture.layer.cornerRadius = 12
            cell.layer.borderColor = UIColor.red.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 2
            cell.delegate = self
            cell0 = cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCellReply", for: indexPath) as! ImageCell
            cell.imgPicture.getImgFromUrl(link: _data.record.list_reply[collectionView.tag].images[indexPath.row].thumb, contentMode: cell.imgPicture.contentMode)
            cell.btnDeleteHeight.constant = 0
            cell.btnDeletePicture.isHidden = true
            cell0 = cell
        }
        return cell0
    }
}

// MARK: UICollectionViewDelegate
extension G11F00S02VC: UICollectionViewDelegate {
    /**
     * Tells the delegate that the item at the specified index path was selected.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /** push to zoomIMGVC */
        var cell = ImageCell()
        //zoomIMGViewController.imgPicked = cell.imgPicture.image
        if collectionView == cltImg {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell5", for: indexPath) as! ImageCell
            zoomIMGViewController.imgPicked = cell.imgPicture.image
            zoomIMGViewController.setPickedImg(img: self._images[indexPath.row])
            /*if indexPath.row < _data.record.images.count {
             zoomIMGViewController.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].large, contentMode: cell.imageView.contentMode)
             } else {
             zoomIMGViewController.setPickedImg(img: self._images[indexPath.row - _data.record.images.count])
             }*/
            
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCellReply", for: indexPath) as! ImageCell
            zoomIMGViewController.imageView.getImgFromUrl(link: _data.record.list_reply[collectionView.tag].images[indexPath.row].large, contentMode: cell.imgPicture.contentMode)
            //cell.imgPicture.getImgFromUrl(link: _data.record.list_reply[collectionView.tag].images[indexPath.row].thumb, contentMode: cell.imgPicture.contentMode)
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
extension G11F00S02VC: ImageDelegte{
    func deleteImage(cell: ImageCell) {
        if let indexPath = cltImg?.indexPath(for: cell){
            _images.remove(at: indexPath.row)
            cltImg?.deleteItems(at: [indexPath])
        }
    }
}
//-- BUG0203-SPJ (KhoiVT 20180822) Gasservice - Redesign TicketView Screen, add Image for Reply and show Image for reply item
