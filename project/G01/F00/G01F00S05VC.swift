//
//  G01F00S05VC.swift
//  project
//
//  Created by SPJ on 6/3/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F00S05VC: ChildViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    // MARK: Properties
    /** Information table view */
    @IBOutlet weak var _tableView:  UITableView!
    /** Bottom view */
    private var _bottomView:        UIView                      = UIView()
    /** Id */
    public static var _id:          String                      = DomainConst.BLANK
    /** Data */
    private var _data:              FamilyUpholdViewRespModel   = FamilyUpholdViewRespModel()
    /** Customer name label */
    private var _lblCustomerName:   UILabel                     = UILabel()
    /** List of information data */
    private var _listInfo:          [ConfigurationModel]        = [ConfigurationModel]()
    /** Note textview */
    private var _tbxNote:           UITextView                  = UITextView()
    /** Height of bottom view */
    private let bottomHeight:       CGFloat                     = 2 * (GlobalConst.BUTTON_H + GlobalConst.MARGIN)
    /** Action button */
    private var btnAction:          UIButton                    = UIButton()
    /** Acncel button */
    private var btnCancel:          UIButton                     = UIButton()
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Methods
    // MARK: Data prepare
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        FamilyUpholdViewRequest.request(action: action,
                                        view: self,
                                        id: G01F00S05VC._id)
    }
    
    /**
     * Setup list information data
     */
    func setupListInfo(data: FamilyUpholdBean = FamilyUpholdBean()) {
        self._listInfo.removeAll()
        // Uphold code
        _listInfo.append(ConfigurationModel(id: DomainConst.UPHOLD_INFO_ID_ID,
                                            name: DomainConst.CONTENT00421,
                                            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
                                            value: DomainConst.ORDER_CODE_PREFIX + data.name))
        // Uphold status
        var status = DomainConst.CONTENT00422
        if !data.status_number.isEmpty {
            status = getStatusString(status: data.status_number)
        }
        _listInfo.append(ConfigurationModel(id: DomainConst.UPHOLD_INFO_STATUS_ID,
                                            name: DomainConst.CONTENT00092,
                                            iconPath: DomainConst.ORDER_STATUS_ICON_IMG_NAME,
                                            value: status))
        // Created date
        _listInfo.append(ConfigurationModel(
            id: DomainConst.UPHOLD_INFO_CREATED_DATE_ID,
            name: DomainConst.CONTENT00096,
            iconPath: DomainConst.DATETIME_ICON_IMG_NAME,
            value: data.created_date))
        
        // Address
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_ADDRESS_ID,
            name: data.customer_address.normalizateString(),
            iconPath: DomainConst.ADDRESS_ICON_IMG_NAME,
            value: DomainConst.BLANK))
        
        // Contact
        if !data.customer_phone.isEmpty {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_CONTACT_ID,
                name: data.customer_phone,
                iconPath: DomainConst.PHONE_IMG_NAME,
                value: DomainConst.BLANK))
        }
        
        // Customer note
        _listInfo.append(ConfigurationModel(
            id: DomainConst.UPHOLD_INFO_CUSTOMER_NOTE_ID,
            name: data.note_create,
            iconPath: DomainConst.PROBLEM_TYPE_IMG_NAME,
            value: DomainConst.BLANK))
        _tableView.frame = CGRect(x: 0,
                                  y: _lblCustomerName.frame.maxY,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: CGFloat(_listInfo.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        _tbxNote.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                y: _tableView.frame.maxY,
                                width: GlobalConst.EDITTEXT_W,
                                height: GlobalConst.EDITTEXT_H * 3)
    }
    
    /**
     * Get status string from status number
     * - parameter status: Value of status number
     * - returns: Value of status string
     */
    private func getStatusString(status: String) -> String {
        var retVal = DomainConst.BLANK
        switch status {
        case String(FamilyUpholdStatusEnum.STATUS_NEW.rawValue):
            retVal = DomainConst.CONTENT00422
            break
        case String(FamilyUpholdStatusEnum.STATUS_COMPLETE.rawValue):
            retVal = DomainConst.CONTENT00423
            break
        case String(FamilyUpholdStatusEnum.STATUS_CANCEL.rawValue):
            retVal = DomainConst.CONTENT00331
            break
        default:
            break
        }
        return retVal
    }
    
    /**
     * Create bottom view
     */
    private func createBottomView() {
        var botOffset: CGFloat = 0.0
        // Create save button
        let btnSave = UIButton()
        CommonProcess.createButtonLayout(
            btn: btnSave, x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2, y: botOffset,
            text: DomainConst.CONTENT00402, action: #selector(btnSaveTapped(_:)), target: self,
            img: DomainConst.RELOAD_IMG_NAME, tintedColor: UIColor.white)
        
        btnSave.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                               left: GlobalConst.MARGIN,
                                               bottom: GlobalConst.MARGIN,
                                               right: GlobalConst.MARGIN)
        botOffset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        _bottomView.addSubview(btnSave)
        
        // Button action
        setupButton(button: btnAction, x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                    y: botOffset, title: DomainConst.CONTENT00311,
                    icon: DomainConst.CONFIRM_IMG_NAME, color: GlobalConst.BUTTON_COLOR_RED,
                    action: #selector(btnActionHandler(_:)))
        setupButton(button: btnCancel, x: GlobalConst.SCREEN_WIDTH / 2,
                    y: botOffset, title: DomainConst.CONTENT00220,
                    icon: DomainConst.CANCEL_IMG_NAME, color: GlobalConst.BUTTON_COLOR_YELLOW,
                    action: #selector(btnCancelHandler(_:)))
        _bottomView.addSubview(btnAction)
        _bottomView.addSubview(btnCancel)
    }
    
    // MARK: Event handler
    /**
     * Handle when tap on save button
     */
    internal func btnSaveTapped(_ sender: AnyObject) {
        //showAlert(message: DomainConst.CONTENT00362)
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheData(_:)),
                                             view: self)
        } else {
            // Start create ticket
            startCreateTicket()
        }
    }
    
    /**
     * Handle when finish request cache data
     */
    internal func finishRequestCacheData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            // Start create ticket
            startCreateTicket()
        } else {
            self.showAlert(message: model.message)
        }
    }
    
    /**
     * Start create ticket
     */
    private func startCreateTicket() {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00433,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
        for item in CacheDataRespModel.record.getListTicketHandler() {
            let action = UIAlertAction(title: item.name,
                                       style: .default, handler: {
                                        action in
                                        self.handleCreateTicket(id: item.id)
            })
            alert.addAction(action)
        }
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = self.view
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Open create ticket view controller
     * - parameter id: Id of ticket handler
     */
    internal func handleCreateTicket(id: String) {
        G11F01VC._handlerId = id
        G11F01S01._selectedValue.content = String.init(
            format: "Bảo trì HGĐ - %@ - %@ - %@\n",
            _data.record.created_date,
            _data.record.name,
            _data.record.customer_name)
        self.pushToView(name: G11F01VC.theClassName)
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
    /**
     * Handle when finish request
     */
    override func setData(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        _data = FamilyUpholdViewRespModel(jsonString: dataStr)
        if _data.isSuccess() {
            setupListInfo(data: _data.record)
            _lblCustomerName.text   = _data.record.customer_name
            _tbxNote.text           = _data.record.note_employee
            btnAction.isEnabled     = (_data.record.allow_update == DomainConst.NUMBER_ONE_VALUE)
            btnCancel.isEnabled     = (_data.record.allow_update == DomainConst.NUMBER_ONE_VALUE)
            _tableView.reloadData()
            _tbxNote.isEditable = (_data.record.allow_update == DomainConst.NUMBER_ONE_VALUE)
        } else {
            showAlert(message: _data.message)
        }
    }
    
    /**
     * Handle when tap on Action button
     */
    internal func btnActionHandler(_ sender: AnyObject) {
        FamilyUpholdUpdateRequest.request(
            action: #selector(finishCompleteHandler(_:)),
            view: self,
            actionType: FamilyUpholdStatusEnum.STATUS_COMPLETE.rawValue,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: G01F00S05VC._id,
            note: _tbxNote.text)
    }
    
    /**
     * Handle finish confirm
     */
    internal func finishCompleteHandler(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            self.handleRefresh(self)
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle when tap on Cancel button
     */
    internal func btnCancelHandler(_ sender: AnyObject) {
        FamilyUpholdUpdateRequest.request(
            action: #selector(finishCompleteHandler(_:)),
            view: self,
            actionType: FamilyUpholdStatusEnum.STATUS_CANCEL.rawValue,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: G01F00S05VC._id,
            note: _tbxNote.text)
    }
    
    // MARK: Override from UIViewController
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle when open this view by notification
        if G01F00S05VC._id.isEmpty {
            G01F00S05VC._id = BaseModel.shared.sharedString
        }

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00143)
        setupListInfo()
        var offset: CGFloat = getTopHeight()
        // Customer name label
        _lblCustomerName.frame = CGRect(x: 0, y: offset,
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: GlobalConst.LABEL_H)
        _lblCustomerName.text = "Tên Khách HàngTên Khách HàngTên Khách HàngTên Khách Hàng"
        _lblCustomerName.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        _lblCustomerName.textColor = GlobalConst.BUTTON_COLOR_RED
        _lblCustomerName.textAlignment = .center
        _lblCustomerName.lineBreakMode = .byWordWrapping
        _lblCustomerName.numberOfLines = 0
        self.view.addSubview(_lblCustomerName)
        offset = offset + _lblCustomerName.frame.height
        
        // Information table view
        _tableView.translatesAutoresizingMaskIntoConstraints = true
        _tableView.frame = CGRect(x: 0,
                                  y: offset,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: CGFloat(_listInfo.count) * GlobalConst.CONFIGURATION_ITEM_HEIGHT)
        _tableView.addSubview(refreshControl)
        offset = offset + _tableView.frame.height + GlobalConst.MARGIN
        self.view.addSubview(_tableView)
        // Note
        _tbxNote.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                y: offset,
                                width: GlobalConst.EDITTEXT_W,
                                height: GlobalConst.EDITTEXT_H * 3)
        _tbxNote.font               = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxNote.backgroundColor    = UIColor.white
        _tbxNote.autocorrectionType = .no
        _tbxNote.translatesAutoresizingMaskIntoConstraints = true
        _tbxNote.returnKeyType      = .done
        _tbxNote.tag                = 0
        _tbxNote.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        CommonProcess.setBorder(view: _tbxNote, radius: GlobalConst.BUTTON_CORNER_RADIUS)
        _tbxNote.delegate = self
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        self.view.addSubview(_tbxNote)
        
        // Bottom view
        _bottomView.frame = CGRect(x: 0, y: GlobalConst.SCREEN_HEIGHT - bottomHeight,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: bottomHeight)
        //_bottomView.isHidden = true
        self.view.addSubview(_bottomView)
        createBottomView()
        
        // Request data from server
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    /**
     * Asks the data source to return the number of sections in the table view.
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     * Set height of row in table view
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalConst.CONFIGURATION_ITEM_HEIGHT
    }
    
    /**
     * Set number of row in table view
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _listInfo.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ConfigurationTableViewCell.PARENT_WIDTH = GlobalConst.SCREEN_WIDTH
        let cell = tableView.dequeueReusableCell(withIdentifier: ConfigurationTableViewCell.theClassName,
                                                 for: indexPath) as! ConfigurationTableViewCell
        
        cell.setData(data: _listInfo[indexPath.row])
        
        return cell
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if _listInfo[indexPath.row].id == DomainConst.UPHOLD_INFO_CUSTOMER_NOTE_ID {
            self.showAlert(message: _data.record.note_create)
        }
    }
    
    // MARK: UITableViewDelegate
    /**
     * Add a done button when keyboard show
     */
    func addDoneButtonOnKeyboard() {
        // Create toolbar
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(hideKeyboard(_:)))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        // Add toolbar to keyboard
        self._tbxNote.inputAccessoryView = doneToolbar
        self.keyboardTopY -= doneToolbar.frame.height
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        // Hide keyboard
        self.view.endEditing(true)
        // Move back view to previous location
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        })
        // Turn off flag
        isKeyboardShow = false
    }
    
    /**
     * Handle when focus edittext
     * - parameter textField: Textfield will be focusing
     */
    internal func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        isKeyboardShow = true
        // Making A toolbar
        if textView == self._tbxNote {
            addDoneButtonOnKeyboard()
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    /**
     * Hide keyboard
     * - parameter sender: Gesture
     */
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        hideKeyboard()
    }
    
    /**
     * Handle move textview when keyboard overloading
     */
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        let delta = self._tbxNote.frame.maxY - self.keyboardTopY
        if delta > 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y - delta, width: self.view.frame.size.width, height: self.view.frame.size.height)
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
    private func setupButton(button: UIButton, x: CGFloat, y: CGFloat, title: String,
                             icon: String, color: UIColor, action: Selector) {
        button.clipsToBounds = true
        button.frame = CGRect(x: x,
                              y: y,
                              width: GlobalConst.BUTTON_W / 2,
                              height: GlobalConst.BUTTON_H)
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.setBackgroundColor(color: color, forState: .normal)
        button.setBackgroundColor(color: GlobalConst.BUTTON_COLOR_GRAY, forState: .disabled)
        button.titleLabel?.font         = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        button.layer.cornerRadius       = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        button.imageView?.contentMode   = .scaleAspectFit
        button.setImage(ImageManager.getImage(named: icon), for: UIControlState())
        button.addTarget(self, action: action, for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                              left: GlobalConst.MARGIN,
                                              bottom: GlobalConst.MARGIN,
                                              right: GlobalConst.MARGIN)
    }
}
