//
//  HomeTableViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    var flag:NSInteger = 0
    //var loginStatusCarrier:NSUserDefaults! 
    var loginStatus:Bool = true
    
    
    
    
    @IBOutlet weak var homeNavBar: UINavigationItem!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    
    @IBAction func notificationButtonTapped(_ sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Back", style: .cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.present(notificationAlert, animated: true, completion: nil)
    }
    func configButtonTapped(_ notification: Notification){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let configVC = mainStoryboard.instantiateViewController(withIdentifier: "ConfigurationViewController")
        self.navigationController?.pushViewController(configVC, animated: true)
    }
    func pushToRegisterVC(_ notification: Notification){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let RegisterVC = mainStoryboard.instantiateViewController(withIdentifier: "RegisterViewController")
        self.navigationController?.pushViewController(RegisterVC, animated: true)
    }
    func logoutButtonTapped(_ notification: Notification){
        LoadingView.shared.showOverlay(view: self.view)
        CommonProcess.requestLogout()
        self.tableView.reloadData()
    }
    func issueButtonTapped(_ notification: Notification){
        let notificationAlert = UIAlertController(title: "Thông báo", message: "issueButtonTapped", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Back", style: .cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.present(notificationAlert, animated: true, completion: nil)
    }
    func pushToLoginVC(_ notification: Notification){
        //Take Action on Notification
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    
    var aList:[String]!
    var aListIcon:[String]!
    var aListText:[String]!
    
    func trainingModeOn(_ notification: Notification) {
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
    }
    func trainingModeOff(_ notification: Notification) {
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //training mode enable/disable
        NotificationCenter.default.addObserver(self, selector: #selector(HomeTableViewController.trainingModeOn(_:)), name:NSNotification.Name(rawValue: "TrainingModeOn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeTableViewController.trainingModeOff(_:)), name:NSNotification.Name(rawValue: "TrainingModeOff"), object: nil)
        
        //notification button enable/disable
        if Singleton.sharedInstance.checkIsLogin() == true {
            self.notificationButton.isEnabled = true
            self.notificationButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        } else {
            self.notificationButton.isEnabled = false
            self.notificationButton.backgroundColor = GlobalConst.BUTTON_COLOR_GRAY
        }
        
        view.backgroundColor = UIColor.gray
        
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        self.view.frame = view.frame.insetBy(dx: -GlobalConst.CELL_BORDER_WIDTH, dy: +GlobalConst.CELL_BORDER_WIDTH)
        
        
        //menu button tapped
        NotificationCenter.default.addObserver(self, selector: #selector(HomeTableViewController.pushToLoginVC(_:)), name:NSNotification.Name(rawValue: "loginButtonInHomeTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeTableViewController.pushToRegisterVC(_:)), name:NSNotification.Name(rawValue: "registerButtonInHomeTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeTableViewController.configButtonTapped(_:)), name:NSNotification.Name(rawValue: "configButtonInHomeTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeTableViewController.logoutButtonTapped(_:)), name:NSNotification.Name(rawValue: "logoutButtonInHomeTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeTableViewController.issueButtonTapped(_:)), name:NSNotification.Name(rawValue: "issueButtonInHomeTapped"), object: nil)
        
        //declare List
        aList = [GlobalConst.CONTENT00130, GlobalConst.CONTENT00041, GlobalConst.CONTENT00099, GlobalConst.CONTENT00098, GlobalConst.CONTENT00100]
        aListIcon = ["ordergas.png","CreateUpHold.jpeg", "UpHoldList.jpeg", "ServiceRating.jpeg", "Account.jpeg"]
        aListText = ["Đặt Gas","Yêu cầu bảo trì", "Danh sách bảo trì", "Đánh giá dịch vụ", "Tài khoản"]
        
        //Navigation Bar
        homeNavBar.title = GlobalConst.CONTENT00108
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]
        self.navigationItem.setHidesBackButton(true, animated:true);
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        menuButton.setImage(tintedImage, for: UIControlState())
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        
        //menuButton.addTarget(self, action: #selector(menuButtonTapped), forControlEvents: .TouchUpInside)
        //menuButton.setTitle("", forState: .Normal)
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.isEnabled = true //disable menu button
        
        //noti button on NavBar
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", for: UIControlState())
        notificationButton.setTitleColor(UIColor.white, for: UIControlState())
        //notificationButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        
        homeNavBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
     override func viewDidAppear(_ animated: Bool) {
        //notification button enable/disable
        if Singleton.sharedInstance.checkIsLogin() == true {
            self.notificationButton.isEnabled = true
            self.notificationButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        } else {
            self.notificationButton.isEnabled = false
            self.notificationButton.backgroundColor = GlobalConst.BUTTON_COLOR_GRAY
        }
        self.tableView.reloadData()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return aList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        
        let imgIcon:UIImageView = UIImageView(frame: CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.CELL_BORDER_WIDTH * 2, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.CELL_BORDER_WIDTH * 2, width: GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.CELL_BORDER_WIDTH) * 2, height: GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.CELL_BORDER_WIDTH) * 2))
        imgIcon.image = UIImage(named: aListIcon[(indexPath as NSIndexPath).row])
        cell.addSubview(imgIcon)
        let txtCellName:UILabel = UILabel(frame: CGRect(x: 110, y: 0, width: 200, height: 100))
        txtCellName.text = aListText[(indexPath as NSIndexPath).row]
        cell.addSubview(txtCellName)
        cell.tag = (indexPath as NSIndexPath).row
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        cell.layer.borderWidth = GlobalConst.CELL_BORDER_WIDTH
        cell.layer.borderColor = GlobalConst.CELL_BORDER_COLOR.cgColor
        
        let cellButton:UIButton = UIButton()
        cellButton.frame = CGRect(x: 0, y: 0, width: cell.contentView.frame.size.width, height: cell.contentView.frame.size.height);
        cellButton.tag = (indexPath as NSIndexPath).row
        cellButton.addTarget(self, action: #selector(cellAction(_ :)), for: UIControlEvents.touchUpInside)
        cell.contentView.addSubview(cellButton)
        
        //cell text color
        txtCellName.textColor = UIColor.white
        
        //cell background color
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0x29B6F6)
        case 1:
            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0x666666)
        case 2:
            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0xFAB102)
        case 3:
            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0xFF673E)
        case 4:
            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0x8C60FF)
        default: break
        }
        //show cell
        if Singleton.sharedInstance.checkIsLogin() == false {
            switch (indexPath as NSIndexPath).row {
                case 2:
                    cell.isHidden = true
                case 3:
                    cell.isHidden = true
                case 4:
                    cell.isHidden = true
                default: break
            }
        } else {
            switch (indexPath as NSIndexPath).row {
            case 2:
                cell.isHidden = false
            case 3:
                cell.isHidden = false
            case 4:
                cell.isHidden = false
            default: break
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight:CGFloat
        if loginStatus == false {
            if ((indexPath as NSIndexPath).row == 2) || ((indexPath as NSIndexPath).row == 3) || ((indexPath as NSIndexPath).row == 4) {
                rowHeight = GlobalConst.CELL_HEIGHT_HIDE
            } else {
                rowHeight = GlobalConst.CELL_HEIGHT_SHOW
            }
            
        } else {
            rowHeight = GlobalConst.CELL_HEIGHT_SHOW
        }
        return rowHeight
    }

    func cellAction(_ sender:UIButton) {
        switch sender.tag {
        case 1:
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let upholdListVC = mainStoryboard.instantiateViewController(withIdentifier: "CreateUpholdViewController")
            self.navigationController?.pushViewController(upholdListVC, animated: true)
        case 2:
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let upholdListVC = mainStoryboard.instantiateViewController(withIdentifier: "UpholdListViewController")
            self.navigationController?.pushViewController(upholdListVC, animated: true)

        case 4:
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let accountVC = mainStoryboard.instantiateViewController(withIdentifier: "AccountViewController")
            self.navigationController?.pushViewController(accountVC, animated: true)
        default:
            break
        }
    }

    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //popover menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverMenu" {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
            popoverVC.popoverPresentationController!
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    

}
