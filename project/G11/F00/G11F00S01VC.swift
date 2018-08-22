//
//  G11F00S01VC.swift
//  project
//
//  Created by SPJ on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G11F00S01VC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Summary information label */
    private var _lblSum:            UILabel                 = UILabel()
    /** Segment button */
    private var _segment:           UISegmentedControl              = UISegmentedControl(
        items: [
            DomainConst.CONTENT00067,
            DomainConst.CONTENT00068
        ])
    /** Static data */
    private var _data:              TicketListRespModel   = TicketListRespModel()
    /** Current page */
    private var _page:              Int                     = 0
    /** Table view */
    private var _tblView:           UITableView             = UITableView()
    /** Type: Close (1) or Close (2) */
    private var _type:              Int                     = 1
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Bottom view */
    /*private var _bottomView:        UIView                      = UIView()*/
    /** Height of bottom view */
    //private let bottomHeight:       CGFloat                     = 2 * (GlobalConst.BUTTON_H + GlobalConst.MARGIN)
    
    // MARK: Utility methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        TicketListRequest.request(action: action,
                                        view: self,
                                        page: String(_page),
                                        type: String(_type))
    }
    
    /**
     * Reset data
     */
    private func resetData() {
        _data.clearData()
        // Reset current search value
        self._page      = 0
        // Reload table
        _tblView.reloadData()
    }
    
    // MARK: Handle events
    /**
     * Handle when tap on info button
     */
    internal func btnInfoTapped(_ sender: AnyObject) {
        showAlert(message: _data.message)
    }
    
    /**
     * Handle when tap on create button
     */
    internal func btnCreateTapped(_ sender: AnyObject) {
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
        //++ BUG0202-SPJ (KhoiVT 20180818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
        /*if BaseModel.shared.getRoleId() == "4"{
            self.handleCreateTicket(id: "")
        }  
        else{
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
                presenter.sourceView = self._bottomView
                presenter.sourceRect = self._bottomView.bounds
            }
            self.present(alert, animated: true, completion: nil)
        }*/
        //BaseModel.shared.sharedString = id
        self.pushToView(name: G11F00S03VC.theClassName)
        //-- BUG0202-SPJ (KhoiVT 20180818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
    }
    
    /**
     * Open create ticket view controller
     * - parameter id: Id of ticket handler
     */
    internal func handleCreateTicket() {
        //++ BUG0202-SPJ (KhoiVT 20180818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
        //G11F01VC._handlerId = id
        self.pushToView(name: G11F00S03VC.theClassName)
        //-- BUG0202-SPJ (KhoiVT 20180818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
        
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        self.resetData()
        requestData(action: #selector(finishHandleRefresh(_:)))
    }
    
    /**
     * Handle finish refresh
     */
    internal func finishHandleRefresh(_ notification: Notification) {
        setData(notification)
        refreshControl.endRefreshing()
    }
    
    /**
     * Handle change value of segment
     */
    internal func segmentChange(_ sender: AnyObject) {
        _type = _segment.selectedSegmentIndex + 1
        resetData()
        requestData()
    }
    
    // MARK: Override from UIViewController
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00424)
        var offset: CGFloat = getTopHeight()
        
