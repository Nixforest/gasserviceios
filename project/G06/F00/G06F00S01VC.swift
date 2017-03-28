//
//  G06F00S01VC.swift
//  project
//
//  Created by SPJ on 3/27/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F00S01VC: ParentViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    /** Table view */
    @IBOutlet weak var _tableView:      UITableView!
    /** Icon image */
    @IBOutlet weak var iconImg:         UIImageView!
    /** Report label */
    @IBOutlet weak var lblReport:       UILabel!
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
    /** Customer type  */
    private var _customerType:          String = DomainConst.CUSTOMER_FAMILY_BUYING_ALL
    /** Static data */
    private static var _data:           CustomerFamilyListRespModel = CustomerFamilyListRespModel()
    /** Current page */
    private var _page = 0
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        G06F00S01VC._data.clearData()
        self._page = 0
        _tableView.reloadData()
        CustomerFamilyListRequest.request(action: #selector(finishHandleRefresh(_:)),
                                          view: self,
                                          buying: DomainConst.CUSTOMER_FAMILY_BUYING_ALL,
                                          dateFrom: CommonProcess.getCurrentDate(),
                                          dateTo: CommonProcess.getCurrentDate(),
                                          page: String(self._page))
    }
    
    /**
     * Finish handler after run request
     */
    internal func finishHandleRefresh(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CustomerFamilyListRespModel(jsonString: data)
        if model.isSuccess() {
            G06F00S01VC._data.clearData()
            G06F00S01VC._data.total_page = model.total_page
            G06F00S01VC._data.total_record = model.total_record
            G06F00S01VC._data.append(contentOf: model.getRecord())
            lblReport.text = model.report
            _tableView.reloadData()
        }
        refreshControl.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        createNavigationBar(title: DomainConst.CONTENT00281)
        
        // Get height of status bar + navigation bar
        //let height = self.getTopHeight()
        var offset: CGFloat = 0.0
        if BaseModel.shared.getDebugShowTopIconFlag() {
            iconImg.image = ImageManager.getImage(named: DomainConst.ORDER_ICON_IMG_NAME)
            iconImg.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W / 2) / 2,
                                   y: offset,
                                   width: GlobalConst.LOGIN_LOGO_W / 2,
                                   height: GlobalConst.LOGIN_LOGO_H / 2)
            iconImg.translatesAutoresizingMaskIntoConstraints = true
            offset += iconImg.frame.height
            iconImg.isHidden = false
        } else {
            iconImg.isHidden = true
        }
        
        // Report label
        lblReport.translatesAutoresizingMaskIntoConstraints = true
        lblReport.frame = CGRect(x: 0, y: self.getTopHeight() + GlobalConst.MARGIN,
                                 width: GlobalConst.SCREEN_WIDTH,
                                 height: GlobalConst.LABEL_H)
        lblReport.text               = DomainConst.BLANK
        lblReport.textAlignment      = NSTextAlignment.center
        lblReport.font               = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        lblReport.textColor = UIColor.black
        lblReport.backgroundColor = UIColor.white
        self.view.addSubview(lblReport)
        offset += lblReport.frame.height + GlobalConst.MARGIN
        
        // Customer list view
        _tableView.translatesAutoresizingMaskIntoConstraints = true
        _tableView.frame = CGRect(x: 0,
                                  y: offset,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.SCREEN_HEIGHT - offset)
        _tableView.separatorStyle = .singleLine
