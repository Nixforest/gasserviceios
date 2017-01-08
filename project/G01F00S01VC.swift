//
//  UpholdListViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/9/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F00S01VC: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate/*, G01F00S01ProblemCellDelegate*/ {
    // MARK: Properties
    /** Current view type */
    var currentViewType = DomainConst.TYPE_TROUBLE
    /** Current page */
    var currentPage = 0
    /** Current customer Id */
    var currentCustomerId = ""
    /** Current status */
    var currentStatus = ""
    /** Filtered string */
    var filteredStr = String()
    /** Flag search active */
    var searchActive:Bool = false
    /** Flag begin search */
    var beginSearch:Bool = false
    /** List of status */
    var aStatusList: [ConfigBean] = [ConfigBean]()
    /** Timer for search auto complete */
    var timer = Timer()
    /** Tap gesture hide keyboard */
    var gestureHideKeyboard: UIGestureRecognizer = UIGestureRecognizer()
    /** Tap gesture show status list */
    var gestureShowStatusList: UIGestureRecognizer = UIGestureRecognizer()
    
    /** Blur view */
    @IBOutlet weak var blurView: UIView!
    /** Search box */
    @IBOutlet weak var searchBox: UISearchBar!
    /** Uphold list button */
    @IBOutlet weak var upholdListButton: UISegmentedControl!
    /** Period table view */
    @IBOutlet weak var periodTableView: UITableView!
    /** Problem table view */
    @IBOutlet weak var problemTableView: UITableView!
    /** Search bar table view */
    @IBOutlet weak var searchBarTableView: UITableView!
    /** Label status list */
    @IBOutlet weak var lblStatusList: UILabel!
    /** Status list view */
    @IBOutlet weak var statusListView: UIView!
    
    // MARK: Actions
    /**
     * Handle change tab.
     * - parameter sender: AnyObject
     */
    @IBAction func upholdListChange(_ sender: AnyObject) {
        switch upholdListButton.selectedSegmentIndex {
        case 0:     // Problem uphold list
            currentViewType             = DomainConst.TYPE_TROUBLE
            periodTableView.isHidden    = true
            problemTableView.isHidden   = false
            
        case 1:     // Periodically uphold list
            currentViewType             = DomainConst.TYPE_PERIODICALLY
            problemTableView.isHidden   = true
            periodTableView.isHidden    = false
        default:
            break
        }
        self.clearData()
        self.searchBox.text = ""
        self.currentCustomerId = ""
        if aStatusList.count > 0 {
            // Set selection text
            lblStatusList.text = aStatusList[0].name
            // Save current status
            currentStatus = aStatusList[0].id
        }
        
        RequestAPI.requestUpholdList(page: currentPage, type: currentViewType, customerId: currentCustomerId, status: currentStatus, view: self)
    }
    
    /**
     * Show list status.
     * - parameter sender: AnyObject
     */
    @IBAction func showStatusListButtonTapped(_ sender: AnyObject) {
        if aStatusList.count > 0 {
            statusListView.isHidden = false
            blurView.isHidden          = false
        }
    }
    //training mode
    override func viewDidAppear(_ animated: Bool) {
        //notification button enable/disable
        self.updateNotificationStatus()
        if currentViewType == DomainConst.TYPE_TROUBLE {
            problemTableView.reloadData()
        } else {
            periodTableView.reloadData()
        }
    }
    
    /**
     * Show search bar table view.
     * - parameter notification: Notification
     */
    func showSearchBarTableView(_ notification: Notification) {
        // Load data for search bar table view
        searchBarTableView.reloadData()
        // Show
        searchBarTableView.isHidden = !searchActive
        // Move to front
        searchBarTableView.layer.zPosition = 1
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self, selector: #selector(gasServiceItemTapped), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_GAS_SERVICE_ITEM), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(issueItemTapped(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_ISSUE_ITEM), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(configItemTap(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_COFIG_ITEM_UPHOLDLISTVIEW), object: nil)
    }
    
    /**
     * View did load.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        NotificationCenter.default.addObserver(self, selector: #selector(G01F00S01VC.showSearchBarTableView(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_SHOW_SEARCH_BAR_UPHOLDLIST_VIEW), object: nil)
        
        // Blur view when status list picker active
        blurView.isHidden          = true
        blurView.backgroundColor   = UIColor.clear
        let blurEffect          = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView      = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame    = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurView.addSubview(blurEffectView)
        let marginX = GlobalConst.PARENT_BORDER_WIDTH
        // Cell
        let frameworkBundle = Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)
        self.periodTableView.register(UINib(nibName: DomainConst.G01_F00_S01_PERIOD_CELL, bundle: frameworkBundle),
                                      forCellReuseIdentifier: DomainConst.G01_F00_S01_PERIOD_CELL)
        self.problemTableView.register(UINib(nibName: DomainConst.G01_F00_S01_PROBLEM_CELL, bundle: frameworkBundle),
                                       forCellReuseIdentifier: DomainConst.G01_F00_S01_PROBLEM_CELL)
        self.searchBarTableView.register(UINib(nibName: DomainConst.SEARCH_BAR_TABLE_VIEW_CELL, bundle: nil),
                                         forCellReuseIdentifier: DomainConst.SEARCH_BAR_TABLE_VIEW_CELL)
        
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        
        // Search bar
        // Get height of status bar + navigation bar
        let heigh = self.getTopHeight()
        searchBox.placeholder = DomainConst.CONTENT00060
        searchBox.translatesAutoresizingMaskIntoConstraints = true
        searchBox.frame = CGRect(x: marginX,
                                 y: heigh,
                                 width: GlobalConst.SCREEN_WIDTH - marginX * 2,
                                 height: GlobalConst.SEARCH_BOX_HEIGHT )
        searchBox.delegate = self
        // Show hide result of search bar action
        searchBarTableView.translatesAutoresizingMaskIntoConstraints = true
        searchBarTableView.isHidden = !searchActive
        searchBarTableView.frame = CGRect(x: marginX,
                                          y: searchBox.frame.maxY,
                                          width: GlobalConst.SCREEN_WIDTH - marginX * 2,
                                          height: GlobalConst.CELL_IN_SEARCHBAR_TABLE_HEIGHT * 5)
        searchBarTableView.delegate = self
        searchBarTableView.dataSource = self
        
        // Label status list + action
        lblStatusList.textAlignment = .center
        lblStatusList.frame = CGRect(x: marginX,
                                     y: searchBox.frame.maxY,
                                     width: GlobalConst.SCREEN_WIDTH - marginX * 2,
                                     height: GlobalConst.LABEL_HEIGHT)
        lblStatusList.translatesAutoresizingMaskIntoConstraints = true
        
        // Set status uphold data
        if BaseModel.shared.listUpholdStatus.count > 0 {
            for item in BaseModel.shared.listUpholdStatus {
                aStatusList.append(item)
            }
            lblStatusList.text = aStatusList[0].name
        }
        lblStatusList.textColor = UIColor.gray
        lblStatusList.isUserInteractionEnabled = true
        // Handle tap on status selector
        let gestureShowStatusList: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(G01F00S01VC.showStatusListButtonTapped))
        gestureShowStatusList.numberOfTapsRequired = 1
        lblStatusList.addGestureRecognizer(gestureShowStatusList)
        
        // Add Picker to View
        statusListView.isHidden = true
        statusListView.translatesAutoresizingMaskIntoConstraints = true
        statusListView.frame = CGRect(x: marginX,
                                      y: lblStatusList.frame.maxY,
                                      width: GlobalConst.SCREEN_WIDTH - marginX * 2,
                                      height: GlobalConst.SCREEN_HEIGHT / 4)
        
        let statusListPicker = UIPickerView()
        statusListPicker.frame = CGRect(x: 0,
                                        y: 0,
                                        width: GlobalConst.SCREEN_WIDTH - marginX * 2,
                                        height: GlobalConst.SCREEN_HEIGHT / 4)
        statusListPicker.backgroundColor = UIColor.white
        statusListPicker.delegate = self
        statusListView.addSubview(statusListPicker)
        
        // Segment control - uphold button
        let font = UIFont.systemFont(ofSize: 15)
        upholdListButton.setTitleTextAttributes([NSFontAttributeName: font],
                                                for: UIControlState())
        
        upholdListButton.setTitle(DomainConst.CONTENT00077, forSegmentAt: 0)
        upholdListButton.setTitle(DomainConst.CONTENT00078, forSegmentAt: 1)
        upholdListButton.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        upholdListButton.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        upholdListButton.tintColor = GlobalConst.BUTTON_COLOR_RED
        upholdListButton.frame = CGRect(x: marginX,
                                        y: lblStatusList.frame.maxY,
                                        width: GlobalConst.SCREEN_WIDTH - marginX * 2,
                                        height: GlobalConst.BUTTON_H)
        upholdListButton.translatesAutoresizingMaskIntoConstraints = true
        // Uphold list view
        problemTableView.translatesAutoresizingMaskIntoConstraints = true
        problemTableView.frame = CGRect(x: marginX,
                                        y: upholdListButton.frame.maxY,
                                        width: GlobalConst.SCREEN_WIDTH - marginX * 2,
                                        height: GlobalConst.SCREEN_HEIGHT - upholdListButton.frame.maxY - GlobalConst.PARENT_BORDER_WIDTH * 2)
        problemTableView.separatorStyle = .singleLine
        
        periodTableView.translatesAutoresizingMaskIntoConstraints = true
        periodTableView.frame = CGRect(x: marginX,
                                       y: upholdListButton.frame.maxY,
                                       width: GlobalConst.SCREEN_WIDTH - marginX * 2,
                                       height: GlobalConst.SCREEN_HEIGHT - upholdListButton.frame.maxY - GlobalConst.PARENT_BORDER_WIDTH * 2)
        periodTableView.separatorStyle = .singleLine
        
        // Show-hide UpholdList
        periodTableView.isHidden = true
        problemTableView.isHidden = false
        
        //Navigation Bar
        setupNavigationBar(title: DomainConst.CONTENT00129, isNotifyEnable: true)
        
        // Notify set data
        NotificationCenter.default.addObserver(self, selector: #selector(G01F00S01VC.setData(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_UPHOLDLIST_VIEW), object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(G01F00S01VC.reloadData(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_RELOAD_DATA_UPHOLDLIST_VIEW), object: nil)
        
        // Do any additional setup after loading the view.
        gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(G01F00S01VC.hideKeyboard))
        //view.addGestureRecognizer(tap)
        RequestAPI.requestUpholdList(page: currentPage, type: self.currentViewType, customerId: currentCustomerId, status: currentStatus, view: self)
    }
    
//    func reloadData(_ notification: Notification) {
//        CommonProcess.requestUpholdList(page: currentPage, type: self.currentViewType, customerId: currentCustomerId, status: currentStatus, view: self)
//    }
    
    /**
     * Set data for controls
     */
    override func setData(_ notification: Notification) {
        self.updateNotificationStatus()
        if currentViewType == DomainConst.TYPE_TROUBLE {
            problemTableView.reloadData()
        } else {
            periodTableView.reloadData()
        }
        //        CommonProcess.requestUpholdList(page: currentPage, type: self.currentViewType, customerId: currentCustomerId, status: currentStatus, view: self)
        // Check open by notification
        if BaseModel.shared.checkNotificationExist() {
            if BaseModel.shared.checkIsLogin() {
                if BaseModel.shared.isUpholdNotification() {
                    if BaseModel.shared.isCustomerUser() {
                        BaseModel.shared.sharedInt = BaseModel.shared.getUpholdIndexById(id: BaseModel.shared.notify.getId())
                        let detail = self.mainStoryboard.instantiateViewController(withIdentifier: DomainConst.G01_F00_S03_VIEW_CTRL)
                        self.navigationController?.pushViewController(detail, animated: true)
                    } else {
                        BaseModel.shared.sharedInt = BaseModel.shared.getUpholdIndexById(id: BaseModel.shared.notify.getId())
                        let detail = self.mainStoryboard.instantiateViewController(withIdentifier: DomainConst.G01_F00_S02_VIEW_CTRL)
                        self.navigationController?.pushViewController(detail, animated: true)
                    }
                }
            }
        }
    }
    
    /**
     * Clear data of view.
     * Reset currentPage value
     * Reset uphold list value
     */
    override func clearData() {
        currentPage = 0
        BaseModel.shared.clearUpholdList()
    }
    
    // MARK: - Textfield Delegate
    /**
     * Hide keyboard.
     */
    func hideKeyboard() {
        // Hide keyboard
        self.view.endEditing(true)
        // Turn off flag
        isKeyboardShow = false
        // Remove hide keyboard gesture
        self.view.removeGestureRecognizer(gestureHideKeyboard)
    }

    /**
     * Did receive memory warning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIPickerViewDelegate
    /**
     * Scroll view select status.
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /**
     * Set number of item in picker view
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return aStatusList.count
    }
    
    /**
     * Set width of picker view
     */
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return GlobalConst.SCREEN_WIDTH
    }
    
    /**
     * Set height of item on picker view
     */
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return GlobalConst.LABEL_HEIGHT
    }
    
    /**
     * Set text of item
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return aStatusList[row].name
    }
    
    /**
     * Handle when select on picker view
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblStatusList.tag = row
        if aStatusList.count > row {
            // Set selection text
            lblStatusList.text = aStatusList[row].name
            // Save current status
            currentStatus = aStatusList[row].id
            // Hide status picker view
            statusListView.isHidden = true
            blurView.isHidden = true
            // Clear uphold data
            clearData()
            // Request data from server
            RequestAPI.requestUpholdList(page: currentPage, type: currentViewType, customerId: currentCustomerId, status: currentStatus, view: self)
        }
    }
    
    // MARK: - UITableViewDataSource
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var count = NSInteger()
        // Current view is periodically uphold
        if tableView == periodTableView {
            count = BaseModel.shared.upholdList.getRecord().count
        }
        // Current view is problem uphold
        if tableView == problemTableView {
            count = BaseModel.shared.upholdList.getRecord().count
        }
        
        // Search bar is showing
        if tableView == searchBarTableView {
            count = BaseModel.shared.searchCustomerResult.getRecord().count
        }

        return count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            var cellReturn = UITableViewCell()
            // Period view
            if tableView == periodTableView {
                let cell:TableCellUpholdType = tableView.dequeueReusableCell(
                    withIdentifier: DomainConst.G01_F00_S01_PERIOD_CELL) as! TableCellUpholdType
                if (BaseModel.shared.upholdList.getRecord().count > indexPath.row) {
                    cell.setData(model: BaseModel.shared.upholdList.getRecord()[indexPath.row])
                }
                cellReturn = cell
            }
            
            // Problem view
            if tableView == problemTableView {
                let cell:TableCellUpholdType = tableView.dequeueReusableCell(
                    withIdentifier: DomainConst.G01_F00_S01_PROBLEM_CELL) as! TableCellUpholdType
                if (BaseModel.shared.upholdList.getRecord().count > indexPath.row) {
                    cell.setData(model: BaseModel.shared.upholdList.getRecord()[indexPath.row])
                }
                //cell.delegate = self
                cellReturn = cell
            }
            
            // Search bar view
            if tableView == searchBarTableView {
                let cell:SearchBarTableViewCell = tableView.dequeueReusableCell(
                    withIdentifier: DomainConst.SEARCH_BAR_TABLE_VIEW_CELL) as! SearchBarTableViewCell
                if (BaseModel.shared.searchCustomerResult.getRecord().count > indexPath.row) {
                    cell.result.text = BaseModel.shared.searchCustomerResult.getRecord()[indexPath.row].name
                }

                cellReturn = cell
            }
            cellReturn.selectionStyle = .gray
            return cellReturn
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = GlobalConst.CELL_HEIGHT_SHOW
//        // Period view
//        if tableView == periodTableView {
//            height = GlobalConst.CELL_HEIGHT_SHOW
//            
//        }
//        // Problem view
//        if tableView == problemTableView {
//            height = GlobalConst.CELL_HEIGHT_SHOW
//        }
        if BaseModel.shared.isCustomerUser() {
            height -= GlobalConst.CELL_HEIGHT_SHOW / 4
        }
        // Search bar view
        if tableView == searchBarTableView {
            height = 50
        }
        return height
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Period view
        if tableView == periodTableView {
            if BaseModel.shared.isCustomerUser() {
                // Move to customer detail uphold G01F00S03
                if (BaseModel.shared.upholdList.getRecord().count > indexPath.row) {
                    BaseModel.shared.sharedInt = indexPath.row
                    let detail = self.mainStoryboard.instantiateViewController(withIdentifier: DomainConst.G01_F00_S03_VIEW_CTRL)
                    self.navigationController?.pushViewController(detail, animated: true)
                }
            } else {
                // Move to customer detail uphold G01F00S02
                if (BaseModel.shared.upholdList.getRecord().count > indexPath.row) {
                    BaseModel.shared.sharedInt = indexPath.row
                    let detail = self.mainStoryboard.instantiateViewController(withIdentifier: DomainConst.G01_F00_S02_VIEW_CTRL)
                    self.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        if tableView == problemTableView {
            if BaseModel.shared.isCustomerUser() {
                // Move to customer detail uphold G01F00S03
                if (BaseModel.shared.upholdList.getRecord().count > indexPath.row) {
                    BaseModel.shared.sharedInt = indexPath.row
                    let detail = self.mainStoryboard.instantiateViewController(withIdentifier: DomainConst.G01_F00_S03_VIEW_CTRL)
                    self.navigationController?.pushViewController(detail, animated: true)
                }

            } else {
                // Move to customer detail uphold G01F00S02
                if (BaseModel.shared.upholdList.getRecord().count > indexPath.row) {
                    BaseModel.shared.sharedInt = indexPath.row
                    let detail = self.mainStoryboard.instantiateViewController(withIdentifier: DomainConst.G01_F00_S02_VIEW_CTRL)
                    self.navigationController?.pushViewController(detail, animated: true)
                }
            }
            let cell:TableCellUpholdType = tableView.dequeueReusableCell(
                withIdentifier: DomainConst.G01_F00_S01_PROBLEM_CELL) as! TableCellUpholdType
            //cell.ratingButton.addTarget(self, action: #selector(toRatingVC), for: .touchUpInside)
        }
        
        // Search bar
        if tableView == searchBarTableView {
            searchBarTableView.isHidden = true
            searchBox.resignFirstResponder()
            if (BaseModel.shared.searchCustomerResult.getRecord().count > indexPath.row) {
                searchBox.text = BaseModel.shared.searchCustomerResult.getRecord()[indexPath.row].name
                self.clearData()
                currentCustomerId = BaseModel.shared.searchCustomerResult.getRecord()[indexPath.row].id
                RequestAPI.requestUpholdList(page: currentPage, type: currentViewType, customerId: currentCustomerId, status: currentStatus, view: self)
            }
        }
    }
    
    /**
     * Handle when tap on Rating button.
     */
    func toRatingVC(id: String) {
        BaseModel.shared.sharedString = id
        let ratingVC = self.mainStoryboard.instantiateViewController(withIdentifier: DomainConst.G01_F03_VIEW_CTRL)
        self.navigationController?.pushViewController(ratingVC, animated: true)
    }
    
    /**
     * Tells the delegate the table view is about to draw a cell for a particular row.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // If current view is Uphold table view
        if (BaseModel.shared.upholdList.getRecord().count >= 15) {
            let lastElement = BaseModel.shared.upholdList.getRecord().count - 1
            if indexPath.row == lastElement {
                currentPage += 1
                RequestAPI.requestUpholdList(page: currentPage, type: self.currentViewType, customerId: currentCustomerId, status: currentStatus, view: self)
            }
        }
        // If current view is search bar table view
        if tableView == searchBarTableView {
            return
        }
    }
    
    // MARK: - SearchbarDelegate
    /**
     * Handle begin search
     */
    func beginSearching()  {
        if beginSearch == false {
            beginSearch = true
        }
        
        print("Call api search")
        // CAll API
        RequestAPI.requestSearchCustomer(keyword: searchBox.text!, view: self)
    }
    
    /**
     * Tells the delegate that the user changed the search text.
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        filteredStr = searchText
        if filteredStr.characters.count > (DomainConst.SEARCH_MIN_LENGTH - 1) {
            beginSearch = false
            searchActive = true
            // Start count
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(G01F00S01VC.beginSearching), userInfo: nil, repeats: false)
            
        } else {
            beginSearch = false
            searchActive = false
            // Hide search bar table view
            searchBarTableView.isHidden = !searchActive
            // Reset current customer id
            self.currentCustomerId = ""
        }
    }
    
    /**
     * Tells the delegate when the user begins editing the search text.
     */
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        isKeyboardShow = true
        self.view.addGestureRecognizer(gestureHideKeyboard)
    }
    
    /**
     * Tells the delegate that the user finished editing the search text.
     */
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = true
        // If text is empty
        if (searchBar.text?.isEmpty)! {
            // Clear uphold data
            clearData()
            // Reset current customer id
            currentCustomerId = ""
            // Request data from server
            RequestAPI.requestUpholdList(page: currentPage, type: currentViewType, customerId: currentCustomerId, status: currentStatus, view: self)
        }
    }
    
    /**
     * Tells the delegate that the cancel button was tapped.
     */
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    /**
     * Tells the delegate that the search button was tapped.
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = true
        beginSearching()
    }


}
