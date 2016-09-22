//
//  UpholdListViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/9/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdListViewController: UIViewController, UIPopoverPresentationControllerDelegate, UIPickerViewDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate {

    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var showProblemUpholdList:Bool! = true
    
    var aStatusList:[String]! = ["Mới", "Xử lý", "Hoàn thành", "Yêu cầu chuyển", "Xử lý dài ngày"]
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var upholdListNavBar: UINavigationItem!
    
    @IBOutlet weak var searchBox: UISearchBar!
    
    @IBOutlet weak var upholdListButton: UISegmentedControl!
    
    @IBOutlet weak var periodTableView: UITableView!
    @IBOutlet weak var problemTableView: UITableView!
    
    @IBOutlet weak var lblStatusList: UILabel!
    
    @IBOutlet weak var statusListView: UIView!
    
    
    @IBAction func upholdListChange(_ sender: AnyObject) {
        switch upholdListButton.selectedSegmentIndex
        {
        case 0:
            showProblemUpholdList = true
            periodTableView.isHidden = true
            problemTableView.isHidden = false

        case 1:
            showProblemUpholdList = false
            problemTableView.isHidden = true
            periodTableView.isHidden = false
            periodTableView.reloadData()
        default:
            break
        }
    }
    @IBAction func backButtonTapped(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func notificationButtonTapped(_ sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Back", style: .cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.present(notificationAlert, animated: true, completion: nil)
    }
            @IBAction func showStatusListButtonTapped(_ sender: AnyObject) {
        statusListView.isHidden = false
        showProblemUpholdList = true
                view2.isHidden = false

    }
    //training mode
    override func viewDidAppear(_ animated: Bool) {
        //training mode enable/disable
        if GlobalConst.TRAINING_MODE_FLAG == true {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
        } else {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        }
    }
    func gasServiceButtonInUpholdListVCTapped(_ notification: Notification) {
        self.navigationController?.popViewController(animated: true)
    }
    func issueButtonInUpholdListVCTapped(_ notification: Notification) {
        /*let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let configVC = mainStoryboard.instantiateViewControllerWithIdentifier("issueViewController")
         self.navigationController?.pushViewController(configVC, animated: true)
         */
        print("issue button tapped")
    }
    func configButtonInUpholdListVCTapped(_ notification: Notification) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let configVC = mainStoryboard.instantiateViewController(withIdentifier: "ConfigurationViewController")
        self.navigationController?.pushViewController(configVC, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view2.isHidden = true
        view2.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        view2.addSubview(blurEffectView)
        //cell
        self.periodTableView.register(UINib(nibName: "periodTableViewCell", bundle: nil), forCellReuseIdentifier: "periodTableViewCell")
        self.problemTableView.register(UINib(nibName: "problemTableViewCell", bundle: nil), forCellReuseIdentifier: "problemTableViewCell")

        //Notification
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdListViewController.gasServiceButtonInUpholdListVCTapped(_:)), name:NSNotification.Name(rawValue: "gasServiceButtonInUpholdListVCTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdListViewController.issueButtonInUpholdListVCTapped(_:)), name:NSNotification.Name(rawValue: "issueButtonInUpholdListVCTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdListViewController.configButtonInUpholdListVCTapped(_:)), name:NSNotification.Name(rawValue: "configButtonInUpholdListVCTapped"), object: nil)

        
        let borderWidth:CGFloat = 0x05
        self.view.layer.borderWidth = borderWidth
        //search box
        searchBox.placeholder = GlobalConst.CONTENT00060
        searchBox.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH , y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT , width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2 , height: GlobalConst.SEARCH_BOX_HEIGHT )
        searchBox.translatesAutoresizingMaskIntoConstraints = true
        //label status list + action
        lblStatusList.frame = CGRect(x: borderWidth, y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT, width: GlobalConst.SCREEN_WIDTH - borderWidth * 2, height: GlobalConst.LABEL_HEIGHT)
        lblStatusList.translatesAutoresizingMaskIntoConstraints = true
        lblStatusList.text = "Chọn trạng thái"
        lblStatusList.textColor = UIColor.gray
        lblStatusList.isUserInteractionEnabled = true
        let statusListTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UpholdListViewController.showStatusListButtonTapped))
        statusListTap.numberOfTapsRequired = 1
        lblStatusList.addGestureRecognizer(statusListTap)
        self.view.addSubview(lblStatusList)
        statusListTap.delegate = self
        //add Picker to View
        statusListView.isHidden = true
        statusListView.translatesAutoresizingMaskIntoConstraints = true
        statusListView.frame = CGRect(x: 0, y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT + GlobalConst.LABEL_HEIGHT, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.SCREEN_HEIGHT/4)
        
        let statusListPicker = UIPickerView()
        statusListPicker.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.SCREEN_HEIGHT/4)
        statusListPicker.backgroundColor = UIColor.white
        statusListPicker.delegate = self
        statusListView.addSubview(statusListPicker)
        //segment control - uphold button
        let font = UIFont.systemFont(ofSize: 15)
        upholdListButton.setTitleTextAttributes([NSFontAttributeName: font],
                                                for: UIControlState())
        
        upholdListButton.setTitle(GlobalConst.CONTENT00077, forSegmentAt: 0)
        upholdListButton.setTitle(GlobalConst.CONTENT00078, forSegmentAt: 1)
        upholdListButton.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        upholdListButton.layer.borderColor = ColorFromRGB().getColorFromRGB(0xF00020).cgColor
        upholdListButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        upholdListButton.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT + GlobalConst.LABEL_HEIGHT, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2 , height: GlobalConst.BUTTON_HEIGHT)
        upholdListButton.translatesAutoresizingMaskIntoConstraints = true
        //uphold list view
        problemTableView.translatesAutoresizingMaskIntoConstraints = true
        problemTableView.frame = CGRect(x: 0, y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT + GlobalConst.BUTTON_HEIGHT + GlobalConst.LABEL_HEIGHT , width: GlobalConst.SCREEN_WIDTH , height: GlobalConst.SCREEN_HEIGHT - GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT + CGFloat(GlobalConst.BUTTON_HEIGHT) + GlobalConst.LABEL_HEIGHT)
        
        periodTableView.translatesAutoresizingMaskIntoConstraints = true
        periodTableView.frame = CGRect(x: 0, y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT + GlobalConst.BUTTON_HEIGHT + GlobalConst.LABEL_HEIGHT, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.SCREEN_HEIGHT - GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.SEARCH_BOX_HEIGHT + GlobalConst.BUTTON_HEIGHT + GlobalConst.LABEL_HEIGHT)
        
        
        //show-hide UpholdList
        periodTableView.isHidden = true
        problemTableView.isHidden = false
        
        //Navigation Bar
        upholdListNavBar.title = GlobalConst.CONTENT00129
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]
        self.navigationItem.setHidesBackButton(true, animated:true);
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        menuButton.setImage(tintedImage, for: UIControlState())
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        
        //menuButton.addTarget(self, action: #selector(menuButtonTapped), forControlEvents: .TouchUpInside)
        menuButton.setTitle("", for: UIControlState())
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.isEnabled = true //disable menu button
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", for: UIControlState())
        notificationButton.setTitleColor(UIColor.white, for: UIControlState())
        notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        
        upholdListNavBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)

        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedBackLogo, for: UIControlState())
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        upholdListNavBar.setLeftBarButton(backNavBar, animated: false)
        // Do any additional setup after loading the view.
        
        
        periodTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "upholdListPopoverMenu" {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return aStatusList.count
    }
    
    // Delegate
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return aStatusList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblStatusList.text = aStatusList[row]
        statusListView.isHidden = true
        view2.isHidden = true

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var count = NSInteger()
        if tableView == periodTableView {
            count = 15
        }
        if tableView == problemTableView {
            count = 20
        }

        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            var cellReturn = UITableViewCell()
            if tableView == periodTableView {
                let cell:periodTableViewCell = tableView.dequeueReusableCell(withIdentifier: "periodTableViewCell") as! periodTableViewCell
                cellReturn = cell
            }
            if tableView == problemTableView {
                let cell:problemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "problemTableViewCell") as! problemTableViewCell
                cellReturn = cell
            }
        
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
        return height
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
