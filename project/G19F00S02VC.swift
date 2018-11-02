//
//  G19F00S02VC.swift
//  project
//
//  Created by SPJ on 9/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class G19F00S02VC: BaseChildViewController {
    /** id */
    internal var _id:                String              = DomainConst.BLANK
    @IBOutlet weak var tblCMS: UITableView!
    /** Data CMS List*/
    internal var _data: CMSListResModel    = CMSListResModel()
    internal var _dataCMS: [CMSListBean]   = [CMSListBean]()
    /** Page number */
    internal var _page:                 Int                 = 0
    /** Refrest control */
    lazy var refreshControl:            UIRefreshControl    = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar(title: BaseModel.shared.sharedTitle)
        // Id
        _id = BaseModel.shared.sharedString
        //table view
        tblCMS.delegate = self
        tblCMS.dataSource = self
        tblCMS.estimatedRowHeight      = 70
        tblCMS.rowHeight               = UITableViewAutomaticDimension
        tblCMS.addSubview(refreshControl)
        requestCMSList()

    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        _page = 0
         requestCMSData(completionHandler: finishHandleRefresh(_:))
      
        //        requestCMSData(completionHandler: finishHandleRefresh(_:))
    }
    
    internal func finishHandleRefresh(_ model: Any?) {
        finishRequest(model)
        //-- BUG0082-SPJ (NguyenPT 20170510) Change BaseRequest handle completion mechanism
        refreshControl.endRefreshing()
    }
    
        internal func requestCMSList(){
            requestCMSData(completionHandler: finishRequestCMSList)
        }
        
        private func requestCMSData(completionHandler: ((Any?)->Void)?) {
            //CategoryListRequest.request(view: self, completionHandler: completionHandler)
            CMSListRequest.request(view: self, categoryId: _id, page: String(_page), completionHandler: completionHandler)
        }
        
        public func finishRequestCMSList(_ model: Any?) {
            let data = model as! String
            let model = CMSListResModel(jsonString: data)
            _data.record.removeAll()
            if model.isSuccess() {
                _data.total_page    = model.total_page
                _data.total_record  = model.total_record
                _data.append(contentOf: model.getRecord() as! [CMSListBean])
                _dataCMS = _data.getRecord() as! [CMSListBean]
                tblCMS.reloadData()
                //tblList.reloadData()
            }
                //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
            else {
                showAlert(message: model.message)
            }
            //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
        }
    
    /**
     * Handle go to detail screen
     * - parameter id: id of Customer Request
     */
    internal func openDetail(id: String) {
        BaseModel.shared.sharedString = id
        self.pushToView(name: G19F00S03VC.theClassName)
        
    }
}
// MARK: Protocol - UITableViewDataSource
extension G19F00S02VC: UITableViewDataSource{
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _dataCMS.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell: CMSCell = tableView.dequeueReusableCell(
                withIdentifier: "CMSCell1")
                as! CMSCell
            // Set image
//            let img = ImageManager.getImage(named: DomainConst.REPORT_SUM_ICON_IMG_NAME)
//            let tinted = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//            cell.img?.image = tinted
//            cell.img?.tintColor = GlobalConst.MAIN_COLOR
            //cell.img
            cell.lb_cms_name.text = _dataCMS[indexPath.row].title
            cell.lblCreatedDate.text = _dataCMS[indexPath.row].created_date
            cell.lblShortContent.text = _dataCMS[indexPath.row].short_content
            return cell
    }
}
// MARK: - UITableViewDataSource-Delegate
extension G19F00S02VC: UITableViewDelegate {    
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

        if self._dataCMS.count > indexPath.row {
            //self.openDetail(id: self._dataCMS[indexPath.row].id)
            //self.openDetail(id: self._dataCMS[indexPath.row].link_web)
//            BaseModel.shared.sharedTitleNotify = self._dataCMS[indexPath.row].title
            openDetail(id: self._dataCMS[indexPath.row].id)
            
        }
    }
}
