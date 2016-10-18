//
//  UpholdListViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/9/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdListViewController: CommonViewController, UIPopoverPresentationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, problemTableViewCellDelegate {
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
    /** Sample data of customers */
    var customerData = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    /** List of status */
    //var aStatusList:[String]! = ["Mới", "Xử lý", "Hoàn thành", "Yêu cầu chuyển", "Xử lý dài ngày"]
    //var aStatusList:[String] = [String]()
    var aStatusList: [ConfigBean] = [ConfigBean]()
    //var statusIndex = Int()
    /** Timer for search auto complete */
    var timer = Timer()
    /** Tap gesture hide keyboard */
    var gestureHideKeyboard: UIGestureRecognizer = UIGestureRecognizer()
    /** Tap gesture show status list */
    var gestureShowStatusList: UIGestureRecognizer = UIGestureRecognizer()
    
    /***/
    @IBOutlet weak var view2: UIView!
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
        switch upholdListButton.selectedSegmentIndex
        {
        case 0:     // Problem uphold list
            currentViewType             = DomainConst.TYPE_TROUBLE
            periodTableView.isHidden    = true
            problemTableView.isHidden   = false

        case 1:     // Periodically uphold list
            currentViewType             = DomainConst.TYPE_PERIODICALLY
            problemTableView.isHidden   = true
            periodTableView.isHidden    = false
            //periodTableView.reloadData()
        default:
            break
        }
        currentPage = 0
        self.clearData()
        CommonProcess.requestUpholdList(page: currentPage, type: currentViewType, customerId: currentCustomerId, status: "", view: self)
    }
    
    /**
     * Show list status.
     * - parameter sender: AnyObject
     */
    @IBAction func showStatusListButtonTapped(_ sender: AnyObject) {
        statusListView.isHidden = false
        view2.isHidden          = false

    }
    //training mode
    override func viewDidAppear(_ animated: Bool) {
        //training mode enable/disable
//        if GlobalConst.TRAINING_MODE_FLAG == true {
//            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
//        } else {
//            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
//        }
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
        
        // Remove status list gesture
        //lblStatusList.removeGestureRecognizer(gestureShowStatusList)
    }
    
    /**
     * Handle when tap on Issue menu item
     */
    func issueItemTapped(_ notification: Notification) {
        showAlert(message: "issueItemTapped")
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.gasServiceItemTapped), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_GAS_SERVICE_ITEM), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdListViewController.issueItemTapped(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_ISSUE_ITEM), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(super.configItemTap(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM_UPHOLDLISTVIEW), object: nil)
    }
    
    /**
     * View did load.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Training mode
        asignNotifyForTrainingModeChange()
        // Menu item tap
        asignNotifyForMenuItem()
        
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdListViewController.showSearchBarTableView(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_SHOW_SEARCH_BAR_UPHOLDLIST_VIEW), object: nil)
        
        // Blur view when status list picker active
        view2.isHidden = true
        view2.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        view2.addSubview(blurEffectView)
        // Cell
        self.periodTableView.register(UINib(nibName: GlobalConst.PERIOD_TABLE_VIEW_CELL, bundle: nil),
                                      forCellReuseIdentifier: GlobalConst.PERIOD_TABLE_VIEW_CELL)
        self.problemTableView.register(UINib(nibName: GlobalConst.PROBLEM_TABLE_VIEW_CELL, bundle: nil),
                                       forCellReuseIdentifier: GlobalConst.PROBLEM_TABLE_VIEW_CELL)
        self.searchBarTableView.register(UINib(nibName: GlobalConst.SEARCH_BAR_TABLE_VIEW_CELL, bundle: nil),
                                         forCellReuseIdentifier: GlobalConst.SEARCH_BAR_TABLE_VIEW_CELL)
        
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        
        // Search bar
        let heigh = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        searchBox.placeholder = GlobalConst.CONTENT00060
        searchBox.translatesAutoresizingMaskIntoConstraints = true
        searchBox.frame = CGRect(x: 0,
                                 y: heigh,
                                 width: GlobalConst.SCREEN_WIDTH,
                                 height: GlobalConst.SEARCH_BOX_HEIGHT )
        searchBox.delegate = self
        // Show hide result of search bar action
        searchBarTableView.translatesAutoresizingMaskIntoConstraints = true
        searchBarTableView.isHidden = !searchActive
        searchBarTableView.frame = CGRect(x: 0,
                                          y: searchBox.frame.maxY,
                                          width: GlobalConst.SCREEN_WIDTH,
                                          height: GlobalConst.CELL_IN_SEARCHBAR_TABLE_HEIGHT * 5)
        searchBarTableView.delegate = self
        searchBarTableView.dataSource = self
        
        // Label status list + action
        lblStatusList.textAlignment = .center
        lblStatusList.frame = CGRect(x: 0,
                                     y: searchBox.frame.maxY,
                                     width: GlobalConst.SCREEN_WIDTH,
                                     height: GlobalConst.LABEL_HEIGHT)
        lblStatusList.translatesAutoresizingMaskIntoConstraints = true
        
        // Set status uphold data
        if Singleton.sharedInstance.listUpholdStatus.count > 0 {
            for item in Singleton.sharedInstance.listUpholdStatus {
                aStatusList.append(item)
            }
            lblStatusList.text = aStatusList[0].name
        }
        lblStatusList.textColor = UIColor.gray
        lblStatusList.isUserInteractionEnabled = true
        // Handle tap on status selector
        let gestureShowStatusList: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UpholdListViewController.showStatusListButtonTapped))
        gestureShowStatusList.numberOfTapsRequired = 1
        lblStatusList.addGestureRecognizer(gestureShowStatusList)
        //self.view.addSubview(lblStatusList)
        //gestureShowStatusList.delegate = self
        
        // Add Picker to View
        statusListView.isHidden = true
        statusListView.translatesAutoresizingMaskIntoConstraints = true
        statusListView.frame = CGRect(x: 0,
                                      y: lblStatusList.frame.maxY,
                                      width: GlobalConst.SCREEN_WIDTH,
                                      height: GlobalConst.SCREEN_HEIGHT / 4)
        
        let statusListPicker = UIPickerView()
        statusListPicker.frame = CGRect(x: 0,
                                        y: 0,
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: GlobalConst.SCREEN_HEIGHT / 4)
        statusListPicker.backgroundColor = UIColor.white
        statusListPicker.delegate = self
        statusListView.addSubview(statusListPicker)
        
        // Segment control - uphold button
        let font = UIFont.systemFont(ofSize: 15)
        upholdListButton.setTitleTextAttributes([NSFontAttributeName: font],
                                                for: UIControlState())
        
        upholdListButton.setTitle(GlobalConst.CONTENT00077, forSegmentAt: 0)
        upholdListButton.setTitle(GlobalConst.CONTENT00078, forSegmentAt: 1)
        upholdListButton.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        upholdListButton.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        upholdListButton.tintColor = GlobalConst.BUTTON_COLOR_RED
        upholdListButton.frame = CGRect(x: 0,
                                        y: lblStatusList.frame.maxY,
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: GlobalConst.BUTTON_H)
        upholdListButton.translatesAutoresizingMaskIntoConstraints = true
        // Uphold list view
        problemTableView.translatesAutoresizingMaskIntoConstraints = true
        problemTableView.frame = CGRect(x: 0,
                                        y: upholdListButton.frame.maxY,
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: GlobalConst.SCREEN_HEIGHT - upholdListButton.frame.maxY - GlobalConst.PARENT_BORDER_WIDTH * 2)
        problemTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        periodTableView.translatesAutoresizingMaskIntoConstraints = true
        periodTableView.frame = CGRect(x: 0,
                                       y: upholdListButton.frame.maxY,
                                       width: GlobalConst.SCREEN_WIDTH,
                                       height: GlobalConst.SCREEN_HEIGHT - upholdListButton.frame.maxY - GlobalConst.PARENT_BORDER_WIDTH * 2)
        periodTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        // Show-hide UpholdList
        periodTableView.isHidden = true
        problemTableView.isHidden = false
        
        //Navigation Bar
        setupNavigationBar(title: GlobalConst.CONTENT00129, isNotifyEnable: true)
        
        // Notify set data
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdListViewController.setData(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_UPHOLDLIST_VIEW), object: nil)
        
        //periodTableView.reloadData()
        // Do any additional setup after loading the view.
        gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(UpholdListViewController.hideKeyboard))
        //view.addGestureRecognizer(tap)
        CommonProcess.requestUpholdList(page: currentPage, type: self.currentViewType, customerId: currentCustomerId, status: "", view: self)
    }
    
    /**
     * Set data for controls
     */
    override func setData(_ notification: Notification) {
        if currentViewType == DomainConst.TYPE_TROUBLE {
            problemTableView.reloadData()
        } else {
            periodTableView.reloadData()
        }
    }
    
    /**
     * Clear data of view.
     */
    override func clearData() {
        Singleton.sharedInstance.clearUpholdList()
    }
    
    // MARK: - Textfield Delegate
    func hideKeyboard() {
        self.view.endEditing(true)
        isKeyboardShow = false
        self.view.removeGestureRecognizer(gestureHideKeyboard)
    }

    /**
     * Did receive memory warning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Override: show menu controller
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popOverMenu" {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    
    /**
     * ...
     */
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
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
    
    // MARK: - Action
    
