//
//  UpholdListViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/9/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdListViewController: UIViewController, UIPopoverPresentationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var width = UIScreen.mainScreen().bounds.width
    var height = UIScreen.mainScreen().bounds.height
    
    var filteredStr = String()
    var searchActive:Bool = false
    var beginSearch:Bool = false
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    
    
    var showProblemUpholdList:Bool! = true
    
    var aStatusList:[String]! = ["Mới", "Xử lý", "Hoàn thành", "Yêu cầu chuyển", "Xử lý dài ngày"]
    var statusIndex = Int()
    
    var timer = NSTimer()
    
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var upholdListNavBar: UINavigationItem!
    
    @IBOutlet weak var searchBox: UISearchBar!
    
    
    @IBOutlet weak var upholdListButton: UISegmentedControl!
    
    @IBOutlet weak var periodTableView: UITableView!
    @IBOutlet weak var problemTableView: UITableView!
    @IBOutlet weak var searchBarTableView: UITableView!
    
    @IBOutlet weak var lblStatusList: UILabel!
    
    @IBOutlet weak var statusListView: UIView!
    
    
    @IBAction func upholdListChange(sender: AnyObject) {
        switch upholdListButton.selectedSegmentIndex
        {
        case 0:
            showProblemUpholdList = true
            periodTableView.hidden = true
            problemTableView.hidden = false

        case 1:
            showProblemUpholdList = false
            problemTableView.hidden = true
            periodTableView.hidden = false
            periodTableView.reloadData()
        default:
            break
        }
    }
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func notificationButtonTapped(sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Back", style: .Cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.presentViewController(notificationAlert, animated: true, completion: nil)
    }
            @IBAction func showStatusListButtonTapped(sender: AnyObject) {
        statusListView.hidden = false
        showProblemUpholdList = true
                view2.hidden = false

    }
    //training mode
    override func viewDidAppear(animated: Bool) {
        //training mode enable/disable
        if GlobalConst.TRAINING_MODE_FLAG == true {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.CGColor
        } else {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.CGColor
        }
    }
    func gasServiceButtonInUpholdListVCTapped(notification: NSNotification) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func issueButtonInUpholdListVCTapped(notification: NSNotification) {
        /*let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let configVC = mainStoryboard.instantiateViewControllerWithIdentifier("issueViewController")
         self.navigationController?.pushViewController(configVC, animated: true)
         */
        print("issue button tapped")
    }
    func configButtonInUpholdListVCTapped(notification: NSNotification) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let configVC = mainStoryboard.instantiateViewControllerWithIdentifier("ConfigurationViewController")
        self.navigationController?.pushViewController(configVC, animated: true)
    }
    func showSearchBarTableView(notification: NSNotification) {
        searchBarTableView.hidden = !searchActive
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //blur view when status list picker active
        view2.hidden = true
        view2.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        view2.addSubview(blurEffectView)
        //cell
        self.periodTableView.registerNib(UINib(nibName: "periodTableViewCell", bundle: nil), forCellReuseIdentifier: "periodTableViewCell")
        self.problemTableView.registerNib(UINib(nibName: "problemTableViewCell", bundle: nil), forCellReuseIdentifier: "problemTableViewCell")
        self.searchBarTableView.registerNib(UINib(nibName: "searchBarTableViewCell", bundle: nil), forCellReuseIdentifier: "searchBarTableViewCell")
        //Notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UpholdListViewController.gasServiceButtonInUpholdListVCTapped(_:)), name:"gasServiceButtonInUpholdListVCTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UpholdListViewController.issueButtonInUpholdListVCTapped(_:)), name:"issueButtonInUpholdListVCTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UpholdListViewController.configButtonInUpholdListVCTapped(_:)), name:"configButtonInUpholdListVCTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UpholdListViewController.showSearchBarTableView(_:)), name:"showSearchBarTableView", object: nil)
        
        let borderWidth:CGFloat = 0x05
        self.view.layer.borderWidth = borderWidth
        //search bar
        searchBox.placeholder = GlobalConst.CONTENT00060
        searchBox.translatesAutoresizingMaskIntoConstraints = true
        searchBox.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH , y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT , width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2 , height: GlobalConst.SEARCH_BOX_HEIGHT )
        searchBox.delegate = self
        //show hide result of search bar action
        searchBarTableView.translatesAutoresizingMaskIntoConstraints = true
        searchBarTableView.hidden = !searchActive
        searchBarTableView.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2, height: GlobalConst.CELL_IN_SEARCHBAR_TABLE_HEIGHT * 5)
        searchBarTableView.delegate = self
        searchBarTableView.dataSource = self
        
        //label status list + action
        lblStatusList.frame = CGRect(x: borderWidth, y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT, width: GlobalConst.SCREEN_WIDTH - borderWidth * 2, height: GlobalConst.LABEL_HEIGHT)
        lblStatusList.translatesAutoresizingMaskIntoConstraints = true
        lblStatusList.text = "Chọn trạng thái"
        lblStatusList.textColor = UIColor.grayColor()
        lblStatusList.userInteractionEnabled = true
        let statusListTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UpholdListViewController.showStatusListButtonTapped))
        statusListTap.numberOfTapsRequired = 1
        lblStatusList.addGestureRecognizer(statusListTap)
        self.view.addSubview(lblStatusList)
        statusListTap.delegate = self
        //add Picker to View
        statusListView.hidden = true
        statusListView.translatesAutoresizingMaskIntoConstraints = true
        statusListView.frame = CGRect(x: 0, y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT + GlobalConst.LABEL_HEIGHT, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.SCREEN_HEIGHT/4)
        
        let statusListPicker = UIPickerView()
        statusListPicker.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.SCREEN_HEIGHT/4)
        statusListPicker.backgroundColor = UIColor.whiteColor()
        statusListPicker.delegate = self
        statusListView.addSubview(statusListPicker)
        //segment control - uphold button
        let font = UIFont.systemFontOfSize(15)
        upholdListButton.setTitleTextAttributes([NSFontAttributeName: font],
                                                forState: UIControlState.Normal)
        
        upholdListButton.setTitle(GlobalConst.CONTENT00077, forSegmentAtIndex: 0)
        upholdListButton.setTitle(GlobalConst.CONTENT00078, forSegmentAtIndex: 1)
        upholdListButton.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        upholdListButton.layer.borderColor = ColorFromRGB().getColorFromRGB(0xF00020).CGColor
        upholdListButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        upholdListButton.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT + GlobalConst.LABEL_HEIGHT, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2 , height: GlobalConst.BUTTON_HEIGHT)
        upholdListButton.translatesAutoresizingMaskIntoConstraints = true
        //uphold list view
        problemTableView.translatesAutoresizingMaskIntoConstraints = true
        problemTableView.frame = CGRectMake(0, GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT + GlobalConst.BUTTON_HEIGHT + GlobalConst.LABEL_HEIGHT , GlobalConst.SCREEN_WIDTH , GlobalConst.CELL_HEIGHT_SHOW * 4)
        
        periodTableView.translatesAutoresizingMaskIntoConstraints = true
        periodTableView.frame = CGRectMake(0, GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT + GlobalConst.BUTTON_HEIGHT + GlobalConst.LABEL_HEIGHT, GlobalConst.SCREEN_WIDTH, GlobalConst.CELL_HEIGHT_SHOW * 4)
        
        
        //show-hide UpholdList
        periodTableView.hidden = true
        problemTableView.hidden = false
        
        //Navigation Bar
        upholdListNavBar.title = GlobalConst.CONTENT00129
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]
        self.navigationItem.setHidesBackButton(true, animated:true);
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        menuButton.setImage(tintedImage, forState: .Normal)
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        
        //menuButton.addTarget(self, action: #selector(menuButtonTapped), forControlEvents: .TouchUpInside)
        menuButton.setTitle("", forState: .Normal)
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.enabled = true //disable menu button
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", forState: .Normal)
        notificationButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), forControlEvents: .TouchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        
        upholdListNavBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)

        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        backButton.setImage(tintedBackLogo, forState: .Normal)
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        upholdListNavBar.setLeftBarButtonItem(backNavBar, animated: false)
        // Do any additional setup after loading the view.
        
        
        periodTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "upholdListPopoverMenu" {
            let popoverVC = segue.destinationViewController
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return aStatusList.count
    }
    
    //MARK: - Action
    
    func selectRowPicker(aButton:UIButton) {
        let tagButton :Int = aButton.tag
        print("tag :", tagButton)
        lblStatusList.text = aStatusList[tagButton]
        statusListView.hidden = true
        view2.hidden = true
    }
    
    
    //MARK: - UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return aStatusList[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statusIndex = row
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let aView = UIView()
        aView.frame = CGRectMake(0, 0, pickerView.frame.size.width, 30)
        let aButton = UIButton()
        aButton.frame = CGRectMake(0, 0, pickerView.frame.size.width/2, 30)
        aButton.userInteractionEnabled = true
        aView.userInteractionEnabled = true
        aButton.tag = row
        aButton.addTarget(self, action: #selector(UpholdListViewController.tsat), forControlEvents: .TouchUpInside)
        aView.addSubview(aButton)
        aButton.backgroundColor = UIColor.redColor()
        
        return aView
    }
    
    func tsat()  {
        print("")
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var count = NSInteger()
        if tableView == periodTableView {
            count = 15
        }
        if tableView == problemTableView {
            count = 20
        }
        if tableView == searchBarTableView {
            count = data.count
        }

        return count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
            var cellReturn = UITableViewCell()
            if tableView == periodTableView {
                let cell:periodTableViewCell = tableView.dequeueReusableCellWithIdentifier("periodTableViewCell") as! periodTableViewCell
                cellReturn = cell
            }
            if tableView == problemTableView {
                let cell:problemTableViewCell = tableView.dequeueReusableCellWithIdentifier("problemTableViewCell") as! problemTableViewCell
                cellReturn = cell
            }
            if tableView == searchBarTableView {
                let cell:SearchBarTableViewCell = tableView.dequeueReusableCellWithIdentifier("searchBarTableViewCell") as! SearchBarTableViewCell
                 cell.textLabel?.text = data[indexPath.row];
//                if(searchActive){
//                    //cell.textLabel?.text = filtered[indexPath.row]
//                } else {
//                    cell.textLabel?.text = data[indexPath.row];
//                }

                cellReturn = cell
            }
        
            return cellReturn
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == searchBarTableView {
            print("select: ", data[indexPath.row])
            searchBarTableView.hidden = true
            searchBox.resignFirstResponder()
            searchBox.text = data[indexPath.row]
        }
    }
    
    // MARK: - Begin Searching
    
    func beginSearching()  {
        if beginSearch == false {
            beginSearch = true
        }
        
        print("Call api search")
        // CAll API
        
        // If Search seccess
        searchBarTableView.hidden = false
    }
    
    // MARK: - SearchbarDelegate
    
    //search bar action
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        filteredStr = searchText
        if filteredStr.characters.count > 4 {
            beginSearch = false
            searchActive = true
            // Start count
            timer.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(UpholdListViewController.beginSearching), userInfo: nil, repeats: false)
            
        }else {
            beginSearch = false
            searchActive = false
        }
        //searchBarTableView.reloadData()
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        //NSNotificationCenter.defaultCenter().postNotificationName("showSearchBarTableView", object: nil)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }


}