//        // Summary information label
//        _lblSum.frame = CGRect(x: 0, y: offset,
//                               width: GlobalConst.SCREEN_WIDTH,
//                               height: GlobalConst.LABEL_H * 7)
//        _lblSum.text = "ABC"//DomainConst.BLANK
//        _lblSum.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
//        _lblSum.textColor = GlobalConst.BUTTON_COLOR_RED
//        _lblSum.textAlignment = .left
//        _lblSum.lineBreakMode = .byWordWrapping
//        _lblSum.numberOfLines = 0
//        self.view.addSubview(_lblSum)
//        offset = offset + _lblSum.frame.height
        
        // Segment
        let font = UIFont.systemFont(ofSize: GlobalConst.BASE_FONT_SIZE)
        _segment.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.BUTTON_H)
        _segment.setTitleTextAttributes([NSFontAttributeName: font],
                                        for: UIControlState())
        _segment.selectedSegmentIndex = 0
        _segment.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        _segment.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        _segment.tintColor = GlobalConst.BUTTON_COLOR_RED
        _segment.addTarget(self, action: #selector(segmentChange(_:)), for: .valueChanged)
        offset = offset + _segment.frame.height
        self.view.addSubview(_segment)
        
        // Table View
        _tblView.register(UINib(nibName: G11F00S01Cell.theClassName, bundle: nil), forCellReuseIdentifier: G11F00S01Cell.theClassName)
        _tblView.delegate = self
        _tblView.dataSource = self
        _tblView.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT)
        _tblView.addSubview(refreshControl)
        self.view.addSubview(_tblView)
        
        // Bottom view
        /*_bottomView.frame = CGRect(x: 0, y: GlobalConst.SCREEN_HEIGHT - bottomHeight,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: bottomHeight)
        //_bottomView.isHidden = true
        self.view.addSubview(_bottomView)*/
        //createBottomView()
        // Request data from server
        requestData()
        self.view.makeComponentsColor()
        
        self.createRightNavigationItem(icon: DomainConst.ADD_MATERIAL_ICON_IMG_NAME,
                                       action: #selector(actionButtonTapped(_:)), target: self)
    }
    
    /**
     * Handle tap on Search button
     * - parameter sender: AnyObject
     */
    internal func actionButtonTapped(_ sender: AnyObject) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00437,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        let createTicket = UIAlertAction(title: "Tạo Ticket",
                                        style: .default, handler: {
                                            action in
                                            self.requestCreateTicket()
        })
        let supportInfo = UIAlertAction(title: "Thông tin hỗ trợ",
                                         style: .default, handler: {
                                            action in
                                            self.showAlert(message: self._data.message)
        })
        alert.addAction(cancel)
        alert.addAction(createTicket)
        alert.addAction(supportInfo)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = sender as! UIButton
            presenter.sourceRect = sender.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle when tap on create ticket action
     */
    internal func requestCreateTicket() {
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
     * Create bottom view
     */
    /*private func createBottomView() {
        var botOffset: CGFloat = 0.0
        // Create Information button
        let btnInfo = UIButton()
        CommonProcess.createButtonLayout(
            btn: btnInfo, x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2, y: botOffset,
            text: DomainConst.CONTENT00425, action: #selector(btnInfoTapped(_:)), target: self,
            img: DomainConst.SUPPORT_INFO_ICON_IMG_NAME, tintedColor: UIColor.white)
        
        btnInfo.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                               left: GlobalConst.MARGIN,
                                               bottom: GlobalConst.MARGIN,
                                               right: GlobalConst.MARGIN)
        botOffset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        _bottomView.addSubview(btnInfo)
        
        // Create Create button
        let btnCreate = UIButton()
        CommonProcess.createButtonLayout(
            btn: btnCreate, x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2, y: botOffset,
            text: DomainConst.CONTENT00402, action: #selector(btnCreateTapped(_:)), target: self,
            img: DomainConst.ADD_ICON_IMG_NAME, tintedColor: UIColor.white)
        
        btnCreate.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                               left: GlobalConst.MARGIN,
                                               bottom: GlobalConst.MARGIN,
                                               right: GlobalConst.MARGIN)
        botOffset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        _bottomView.addSubview(btnInfo)
        _bottomView.addSubview(btnCreate)
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Set data for this view controller
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = TicketListRespModel(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
            _data.message = model.message
            self._tblView.reloadData()
        } else {
            showAlert(message: model.message)
        }
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
        return _data.getRecord().count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell: G11F00S01Cell = tableView.dequeueReusableCell(
                withIdentifier: G11F00S01Cell.theClassName)
                as! G11F00S01Cell
            if _data.getRecord().count > indexPath.row {
                //++ BUG0148-SPJ (NguyenPT 20170817) Change icon of Ticket closed status
                //cell.setData(data: _data.getRecord()[indexPath.row])
                cell.setData(data: _data.getRecord()[indexPath.row], isClosed: self._type != 1)
                //-- BUG0148-SPJ (NguyenPT 20170817) Change icon of Ticket closed status
            }
            return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return G11F00S01Cell.CELL_HEIGHT
    }
    
    /**
     * Tells the delegate the table view is about to draw a cell for a particular row.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Total page does not 1
        if self._data.total_page != 1 {
            let lastElement = self._data.getRecord().count - 1
            // Current is the last element
            if indexPath.row == lastElement {
                self._page += 1
                // Page less than total page
                if self._page <= self._data.total_page {
                    requestData()
                }
            }
        }
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        G11F00S02VC._id = _data.getRecord()[indexPath.row].id
        self.pushToView(name: G11F00S02VC.theClassName)
    }
}
