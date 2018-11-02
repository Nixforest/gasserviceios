//
//  G19F00S01VC.swift
//  project
//
//  Created by SPJ on 9/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework
class G19F00S01VC: BaseParentViewController {
    
    //@IBOutlet weak var lblCategoryName: UILabel!
    
    @IBOutlet weak var tblCMS: UITableView!
    
    /** Refrest control */
    lazy var refreshControl:            UIRefreshControl    = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    /** Data Category*/
    internal var _dataCategory: CategoryListResModel    = CategoryListResModel()
    /** Data CMS List*/
    internal var _data: CMSListResModel    = CMSListResModel()
    internal var _dataCMS: [CMSListBean]   = [CMSListBean]()
    internal var _categoryId: String    = DomainConst.BLANK
    /** Page number */
    internal var _page:                 Int                 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar(title: DomainConst.CONTENT00594)
        // Add Search button to navigation bar
//        self.createRightNavigationItem(icon: DomainConst.SEARCH_ICON_IMG_NAME,
//                                       action: #selector(searchButtonTapped(_:)), target: self)
        
        //table view
        tblCMS.delegate = self
        tblCMS.dataSource = self
        tblCMS.estimatedRowHeight      = 70
        tblCMS.rowHeight               = UITableViewAutomaticDimension
        tblCMS.addSubview(refreshControl)
        //request Category List
        requestCategoryList()
    }

    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        requestCategoryData(completionHandler: finishHandleRefresh)
//        _page = 0
//        requestCMSData(completionHandler: finishHandleRefresh(_:))
    }
    
    internal func finishHandleRefresh(_ model: Any?) {
        finishRequest(model)
        //-- BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
        refreshControl.endRefreshing()
    }
    
//    internal func requestCMSList(){
//        requestCMSData(completionHandler: finishRequestCMSList)
//    }
//    
//    private func requestCMSData(completionHandler: ((Any?)->Void)?) {
//        //CategoryListRequest.request(view: self, completionHandler: completionHandler)
//        CMSListRequest.request(view: self, categoryId: _categoryId, page: String(_page), completionHandler: completionHandler)
//    }
//    
//    public func finishRequestCMSList(_ model: Any?) {
//        let data = model as! String
//        let model = CMSListResModel(jsonString: data)
//        _data.record.removeAll()
//        if model.isSuccess() {
//            _data.total_page    = model.total_page
//            _data.total_record  = model.total_record
//            _data.append(contentOf: model.getRecord() as! [CMSListBean])
//            _dataCMS = _data.getRecord() as! [CMSListBean]
//            tblCMS.reloadData()
//            //tblList.reloadData()
//        }
//            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
//        else {
//            showAlert(message: model.message)
//        }
//        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
//    }
    internal func requestCategoryList(){
        requestCategoryData(completionHandler: finishRequest)
    }
    
    private func requestCategoryData(completionHandler: ((Any?)->Void)?) {
        CategoryListRequest.request(view: self, completionHandler: completionHandler)
    }
    
    public override func finishRequest(_ model: Any?) {
        let data = model as! String
        let model = CategoryListResModel(jsonString: data)
        _dataCategory.record.removeAll()
        if model.isSuccess() {
            _dataCategory.total_page    = model.total_page
            _dataCategory.total_record  = model.total_record
            _dataCategory.append(contentOf: model.getRecord())
            tblCMS.reloadData()
//            if  _dataCategory.getRecord().count > 0{
//                _categoryId = _dataCategory.getRecord()[0].id
//                lblCategoryName.text = _dataCategory.getRecord()[0].name
//                requestCMSList()
//            }
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    /**
     * Handle tap on Search button
     * - parameter sender: AnyObject
     */
//    internal func searchButtonTapped(_ sender: AnyObject) {
//        // Show alert
//        let alert = UIAlertController(title: DomainConst.CONTENT00594,
//                                      message: DomainConst.CONTENT00595,
//                                      preferredStyle: .actionSheet)
//        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
//                                   style: .cancel,
//                                   handler: nil)
//        alert.addAction(cancel)
//        for item in _dataCategory.getRecord() {
//            let action = UIAlertAction(title: item.name,
//                                       style: .default, handler: {
//                                        action in
//                                        if item.id != self._categoryId{
//                                        self._categoryId = item.id
//                                        self.lblCategoryName.text = item.name
//                                        self._page = 0
//                                        self.requestCMSList()
////                                        self.handleCancelOrder(id: item.id)
//                                        }
//            })
//            alert.addAction(action)
//        }
//        if let presenter = alert.popoverPresentationController {
//            presenter.sourceView = sender as! UIButton
//            presenter.sourceRect = sender.bounds
//        }
//        self.present(alert, animated: true, completion: nil)
//    }
    
    /**
     * Handle go to detail screen
     * - parameter id: id of Customer Request
     */
    internal func openDetail(id: String, title : String) {
        BaseModel.shared.sharedString = id
        BaseModel.shared.sharedTitle = title
        self.pushToView(name: G19F00S02VC.theClassName)
        
    }
}

// MARK: Protocol - UITableViewDataSource
extension G19F00S01VC: UITableViewDataSource{
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _dataCategory.getRecord().count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell: CMSCell = tableView.dequeueReusableCell(
                    withIdentifier: "CMSCell")
                    as! CMSCell
            // Set image
            let img = ImageManager.getImage(named: DomainConst.REPORT_SUM_ICON_IMG_NAME)
            let tinted = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            cell.img?.image = tinted
            cell.img?.tintColor = GlobalConst.MAIN_COLOR
                //cell.img
            cell.lb_cms_name.text = _dataCategory.getRecord()[indexPath.row].name
            return cell
    }
}
// MARK: - UITableViewDataSource-Delegate
extension G19F00S01VC: UITableViewDelegate {    
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
//            if _dataCategory.getRecord().total_page != 1 {
//                let lastElement = _data.getRecord().count - 1
//                // Current is the last element
//                if indexPath.row == lastElement {
//                    self._page += 1
//                    // Page less than total page
//                    if self._page <= _data.total_page {
//                        requestCMSList()
//                        //requestDataForSearch(completionHandler: finishRequest)
//                    }
//                }
//            }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView == tblSearch {
//            _searchActive       = false
//            tblSearch.isHidden  = !_searchActive
//            _searchbar.resignFirstResponder()
//            _customerId         = _dataCustomer[indexPath.row].id
//            _searchbar.text     = _dataCustomer[indexPath.row].name
//            _data.clearData()
//            requestDataForSearch()
//            
//        }else if tableView == tblList{
//            if self._data.getRecord().count > indexPath.row {
//                self.openDetail(id: self._data.getRecord()[indexPath.row].id)
//            }
//        }
        if self._dataCategory.getRecord().count > indexPath.row {
            self.openDetail(id: self._dataCategory.getRecord()[indexPath.row].id, title: self._dataCategory.getRecord()[indexPath.row].name)
        }
    }
}
