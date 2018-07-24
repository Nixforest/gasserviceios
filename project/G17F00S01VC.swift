//
//  G17F00S01VC.swift
//  project
//
//  Created by SPJ on 7/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework   
import Alamofire

class G17F00S01VC: BaseParentViewController {

    @IBOutlet weak var tblList: UITableView!
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Data */
    internal var _data:              CustomerRequestListResponseModel  = CustomerRequestListResponseModel()
    /** Page number */
    internal var _page:              Int                     = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.createNavigationBar(title: DomainConst.CONTENT00583)
        // Add search button to navigation bar
        // Add Add button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.QUICK_ACTION_ICON_IMG_NAME,
                                       action: #selector(actionTapped(_:)), target: self)
        tblList.estimatedRowHeight = 400
        tblList.rowHeight = UITableViewAutomaticDimension
        tblList.dataSource = self
        tblList.delegate = self
        tblList.addSubview(refreshControl)
        requestData()
        
    }

    // MARK: Methods
    
    
    private func requestData(completionHandler: ((Any?)->Void)?) {
        //        OrderFamilyListRequest.request(action: action,
        //                                       view: self,
        //                                       page: String(_page),
        //                                       status: status)
        CustomerRequestListRequest.request(view: self, page: String(_page),
                                           completionHandler: completionHandler)
    }
    /**
     * Request data from server
     */
    internal func requestData() {
        requestData(completionHandler: finishRequest)
    }
    
    
    override func finishRequest(_ model: Any?) {
        let data = model as! String
        let model = CustomerRequestListResponseModel(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
            tblList.reloadData()
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    
    
    /**
     * Reset data
     */
    private func resetData() {
        _data.clearData()
        // Reset current search value
        self._page      = 0
        // Reload table
        tblList.reloadData()
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        self.resetData()
        requestData(completionHandler: finishHandleRefresh(_:))
    }
    
    /**
     * Handle finish refresh
     */
    //++ BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
    //internal func finishHandleRefresh(_ notification: Notification) {
    //setData(notification)
    internal func finishHandleRefresh(_ model: Any?) {
        finishRequest(model)
        //-- BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
        refreshControl.endRefreshing()
    }
    
    /**
     * Handle finish refresh
     */
    /*internal func finishHandleRefresh(_ notification: Notification) {
        setData(notification)
        refreshControl.endRefreshing()
    }*/
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Logic
    /**
     * Handle tap on add button
     * - parameter sender: AnyObject
     */
    internal func actionTapped(_ sender: AnyObject) {
        BaseViewController.getCurrentViewController()?.pushToViewAndClearData(name: "G17F00S03VC")
    }
    
    // MARK: Logic
    internal func openDetail(id: String) {
        BaseModel.shared.sharedString = id
        self.pushToView(name: G17F00S02VC.theClassName)
        
    }
}
    // MARK: Protocol - UITableViewDataSource
    extension G17F00S01VC: UITableViewDataSource{
        /**
         * Tells the data source to return the number of rows in a given section of a table view.
         */
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return self._data.getRecord().count
        }
        
        /**
         * Asks the data source for a cell to insert in a particular location of the table view.
         */
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
            UITableViewCell {
                let cell: CustomerRequestCell = tableView.dequeueReusableCell(
                    withIdentifier: "CustomerRequestCell")
                    as! CustomerRequestCell
                //ell?.textLabel?.text           = _data.getRecord()[indexPath.row].code_no
                //cell.lblName.text = "Khoi"
                cell.lblCode.text = self._data.getRecord()[indexPath.row].code_no
                cell.lblName.text = self._data.getRecord()[indexPath.row].first_name
                cell.lblDate.text = "🗓\(self._data.getRecord()[indexPath.row].created_date)"
                cell.lblAddress.text = "🏚\(self._data.getRecord()[indexPath.row].address)"
                if _data.getRecord()[indexPath.row].note != ""{
                    cell.lblNote.text = "📔\(self._data.getRecord()[indexPath.row].note)"
                }
                switch self._data.getRecord()[indexPath.row].status{
                case "1" :
                    cell.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_NEW_ICON_IMG_NAME)
                    break
                case "2" :
                    cell.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_PROCESS_ICON_IMG_NAME)
                    break
                case "3" : 
                    cell.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_APPROVE_ICON_IMG_NAME)
                    break
                case "4" :
                    cell.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_CANCEL_ICON_IMG_NAME)
                    break
                default :
                    cell.imgStatus.image = ImageManager.getImage(named: DomainConst.ORDER_STATUS_NEW_ICON_IMG_NAME)
                    break
                }
                
                return cell
                
        }
    }
    // MARK: - UITableViewDataSource-Delegate
extension G17F00S01VC: UITableViewDelegate {    
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
        if _data.total_page != 1 {
            let lastElement = _data.getRecord().count - 1
            // Current is the last element
            if indexPath.row == lastElement {
                self._page += 1
                // Page less than total page
                if self._page <= _data.total_page {
                    self.requestData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self._data.getRecord().count > indexPath.row {
            self.openDetail(id: self._data.getRecord()[indexPath.row].id)
        }
    }
}
    
    
    
    


    
   
     
     
     
     
     

