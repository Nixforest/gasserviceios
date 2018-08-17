//
//  G18F00S03VC.swift
//  project
//
//  Created by SPJ on 7/31/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework 

class G18F00S03VC: BaseChildViewController {
    /** Flag check keyboard is show or hide */
    internal var _isKeyboardShow:                    Bool                = false
    /** Tap gesture hide keyboard */
    internal var _gestureHideKeyboard:               UIGestureRecognizer = UIGestureRecognizer()
    /** App Order Id */
    internal var _app_order_id:                               String = ""
    // Data Stock
    internal var _dataStock:              [InfogasBean]  = [InfogasBean]()
    // Data Stock Keeper
    internal var _data : StockResponseModel = StockResponseModel()
    /** Label Customer Name */
    @IBOutlet weak var lblCustomerName: UILabel!
    /** Label Deliveried Date */
    @IBOutlet weak var lblDeliveriedDate: UILabel!
    /** Table Stock */
    @IBOutlet weak var tblStock: UITableView!
    /** Button Confirm Seri */
    @IBOutlet weak var btnConfirm: UIButton!
    /** Button Tap Confirm Button */
    @IBAction func btnConfirmTapped(_ sender: Any) {
        requestUpdate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = true
        //Create title
        self.createNavigationBar(title: "Xác nhận STT")
        // Id
        _app_order_id = BaseModel.shared.sharedString
        //Custom Button
        btnConfirm.layer.cornerRadius = CGFloat(G18Const.CORNER_RADIUS_BUTTON)
        //tbl Stock
        tblStock.dataSource = self
        tblStock.delegate = self
        tblStock.estimatedRowHeight = CGFloat(G18Const.ESTIMATE_ROW_HEIGHT)
        tblStock.rowHeight = UITableViewAutomaticDimension
        //request data
        requestData()
        // Gesture
        _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
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
    
    //++request update
    /**
     * Request data from server
     */
    internal func requestData() {
        requestData(completionHandler: finishRequest)
    }
    
    private func requestData(completionHandler: ((Any?)->Void)?) {
        StockRealViewRequest.request(view: self, app_order_id: _app_order_id, completionHandler: completionHandler)
        tblStock.reloadData()
    }
    override func finishRequest(_ model: Any?) {
        let data = model as! String
        let model = StockResponseModel(jsonString: data)
        if model.isSuccess() {
            _data = model
            lblCustomerName.text = _data.record.customer_name
            lblDeliveriedDate.text = _data.record.date_delivery
            if _data.record.allow_update == "0" {
                btnConfirm.isUserInteractionEnabled = false
                btnConfirm.backgroundColor = UIColor.gray
            }
            _dataStock = model.record.stock 
            tblStock.reloadData()
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
                jsonStock.append(item.createJsonDataForReal())
            }
        }
        StockRealUpdateRequest.request(view: self, app_order_id: _app_order_id, record: jsonStock.joined(separator: DomainConst.SPLITER_TYPE2), completionHandler: completionHandler)
    }
    
    func finishRequestUpdate(_ model: Any?) {
        let data = model as! String
        let model = StockResponseModel(jsonString: data)
        if model.isSuccess() {
            showAlert(message: G18Const.MESSAGE_CONFIRM_STOCK_SUCCESS,
                      okHandler: {
                        alert in
                        self.backButtonTapped(self)
                        //G08F00S02VC._id = model.record.id
                        /*self.pushToView(name: G18F00S01VC.theClassName)*/})
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    //--request update
}
extension G18F00S03VC: TextChangeDelegte{
    func UpdateSeri(seri: String, index: Int) {
        _dataStock[index].seri_real = seri
    }
    func didBeginEdit(){
        _isKeyboardShow = true
        self.view.addGestureRecognizer(_gestureHideKeyboard)
    }
}
// MARK: Protocol - UITableViewDataSource
extension G18F00S03VC: UITableViewDataSource{
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
            cell.lblNo.text    = _dataStock[indexPath.row].seri
            cell.tfNo.text     = _dataStock[indexPath.row].seri_real
            cell.delegate = self
            cell.index = indexPath.row
            return cell
            
    }
}



// MARK: - UITableViewDataSource-Delegate
extension G18F00S03VC: UITableViewDelegate {    
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