//         _tableView.dataSource = self
//        _tableView.delegate = self
        _tableView.contentInset = UIEdgeInsets.zero
        _tableView.addSubview(self.refreshControl)
        
        // Get data from server
        G06F00S01VC._data.clearData()
        CustomerFamilyListRequest.request(action: #selector(setData(_:)),
                                          view: self,
                                          buying: DomainConst.CUSTOMER_FAMILY_BUYING_ALL,
                                          dateFrom: CommonProcess.getCurrentDate(),
                                          dateTo: CommonProcess.getCurrentDate(),
                                          page: String(self._page))
        // Add search button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.SEARCH_ICON_IMG_NAME,
                                       action: #selector(searchButtonTapped(_:)),
                                       target: self)
        // Search view
        setupSearchView()
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
                                  height: GlobalConst.LABEL_H * 2 + GlobalConst.EDITTEXT_H * 2 + GlobalConst.BUTTON_H * 2 + GlobalConst.MARGIN * 2)
        _viewInput.backgroundColor = UIColor.white
        _viewInput.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        _viewSearch.addSubview(_viewInput)
        // From label
        let leftMargin = GlobalConst.MARGIN
        var offset = GlobalConst.MARGIN
        _lblFromDate.frame = CGRect(x: leftMargin, y: offset,
                                    width: _viewInput.frame.width - leftMargin,
                                    height: GlobalConst.LABEL_H)
        _lblFromDate.text = "Từ ngày"
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
        _lblToDate.text = "Đến ngày"
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
        
        // Customer type control
        let items = ["Tất cả", "Đã mua", "Chưa mua"]
        let _segmCustomerType = UISegmentedControl(items: items)
        let font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _segmCustomerType.setTitleTextAttributes([NSFontAttributeName: font],
                                                      for: UIControlState())
        _segmCustomerType.selectedSegmentIndex = 0
        _segmCustomerType.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        _segmCustomerType.tintColor = GlobalConst.BUTTON_COLOR_RED
        _segmCustomerType.frame = CGRect(x: 0,
                                        y: offset,
                                        width: _viewInput.frame.width,
                                        height: GlobalConst.BUTTON_H)
        _segmCustomerType.addTarget(self, action: #selector(customerTypeChanged(_:)), for: .valueChanged)
        _viewInput.addSubview(_segmCustomerType)
        offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        // Search button
        let btnSearch = UIButton()
        btnSearch.frame = CGRect(x: 0, y: offset,
                                 width: _viewInput.frame.width,
                                 height: GlobalConst.BUTTON_H)
        btnSearch.setTitle("Tìm kiếm", for: UIControlState())
        btnSearch.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnSearch.setTitleColor(UIColor.white, for: UIControlState())
        btnSearch.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnSearch.addTarget(self, action: #selector(btnSearchTapped(_:)), for: .touchUpInside)
        self._viewInput.addSubview(btnSearch)
    }
    
    internal func btnSearchTapped(_ sender: AnyObject) {
        CustomerFamilyListRequest.request(action: #selector(finishSearch(_:)),
                                          view: self,
                                          buying: self._customerType,
                                          dateFrom: self._txtFromDate.text!,
                                          dateTo: self._txtToDate.text!,
                                          page: "0")
    }
    
    internal func finishSearch(_ notification: Notification) {
        G06F00S01VC._data.clearData()
        _viewSearch.isHidden = true
        _txtFromDate.resignFirstResponder()
        _txtToDate.resignFirstResponder()
        setData(notification)
    }
    
    /**
     * Handle when change customer type
     */
    internal func customerTypeChanged(_ sender: AnyObject) {
        switch (sender as! UISegmentedControl).selectedSegmentIndex {
        case 0:
            _customerType = DomainConst.CUSTOMER_FAMILY_BUYING_ALL
        case 1:
            _customerType = DomainConst.CUSTOMER_FAMILY_BUYING_BOUGHT
        case 2:
            _customerType = DomainConst.CUSTOMER_FAMILY_BUYING_NOTYET
        default:
            break
        }
    }
    
    /**
     * Handle tap on Search button
     * - parameter sender: AnyObject
     */
    internal func searchButtonTapped(_ sender: AnyObject) {
        //showAlert(message: "Search button tapped")
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
        let model = CustomerFamilyListRespModel(jsonString: data)
        if model.isSuccess() {
            G06F00S01VC._data.total_page = model.total_page
            G06F00S01VC._data.total_record = model.total_record
            G06F00S01VC._data.append(contentOf: model.getRecord())
            lblReport.text = model.report
            _tableView.reloadData()
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
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return G06F00S01VC._data.getRecord().count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DomainConst.CUSTOMER_FAMILY_LIST_TABLE_VIEW_CELL) as! CustomerFamilyListCell
        if G06F00S01VC._data.getRecord().count > indexPath.row {
            cell.setData(model: G06F00S01VC._data.getRecord()[indexPath.row])
        }
        return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CustomerFamilyListCell.CELL_HEIGHT - GlobalConst.CELL_HEIGHT_SHOW / 4
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        G05F00S02VC._id = G05F00S01VC._data.getRecord()[indexPath.row].id
//        self.pushToView(name: G05Const.G05_F00_S02_VIEW_CTRL)
//        self.showToast(message: "Open order detail: \(G05F00S02VC._id)")
    }
    
    /**
     * Tells the delegate the table view is about to draw a cell for a particular row.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Total page does not 1
        if G06F00S01VC._data.total_page != 1 {
            let lastElement = G06F00S01VC._data.getRecord().count - 1
            // Current is the last element
            if indexPath.row == lastElement {
                self._page += 1
                // Page less than total page
                if self._page <= G06F00S01VC._data.total_page {
                    CustomerFamilyListRequest.request(action: #selector(setData(_:)),
                                                      view: self,
                                                      buying: DomainConst.CUSTOMER_FAMILY_BUYING_ALL,
                                                      dateFrom: CommonProcess.getCurrentDate(),
                                                      dateTo: CommonProcess.getCurrentDate(),
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
}