//    func selectRowPicker(_ aButton:UIButton) {
//        let tagButton :Int = aButton.tag
//        print("tag :", tagButton)
//        lblStatusList.text = aStatusList[tagButton]
//        statusListView.isHidden = true
//        view2.isHidden = true
//    }
    
    
    //MARK: - UIPickerViewDelegate
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
        lblStatusList.text = aStatusList[row].name
        statusListView.isHidden = true
        view2.isHidden = true
    }
    
    // MARK: - UITableViewDataSource
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var count = NSInteger()
        if tableView == periodTableView {
            count = Singleton.sharedInstance.upholdList.record.count
        }
        if tableView == problemTableView {
            count = Singleton.sharedInstance.upholdList.record.count
        }
        if tableView == searchBarTableView {
            count = Singleton.sharedInstance.searchCustomerResult.record.count
        }

        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            var cellReturn = UITableViewCell()
            // Period view
            if tableView == periodTableView {
                let cell:periodTableViewCell = tableView.dequeueReusableCell(
                    withIdentifier: GlobalConst.PERIOD_TABLE_VIEW_CELL) as! periodTableViewCell
                if (Singleton.sharedInstance.upholdList.record.count > 0) {
                    cell.setData(model: Singleton.sharedInstance.upholdList.record[indexPath.row])
                }
                cellReturn = cell
            }
            
            // Problem view
            if tableView == problemTableView {
                let cell:problemTableViewCell = tableView.dequeueReusableCell(
                    withIdentifier: GlobalConst.PROBLEM_TABLE_VIEW_CELL) as! problemTableViewCell
                if (Singleton.sharedInstance.upholdList.record.count > 0) {
                    cell.setData(model: Singleton.sharedInstance.upholdList.record[indexPath.row])
                }
                cell.delegate = self
                cellReturn = cell
            }
            
            // Search bar view
            if tableView == searchBarTableView {
                let cell:SearchBarTableViewCell = tableView.dequeueReusableCell(
                    withIdentifier: GlobalConst.SEARCH_BAR_TABLE_VIEW_CELL) as! SearchBarTableViewCell
                //cell.textLabel?.text = customerData[(indexPath as NSIndexPath).row]
                if (Singleton.sharedInstance.searchCustomerResult.record.count > 0) {
                    cell.result.text = Singleton.sharedInstance.searchCustomerResult.record[indexPath.row].name
                }
//                if(searchActive){
//                    //cell.textLabel?.text = filtered[indexPath.row]
//                } else {
//                    cell.textLabel?.text = customerData[indexPath.row];
//                }

                cellReturn = cell
            }
            cellReturn.selectionStyle = .none
            return cellReturn
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat()
        if tableView == periodTableView {
            height = GlobalConst.CELL_HEIGHT_SHOW
            
        }
        if tableView == problemTableView {
            height = GlobalConst.CELL_HEIGHT_SHOW
        }
        if tableView == searchBarTableView {
            height = 50
        }
        return height
    }
    
    // MARK: - UITableViewDelegate
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Search bar
        if tableView == searchBarTableView {
            print("select: ", customerData[(indexPath as NSIndexPath).row])
            searchBarTableView.isHidden = true
            searchBox.resignFirstResponder()
            //searchBox.text = customerData[(indexPath as NSIndexPath).row]
            searchBox.text = Singleton.sharedInstance.searchCustomerResult.record[indexPath.row].name
            self.clearData()
            currentCustomerId = Singleton.sharedInstance.searchCustomerResult.record[indexPath.row].id
            CommonProcess.requestUpholdList(page: currentPage, type: currentViewType, customerId: currentCustomerId, status: "", view: self)
        }
        if tableView == problemTableView || tableView == periodTableView {
            let detail = self.mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.UPHOLDDETAIL_EMPLOYEE_VIEW_CTRL)
            self.navigationController?.pushViewController(detail, animated: true)
            let cell:problemTableViewCell = tableView.dequeueReusableCell(
                withIdentifier: GlobalConst.PROBLEM_TABLE_VIEW_CELL) as! problemTableViewCell
            cell.ratingButton.addTarget(self, action: #selector(toRatingVC), for: .touchUpInside)
        }
        
    }
    
    // MARK: to Uphold Rating VC - ProblemTableView Delegate
    func toRatingVC() {
        let ratingVC = self.mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.UPHOLD_RATING_VIEW_CTRL)
        self.navigationController?.pushViewController(ratingVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // If current view is search bar table view
        if tableView == searchBarTableView {
            return
        }
        // If current view is Uphold table view
        if (Singleton.sharedInstance.upholdList.record.count >= 10) {
            let lastElement = Singleton.sharedInstance.upholdList.record.count - 1
            if indexPath.row == lastElement {
                currentPage += 1
                CommonProcess.requestUpholdList(page: currentPage, type: self.currentViewType, customerId: currentCustomerId, status: "", view: self)
            }
        }
    }
    
    // MARK: - Begin Searching
    /**
     * Handle begin search
     */
    func beginSearching()  {
        if beginSearch == false {
            beginSearch = true
        }
        
        print("Call api search")
        // CAll API
        CommonProcess.requestSearchCustomer(keyword: searchBox.text!, view: self)
        
        // If Search seccess
        //searchBarTableView.isHidden = false
    }
    
    // MARK: - SearchbarDelegate
    
    //search bar action
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        filteredStr = searchText
        if filteredStr.characters.count > 4 {
            beginSearch = false
            searchActive = true
            // Start count
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpholdListViewController.beginSearching), userInfo: nil, repeats: false)
            
        } else {
            beginSearch = false
            searchActive = false
            // Show
            searchBarTableView.isHidden = !searchActive
        }
        //searchBarTableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        //NSNotificationCenter.defaultCenter().postNotificationName("showSearchBarTableView", object: nil)
        isKeyboardShow = true
        self.view.addGestureRecognizer(gestureHideKeyboard)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }


}
