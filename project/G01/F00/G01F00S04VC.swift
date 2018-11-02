//
//  G01F00S04VC.swift
//  project
//
//  Created by SPJ on 6/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F00S04VC: ParentViewController, UITableViewDataSource, UITableViewDelegate, OrderConfirmDelegate {
    // MARK: Properties
    /** Summary information label */
    private var _lblSum:            UILabel                 = UILabel()
    /** Segment button */
    private var _segment:           UISegmentedControl      = UISegmentedControl(
        items: [
            DomainConst.CONTENT00074,
            DomainConst.CONTENT00311
        ])
    /** Type: New (1) or Finish (2) */
    private var _type:              Int                     = 1
    /** Static data */
    private var _data:              FamilyUpholdListRespModel   = FamilyUpholdListRespModel()
    /** Current page */
    private var _page:              Int                     = 0
    /** Table view */
    private var _tblView:           UITableView             = UITableView()
    /** Current selected index */
    private var _currentId:         String                  = DomainConst.BLANK
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Utility methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        FamilyUpholdListRequest.request(action: action,
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
        createNavigationBar(title: DomainConst.CONTENT00420)
        var offset: CGFloat = getTopHeight()
        
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
        _tblView.register(UINib(nibName: G01F00S04Cell.theClassName, bundle: nil), forCellReuseIdentifier: G01F00S04Cell.theClassName)
        _tblView.delegate = self
        _tblView.dataSource = self
        _tblView.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT - offset)
        _tblView.addSubview(refreshControl)
        self.view.addSubview(_tblView)
        
        // Request data from server
        requestData()
        self.view.makeComponentsColor()
    }
    
    /**
     * Set data for this view controller
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = FamilyUpholdListRespModel(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
            _lblSum.text = model.message
            self._tblView.reloadData()
        } else {
            showAlert(message: model.message)
        }
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
            let cell: G01F00S04Cell = tableView.dequeueReusableCell(
                withIdentifier: G01F00S04Cell.theClassName)
                as! G01F00S04Cell
            if _data.getRecord().count > indexPath.row {
                cell.setData(data: _data.getRecord()[indexPath.row])
                cell.delegate = self
            }
            return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return G01F00S04Cell.CELL_HEIGHT
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
        G01F00S05VC._id = _data.getRecord()[indexPath.row].id
        self.pushToView(name: G01F00S05VC.theClassName)
    }
    
    /**
     * Handle tapped event on action button
     */
    public func btnActionTapped(_ sender: AnyObject) {
        _currentId = (sender as! UIButton).accessibilityIdentifier!
        FamilyUpholdUpdateRequest.request(
            action: #selector(finishConfirmHandler(_:)),
            view: self,
            actionType: FamilyUpholdStatusEnum.STATUS_CONFIRM.rawValue,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: _currentId,
            note: DomainConst.BLANK)
    }
    
    /**
     * Handle tapped event on cancel button
     */
    public func btnCancelTapped(_ sender: AnyObject) {
        _currentId = (sender as! UIButton).accessibilityIdentifier!
        FamilyUpholdUpdateRequest.request(
            action: #selector(finishCancelConfirmHandler(_:)),
            view: self,
            actionType: FamilyUpholdStatusEnum.STATUS_UNCONFIRM.rawValue,
            lat: String(MapViewController._originPos.latitude),
            long: String(MapViewController._originPos.longitude),
            id: _currentId,
            note: DomainConst.BLANK)
    }
    
    /**
     * Handle finish confirm
     */
    internal func finishConfirmHandler(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            self.handleRefresh(self)
            // Move to detail
            G01F00S05VC._id = _currentId
            self.pushToView(name: G01F00S05VC.theClassName)
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle finish cancel confirm
     */
    internal func finishCancelConfirmHandler(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            self.handleRefresh(self)
        } else {
            showAlert(message: model.message)
        }
    }
}
