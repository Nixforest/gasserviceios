//
//  G02F00S02VC.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class G02F00S02VC: ChildExtViewController {
    // MARK: Properties
    /** Present data */
    var _data:          IssueViewRespBean           = IssueViewRespBean()
    /** List of information data */
    var _listInfo:      [ConfigurationModel]        = [ConfigurationModel]()
    /** Id */
    var _id:            String                      = DomainConst.BLANK
    /** Information table view */
    var _tblInfo:       UITableView                 = UITableView()
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Static values
    // MARK: Constant
    var HEADER_HEIGHT:      CGFloat = GlobalConst.LABEL_H * 2
    var SECTION_INFO:       Int     = 1
    var SECTION_HISTORY:    Int     = 0

    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00573)
        createInfoTableView()
        self.view.addSubview(_tblInfo)
        
        // Request data from server
        requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestData(action: #selector(setData(_:)), isShowLoading: false)
    }
    
    /**
     * Set data for this view controller
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = IssueViewRespBean(jsonString: data)
        // Success response
        if model.isSuccess() {
            _data = model
            setupListInfo()
            _tblInfo.reloadData()
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
        _tblInfo.addSubview(refreshControl)
        _tblInfo.dataSource = self
        _tblInfo.delegate = self
    }
    
    // MARK: Request server
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:)), isShowLoading: Bool = true) {
        if !self._id.isEmpty {
            IssueViewRequest.request(action: action, view: self, id: self._id,
                                     isShowLoading: isShowLoading)
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
    
    // MARK: Logic
    /**
     * Set init data for this screen
     * - parameter id: Id of order
     */
    public func setData(id: String) {
        self._id = id
    }
    
    /**
     * Set update data for first list infor
     */
    private func setupListInfo() {
        _listInfo.removeAll()
        // Code no
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_ID_ID,
            name: DomainConst.CONTENT00568,
            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
            value: _data.model_issue.code_no))
        
        // Status
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_STATUS_ID,
            name: DomainConst.CONTENT00569,
            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
            value: _data.model_issue.status_text))
        
        // Problem
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_PROBLEM_ID,
            name: DomainConst.CONTENT00574,
            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
            value: _data.model_issue.problem_text))
        
        // Title
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_NOTE_ID,
            name: DomainConst.CONTENT00566,
            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
            value: _data.model_issue.name))
        
        // Name
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CUSTOMER_NAME_ID,
            name: DomainConst.CONTENT00079,
            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
            value: _data.model_issue.customer_name))
        
        // Address
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_ADDRESS_ID,
            name: DomainConst.CONTENT00565,
            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
            value: _data.model_issue.customer_address))
        
        // Phone
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_PHONE_ID,
            name: DomainConst.CONTENT00054,
            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
            value: _data.model_issue.customer_phone))
        
        // Contact
        if !_data.model_issue.contact_person.isEmpty {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_CONTACT_ID,
                name: DomainConst.CONTENT00570,
                iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
                value: _data.model_issue.contact_person))
        }
        
        // Sale
        if !_data.model_issue.sale_name.isEmpty {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_SALE_ID,
                name: DomainConst.CONTENT00571,
                iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
                value: _data.model_issue.sale_name))
        }
        
        // Created by
        if !_data.model_issue.created_by.isEmpty {
            _listInfo.append(ConfigurationModel(
                id: DomainConst.ORDER_INFO_CREATED_BY_ID,
                name: DomainConst.CONTENT00572,
                iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
                value: _data.model_issue.created_by))
        }
        
        // Created date
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CREATED_DATE_ID,
            name: DomainConst.CONTENT00567,
            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
            value: _data.model_issue.created_date))
    }
    
    /**
     * Open reply item screen
     * - parameter bean: Issue reply bean
     */
    internal func openReplyItem(bean: IssueReplyBean) {
        let view = G02F00S03VC(nibName: G02F00S03VC.theClassName, bundle: nil)
        view.setData(data: bean)
        view.setMode(mode: G02F00S03VC.MODE_VIEW)
        view.createNavigationBar(title: bean.created_date)
        self.push(view, animated: true)
    }
    
    /**
     * Open create reply screen
     */
    internal func openReplyCreate() {
        let view = G02F00S03VC(nibName: G02F00S03VC.theClassName, bundle: nil)
        view.createNavigationBar(title: DomainConst.CONTENT00577)
        view.setMode(mode: G02F00S03VC.MODE_REPY, id: self._id)
        self.push(view, animated: true)
    }
}

// MARK: Protocol - UITableViewDataSource
extension G02F00S02VC: UITableViewDataSource {
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
        case SECTION_INFO:
            return _listInfo.count
        case SECTION_HISTORY:
            return _data.model_issue.reply_item.count
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
        case SECTION_INFO:
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
        case SECTION_HISTORY:
            if indexPath.row > self._data.model_issue.reply_item.count {
                return UITableViewCell()
            }
            let data = self._data.model_issue.reply_item[indexPath.row]
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.text = "\(data.created_date) - \(data.created_by)"
            cell.textLabel?.font = GlobalConst.BASE_BOLD_FONT
            cell.detailTextLabel?.text = data.name
            cell.detailTextLabel?.font = GlobalConst.BASE_FONT
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            cell.detailTextLabel?.numberOfLines = 0
            return cell
        default:
            break
        }
          return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CustomerInfoHeaderView.init(
            frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: HEADER_HEIGHT))
        switch section {
        case SECTION_INFO:
            header.setHeader(bean: ConfigBean.init(id: String(section), name: DomainConst.CONTENT00072),
                             actionText: DomainConst.BLANK)
        case SECTION_HISTORY:
            header.setHeader(bean: ConfigBean.init(id: String(section), name: DomainConst.CONTENT00575),
                             actionText: DomainConst.CONTENT00578)
        default:
            break
        }
        
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HEADER_HEIGHT
    }
}

// MARK: Protocol - UITableViewDelegate
extension G02F00S02VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case SECTION_INFO:
            return
        case SECTION_HISTORY:
            self.openReplyItem(bean: self._data.model_issue.reply_item[indexPath.row])
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
}

// MARK: Protocol - CustomerInfoHeaderViewDelegate
extension G02F00S02VC: CustomerInfoHeaderViewDelegate {    
    func customerInfoHeaderViewDidSelect(object: ConfigBean) {
        switch object.id {
        case String(SECTION_INFO):
            break
        case String(SECTION_HISTORY):
            self.openReplyCreate()
        default:
            break
        }
    }
}
