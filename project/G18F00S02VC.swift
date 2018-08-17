//
//  G18F00S02VC.swift
//  project
//
//  Created by SPJ on 7/25/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework  

class G18F00S02VC: BaseChildViewController {
    /** Flag check keyboard is show or hide */
    internal var _isKeyboardShow:                    Bool                = false
    /** Flag check  save is show or hide */
    internal var _isUpdate:                    Bool                = false
    /** Tap gesture hide keyboard */
    internal var _gestureHideKeyboard:               UIGestureRecognizer = UIGestureRecognizer()
    // Button Save
    //@IBOutlet weak var btnSave: UIButton!
    // Button Other Action
    //@IBOutlet weak var btnOtherAction: UIButton!
    // Click Button Save
    /*@IBAction func btn_Save(_ sender: Any) {
        requestUpdate()
    }*/
    // Click Button Other Action
    /*@IBAction func btn_OtherAction(_ sender: Any) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00436,
                                      message: DomainConst.CONTENT00437,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
        
        let ticket = UIAlertAction(title: DomainConst.CONTENT00402,
                                   style: .default, handler: {
                                    action in
                                    self.btnCreateTicketTapped(self)
        })
        alert.addAction(ticket)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = sender as? UIButton
            //presenter.sourceRect = sender.bounds
        }
        //-- BUG0154-SPJ (NguyenPT 20170909) Add image in VIP order detail when update
        self.present(alert, animated: true, completion: nil)
    }*/
    // Table Stock
    @IBOutlet weak var tblInfoGas: UITableView!
    // Label Deliveried Date
    @IBOutlet weak var lblDeliveriedDate: UILabel!
    // Label Customer Address
    @IBOutlet weak var lblCustomerAddress: UILabel!
    // Label Code
    @IBOutlet weak var lblCode: UILabel!
    // Label Customer Name
    @IBOutlet weak var lblCustomerName: UILabel!
    // Data Stock
    internal var _dataStock:              [InfogasBean]  = [InfogasBean]()
    // Data Stock Keeper
    internal var _data : StockResponseModel = StockResponseModel()
    // App order ID
    internal var _app_order_id : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.automaticallyAdjustsScrollViewInsets = true
        //Custom Button
        /*btnSave.layer.cornerRadius = CGFloat(G18Const.CORNER_RADIUS_BUTTON)
        btnOtherAction.layer.cornerRadius = CGFloat(G18Const.CORNER_RADIUS_BUTTON)*/
        //Create title
        self.createNavigationBar(title: DomainConst.CONTENT00588)
        //tbl Stock
        tblInfoGas.dataSource = self
        tblInfoGas.delegate = self
        tblInfoGas.estimatedRowHeight = CGFloat(G18Const.ESTIMATE_ROW_HEIGHT)
        tblInfoGas.rowHeight = UITableViewAutomaticDimension
        //set app_order_id
        _app_order_id = BaseModel.shared.sharedString
        //request data
        requestData()
        // Gesture
        _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Add action Add Image button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.ADD_MATERIAL_ICON_IMG_NAME,
                                       action: #selector(actionTapped(_:)), target: self)
    }
    
    /**
     * Handle tap on create action Button
     * - parameter sender: AnyObject
     */
    internal func actionTapped(_ sender: AnyObject) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00437,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        let actionOther = UIAlertAction(title: "Tạo Ticket",
                                             style: .default, handler: {
                                                action in
                                                self.btnCreateTicketTapped(self)
        })
        alert.addAction(cancel)
        if _isUpdate == true{
            let actionSave = UIAlertAction(title: "Lưu",
                                           style: .default, handler: {
                                            action in
                                            self.requestUpdate()
            })
            alert.addAction(actionSave)
        }
        alert.addAction(actionOther)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = self.view
        }
        self.present(alert, animated: true, completion: nil)
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
    
    //++request data 
    /**
     * Request data from server
     */
    internal func requestData() {
        requestData(completionHandler: finishRequest)
    }
    
    private func requestData(completionHandler: ((Any?)->Void)?) {
        StockViewRequest.request(view: self, app_order_id: _app_order_id, completionHandler: completionHandler)
        tblInfoGas.reloadData()
    }
    
    override func finishRequest(_ model: Any?) {
        let data = model as! String
        let model = StockResponseModel(jsonString: data)
        if model.isSuccess() {
            _data = model
            lblCustomerName.text = _data.record.customer_name
            lblCode.text         = _data.record.code_no
            lblDeliveriedDate.text = _data.record.date_delivery
            lblCustomerAddress.text = _data.record.customer_address
            if _data.record.allow_update == "0" {
                tblInfoGas.isUserInteractionEnabled = false
                //btnSave.isUserInteractionEnabled = false
                //btnSave.backgroundColor = UIColor.gray
                _isUpdate = false
            }
            else{
                _isUpdate = true
            }
            _dataStock = model.record.stock 
            tblInfoGas.reloadData()
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    //--request data
    
    //++request update 
    /**
     * Request data from server
     */
    internal func requestUpdate() {
        requestUpdate(completionHandler: finishRequestUpdate)
    }
    
    private func requestUpdate(completionHandler: ((Any?)->Void)?) {
        var jsonStock = [String]()
        for item in _dataStock {
            if !item.material_id.isEmpty {
                jsonStock.append(item.createJsonData())
            }
        }
        StockUpdateRequest.request(view: self, app_order_id: _app_order_id, record: jsonStock.joined(separator: DomainConst.SPLITER_TYPE2), completionHandler: completionHandler)
    }
    
    func finishRequestUpdate(_ model: Any?) {
        let data = model as! String
        let model = StockResponseModel(jsonString: data)
        if model.isSuccess() {
            showAlert(message: G18Const.MESSAGE_UPDATE_SUCCESS,
                      okHandler: {
                        alert in
                        /*BaseModel.shared.sharedString = "273"
                        self.backButtonTapped(self)*/
                    }
            )
            
            
                        //G08F00S02VC._id = model.record.id
                        //self.pushToView(name: G18F00S01VC.theClassName)})
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    //--request update
    
    /**
     * Handle when tap on create button
     */
    internal func btnCreateTicketTapped(_ sender: AnyObject) {
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheData(_:)),
                                     view: self)
        } else {
            // Start create ticket
            createTicket()
        }
    }
    
    /**
     * Handle when finish request cache data
     */
    
    /**
     * Handle when finish request cache data
     */
    internal func finishRequestCacheData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            // Start create ticket
            createTicket()
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Start create ticket
     */
    private func createTicket() {
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
            //presenter.sourceRect = self.view.bounds
            
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
            format: "Giữ kho - %@ - %@ - %@\n",
            _data.record.created_date,
            _data.record.code_no,
            _data.record.customer_name)
        self.pushToView(name: G11F01VC.theClassName)
        
    }
}
extension G18F00S02VC: TextChangeDelegte{
    func UpdateSeri(seri: String, index: Int) {
        _dataStock[index].seri = seri
    }
    func didBeginEdit(){
        _isKeyboardShow = true
        self.view.addGestureRecognizer(_gestureHideKeyboard)
    }
}
// MARK: Protocol - UITableViewDataSource
extension G18F00S02VC: UITableViewDataSource{
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _dataStock.count
        
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell: StockGasCell  = tableView.dequeueReusableCell(
                withIdentifier: "StockGasCell")
                as! StockGasCell
                cell.lblName.text  = _dataStock[indexPath.row].material_name
                cell.tfNo.text     = _dataStock[indexPath.row].seri
                cell.delegate = self
                cell.index = indexPath.row
            return cell
            
    }
}



// MARK: - UITableViewDataSource-Delegate
extension G18F00S02VC: UITableViewDelegate {    
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
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
       
