//
//  G06F00S04VC.swift
//  project
//
//  Created by SPJ on 3/29/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F00S04VC: ParentViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    // MARK: Properties
    /** Table view */
    @IBOutlet weak var _tableView:      UITableView!
    /** Icon image */
    @IBOutlet weak var iconImg:         UIImageView!
    /** Static data */
    private static var _data:           WorkingReportListRespModel = WorkingReportListRespModel()
    /** Current page */
    private var _page = 0
    /** From date value */
    private var _fromDate:              String = CommonProcess.getFirstDateOfMonth(date: Date())
    /** To date value */
    private var _toDate:                String = CommonProcess.getCurrentDate()
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Search view */
    private var _viewSearch:            UIView = UIView()
    /** Search input view */
    private var _viewInput:             UIView = UIView()
    /** Date label */
    private var _lblFromDate:           UILabel = UILabel()
    /** Date textfield */
    private var _txtFromDate:           UITextField = UITextField()
    /** Date label */
    private var _lblToDate:             UILabel = UILabel()
    /** Date textfield */
    private var _txtToDate:             UITextField = UITextField()
    
    // MARK: Methods
    /**
     * Reset data
     */
    private func resetData() {
        // Reset record
        G06F00S04VC._data.clearData()
        // Reset current search value
        self._page      = 0
        self._fromDate  = CommonProcess.getFirstDateOfMonth(date: Date())
        self._toDate    = CommonProcess.getCurrentDate()
        // Reload table
        _tableView.reloadData()
    }
    
    /**
     * Update data
     */
    private func updateData(model: WorkingReportListRespModel) {
        if model.isSuccess() {
            G06F00S04VC._data.total_page    = model.total_page
            G06F00S04VC._data.total_record  = model.total_record
            G06F00S04VC._data.append(contentOf: model.getRecord())
            _tableView.reloadData()
        }
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        self.resetData()
        WorkingReportListRequest.request(action: #selector(finishHandleRefresh(_:)),
                                          view: self,
                                          dateFrom: self._fromDate,
                                          dateTo: self._toDate,
                                          page: String(self._page))
    }
    
    /**
     * Finish handler after run request
     */
    internal func finishHandleRefresh(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = WorkingReportListRespModel(jsonString: data)
        G06F00S04VC._data.clearData()
        self.updateData(model: model)
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        createNavigationBar(title: DomainConst.CONTENT00295)
        
        var offset: CGFloat = self.getTopHeight()
        if BaseModel.shared.getDebugShowTopIconFlag() {
            iconImg.image = ImageManager.getImage(named: DomainConst.ORDER_ICON_IMG_NAME)
            iconImg.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W / 2) / 2,
                                   y: offset,
                                   width: GlobalConst.LOGIN_LOGO_W / 2,
                                   height: GlobalConst.LOGIN_LOGO_H / 2)
            iconImg.translatesAutoresizingMaskIntoConstraints = true
            offset += iconImg.frame.height
            iconImg.isHidden = false
            self.view.addSubview(iconImg)
        } else {
            iconImg.isHidden = true
        }
        
        // Customer list view
        _tableView.translatesAutoresizingMaskIntoConstraints = true
        _tableView.frame = CGRect(x: 0,
                                  y: offset,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.SCREEN_HEIGHT - offset)
        _tableView.separatorStyle = .singleLine
        
        _tableView.contentInset = UIEdgeInsets.zero
        _tableView.addSubview(self.refreshControl)
        
        // Button create customer
        let btnCreateCustomer = UIButton()
        CommonProcess.createButtonLayout(btn: btnCreateCustomer,
                                         x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                         y:  GlobalConst.SCREEN_HEIGHT - GlobalConst.BUTTON_H - GlobalConst.MARGIN,
                                         text: DomainConst.CONTENT00168.uppercased(),
                                         action: #selector(self.createReport(_:)),
                                         target: self,
                                         img: DomainConst.ADD_ICON_IMG_NAME,
                                         tintedColor: UIColor.white)
        btnCreateCustomer.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                         left: GlobalConst.MARGIN,
                                                         bottom: GlobalConst.MARGIN,
                                                         right: GlobalConst.MARGIN)
        self.view.addSubview(btnCreateCustomer)
        
        // Get data from server
        G06F00S04VC._data.clearData()
        WorkingReportListRequest.request(action: #selector(setData(_:)),
                                         view: self,
                                         dateFrom: _fromDate,
                                         dateTo: _toDate,
                                         page: String(self._page))
        // Add search button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.SEARCH_ICON_IMG_NAME,
                                       action: #selector(searchButtonTapped(_:)),
                                       target: self)
        // Search view
        setupSearchView()
    }
    
    //++ BUG0190-SPJ (NguyenPT 20180328) Add user report field
    /**
     * Notifies the view controller that its view is about to be added to a view hierarchy.
     */
    override func viewWillAppear(_ animated: Bool) {
        self.handleRefresh(self)
    }
    //-- BUG0190-SPJ (NguyenPT 20180328) Add user report field
    
    internal func createReport(_ sender: AnyObject) {
        pushToView(name: G06F02VC.theClassName)
    }
    
    /**
     * Set up search view
     */
    private func setupSearchView() {
        // Search view
        _viewSearch.frame = CGRect(x: 0, y: self.getTopHeight(),
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: GlobalConst.SCREEN_HEIGHT - self.getTopHeight())
        _viewSearch.isHidden = true
        _viewSearch.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.view.addSubview(_viewSearch)
        // Input view
        _viewInput.frame = CGRect(x: GlobalConst.MARGIN,
                                  y: GlobalConst.MARGIN,
                                  width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN,
                                  height: GlobalConst.LABEL_H * 2 + GlobalConst.EDITTEXT_H * 2 + GlobalConst.BUTTON_H + GlobalConst.MARGIN)
        _viewInput.backgroundColor = UIColor.white
        _viewInput.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        _viewSearch.addSubview(_viewInput)
        // From label
        let leftMargin = GlobalConst.MARGIN
        var offset = GlobalConst.MARGIN
        _lblFromDate.frame = CGRect(x: leftMargin, y: offset,
                                    width: _viewInput.frame.width - leftMargin,
                                    height: GlobalConst.LABEL_H)
        _lblFromDate.text = DomainConst.CONTENT00282
        _lblFromDate.textColor = UIColor.black
        _lblFromDate.textAlignment = .left
        _lblFromDate.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _viewInput.addSubview(_lblFromDate)
        offset += GlobalConst.LABEL_H
        // From textfield
        _txtFromDate.frame = CGRect(x: leftMargin, y: offset,
                                    width: _viewInput.frame.width - leftMargin,
                                    height: GlobalConst.EDITTEXT_H)
        _txtFromDate.text = CommonProcess.getCurrentDate()
        _txtFromDate.textColor = UIColor.black
        _txtFromDate.textAlignment = .left
        _txtFromDate.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _txtFromDate.delegate = self
        setLeftImgTextField(textField: _txtFromDate, name: DomainConst.DATETIME_ICON_IMG_NAME)
        _viewInput.addSubview(_txtFromDate)
        offset += GlobalConst.EDITTEXT_H
        
        // To label
        _lblToDate.frame = CGRect(x: leftMargin, y: offset,
                                  width: _viewInput.frame.width - leftMargin,
                                  height: GlobalConst.LABEL_H)
        _lblToDate.text = DomainConst.CONTENT00283
        _lblToDate.textColor = UIColor.black
        _lblToDate.textAlignment = .left
        _lblToDate.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _viewInput.addSubview(_lblToDate)
        offset += GlobalConst.LABEL_H
        // To textfield
        _txtToDate.frame = CGRect(x: leftMargin, y: offset,
                                  width: _viewInput.frame.width - leftMargin,
                                  height: GlobalConst.EDITTEXT_H)
        _txtToDate.text = CommonProcess.getCurrentDate()
        _txtToDate.textColor = UIColor.black
        _txtToDate.textAlignment = .left
        _txtToDate.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _txtToDate.delegate = self
        setLeftImgTextField(textField: _txtToDate, name: DomainConst.DATETIME_ICON_IMG_NAME)
        _viewInput.addSubview(_txtToDate)
        offset += GlobalConst.EDITTEXT_H
        
        // Search button
        let btnSearch = UIButton()
        btnSearch.frame = CGRect(x: 0, y: offset,
                                 width: _viewInput.frame.width,
                                 height: GlobalConst.BUTTON_H)
        btnSearch.setTitle(DomainConst.CONTENT00287, for: UIControlState())
        btnSearch.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnSearch.setTitleColor(UIColor.white, for: UIControlState())
        btnSearch.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnSearch.addTarget(self, action: #selector(btnSearchTapped(_:)), for: .touchUpInside)
        self._viewInput.addSubview(btnSearch)
    }
    
    /**
     * Set left image for textfield
     * - parameter textField: Current textField
     * - parameter name: Image name
     */
    private func setLeftImgTextField(textField: UITextField, name: String) {
        textField.leftViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0,
                                                width: GlobalConst.EDITTEXT_H - GlobalConst.MARGIN,
                                                height: GlobalConst.EDITTEXT_H - GlobalConst.MARGIN))
        let img = ImageManager.getImage(named: name)
        let tinted = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imgView.image = tinted
        imgView.tintColor = UIColor.black
        textField.leftView = imgView
    }
    
    /**
     * Handle when tap button Search
     */
    internal func btnSearchTapped(_ sender: AnyObject) {
        self._fromDate  = self._txtFromDate.text!
        self._toDate    = self._txtToDate.text!
        self._page      = 0
        WorkingReportListRequest.request(action: #selector(finishSearch(_:)),
                                          view: self,
                                          dateFrom: self._fromDate,
                                          dateTo: self._toDate,
                                          page: String(_page))
    }
    
    internal func finishSearch(_ notification: Notification) {
        G06F00S04VC._data.clearData()
        _viewSearch.isHidden = true
        _txtFromDate.resignFirstResponder()
        _txtToDate.resignFirstResponder()
        setData(notification)
    }
    
    /**
     * Handle tap on Search button
     * - parameter sender: AnyObject
     */
    internal func searchButtonTapped(_ sender: AnyObject) {
        if _viewSearch.isHidden {
            _viewSearch.isHidden = false
            _txtFromDate.becomeFirstResponder()
        } else {
            _viewSearch.isHidden = true
            _txtFromDate.resignFirstResponder()
            _txtToDate.resignFirstResponder()
        }
    }
    
    /**
     * Set data after run request
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = WorkingReportListRespModel(jsonString: data)
        updateData(model: model)
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
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return G06F00S04VC._data.getRecord().count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DomainConst.WORKING_REPORT_LIST_TABLE_VIEW_CELL) as! WorkingReportListCell
        if G06F00S04VC._data.getRecord().count > indexPath.row {
            cell.setData(model: G06F00S04VC._data.getRecord()[indexPath.row])
        }
        return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WorkingReportListCell.CELL_HEIGHT - GlobalConst.CELL_HEIGHT_SHOW / 3
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        G06F00S05VC._id = G06F00S04VC._data.getRecord()[indexPath.row].id
        self.pushToView(name: G06F00S05VC.theClassName)
        //        self.showToast(message: "Open order detail: \(G05F00S02VC._id)")
    }
    
    /**
     * Tells the delegate the table view is about to draw a cell for a particular row.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Total page does not 1
        if G06F00S04VC._data.total_page != 1 {
            let lastElement = G06F00S04VC._data.getRecord().count - 1
            // Current is the last element
            if indexPath.row == lastElement {
                self._page += 1
                // Page less than total page
                if self._page <= G06F00S04VC._data.total_page {
                    WorkingReportListRequest.request(action: #selector(setData(_:)),
                                                      view: self,
                                                      dateFrom: self._fromDate,
                                                      dateTo: self._toDate,
                                                      page: String(self._page))
                }
            }
        }
    }
    
    /**
     * Handle when change value in From date picker
     * - parameter sender: From date picker
     */
    internal func datePickerChangedFrom(sender: UIDatePicker) {
        _txtFromDate.text = CommonProcess.getDateString(date: sender.date)
    }
    
    /**
     * Handle when change value in To date picker
     * - parameter sender: To date picker
     */
    internal func datePickerChangedTo(sender: UIDatePicker) {
        _txtToDate.text = CommonProcess.getDateString(date: sender.date)
    }
    
    /**
     * Handle start editing
     * - parameter textField: Current focus textfield
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self._txtFromDate {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(datePickerChangedFrom(sender:)), for: .valueChanged)
        } else if textField == self._txtToDate {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(datePickerChangedTo(sender:)), for: .valueChanged)
        }
        markSelected(textField: textField)
    }
    
    /**
     * Handle finish edit textfield
     * - parameter textField: Current focus textfield
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    /**
     * Tells the responder when one or more fingers touch down in a view or window.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    /**
     * Mark textfield is selected
     * - parameter textField: Current focus textfield
     */
    private func markSelected(textField: UITextField) {
        let normalColor     = UIColor.black
        let selectedColor   = GlobalConst.BUTTON_COLOR_RED
        var fromColor       = normalColor
        var toColor         = selectedColor
        // Current is from textfield
        if textField == self._txtFromDate {
            fromColor = selectedColor
            toColor = normalColor
        }
        self._lblFromDate.textColor = fromColor
        self._txtFromDate.textColor = fromColor
        self._txtFromDate.leftView?.tintColor = fromColor
        self._lblToDate.textColor = toColor
        self._txtToDate.textColor = toColor
        self._txtToDate.leftView?.tintColor = toColor
    }
}
