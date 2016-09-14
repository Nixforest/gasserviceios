//
//  HomeTableViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController,UIPopoverPresentationControllerDelegate {

    var flag:NSInteger = 0
    //var loginStatusCarrier:NSUserDefaults! 
    var loginStatus:Bool = true
    
    
    
    
    @IBOutlet weak var homeNavBar: UINavigationItem!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    
    @IBAction func notificationButtonTapped(sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Back", style: .Cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.presentViewController(notificationAlert, animated: true, completion: nil)
    }
    func configButtonTapped(notification: NSNotification){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let configVC = mainStoryboard.instantiateViewControllerWithIdentifier("ConfigurationViewController")
        self.navigationController?.pushViewController(configVC, animated: true)
    }
    func pushToRegisterVC(notification: NSNotification){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let RegisterVC = mainStoryboard.instantiateViewControllerWithIdentifier("RegisterViewController")
        self.navigationController?.pushViewController(RegisterVC, animated: true)
    }
    func logoutButtonTapped(notification: NSNotification){
        self.tableView.reloadData()
    }
    func issueButtonTapped(notification: NSNotification){
        let notificationAlert = UIAlertController(title: "Thông báo", message: "issueButtonTapped", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Back", style: .Cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.presentViewController(notificationAlert, animated: true, completion: nil)
    }
    func pushToLoginVC(notification: NSNotification){
        //Take Action on Notification
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = mainStoryboard.instantiateViewControllerWithIdentifier("LoginViewController")
        self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    
    var aList:[String]!
    var aListIcon:[String]!
    var aListText:[String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //transmit login status
        /*loginStatusCarrier = NSUserDefaults()
        loginStatus = (loginStatusCarrier.objectForKey("loginStatus") as? Bool)!
        //notification button enable/disable
        if loginStatus == true {
            notificationButton.enabled = true
        } else {
            notificationButton.enabled = false
        }*/
        
        view.backgroundColor = UIColor.grayColor()
        
        let borderWidth:CGFloat = 0x05
        self.view.frame = CGRectInset(view.frame, -borderWidth, +borderWidth)
        self.view.layer.borderWidth = borderWidth
        
        //menu button tapped
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.pushToLoginVC(_:)), name:"loginButtonInHomeTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.pushToRegisterVC(_:)), name:"registerButtonInHomeTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.configButtonTapped(_:)), name:"configButtonInHomeTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.logoutButtonTapped(_:)), name:"logoutButtonInHomeTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.issueButtonTapped(_:)), name:"issueButtonInHomeTapped", object: nil)
        
        //declare List
        aList = [GlobalConst.CONTENT00113, GlobalConst.CONTENT00041, GlobalConst.CONTENT00099, GlobalConst.CONTENT00098, GlobalConst.CONTENT00100]
        aListIcon = ["ordergas.png","CreateUpHold.jpeg", "UpHoldList.jpeg", "ServiceRating.jpeg", "Account.jpeg"]
        aListText = ["Đặt Gas","Yêu cầu bảo trì", "Danh sách bảo trì", "Đánh giá dịch vụ", "Tài khoản"]
        
        //Navigation Bar
        homeNavBar.title = GlobalConst.CONTENT00108
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]
        self.navigationItem.setHidesBackButton(true, animated:true);
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        menuButton.setImage(tintedImage, forState: .Normal)
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        
        //menuButton.addTarget(self, action: #selector(menuButtonTapped), forControlEvents: .TouchUpInside)
        //menuButton.setTitle("", forState: .Normal)
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.enabled = true //disable menu button
        
        //noti button on NavBar
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", forState: .Normal)
        notificationButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), forControlEvents: .TouchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        
        homeNavBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
     override func viewDidAppear(animated: Bool) {
        let grayColor = UIColor.grayColor().CGColor
        let yellowColor = UIColor.yellowColor().CGColor
        if GlobalConst.TRAINING_MODE_FLAG == true {
            self.view.layer.borderColor = yellowColor
        } else {
                    self.view.layer.borderColor = grayColor
        }
        self.tableView.reloadData()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return aList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath)
        
        let imgIcon:UIImageView = UIImageView(frame: CGRectMake(5, 5, 90, 90))
        imgIcon.image = UIImage(named: aListIcon[indexPath.row])
        cell.addSubview(imgIcon)
        let txtCellName:UILabel = UILabel(frame: CGRectMake(110, 0, 200, 100))
        txtCellName.text = aListText[indexPath.row]
        cell.addSubview(txtCellName)
        cell.tag = indexPath.row
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let cellButton:UIButton = UIButton()
        cellButton.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
        cellButton.tag = indexPath.row
        cellButton.addTarget(self, action: #selector(cellAction(_ :)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.contentView.addSubview(cellButton)
        
        //cell text color
        txtCellName.textColor = UIColor.whiteColor()
        
        //cell background color
        switch indexPath.row {
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
        if GlobalConst.LOGIN_STATUS == false {
            switch indexPath.row {
                case 2:
                    cell.hidden = true
                case 3:
                    cell.hidden = true
                case 4:
                    cell.hidden = true
                default: break
            }
        } else {
            switch indexPath.row {
            case 2:
                cell.hidden = false
            case 3:
                cell.hidden = false
            case 4:
                cell.hidden = false
            default: break
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var rowHeight:CGFloat = 0.0
        if loginStatus == false {
            if (indexPath.row == 2) || (indexPath.row == 3) || (indexPath.row == 4) {
                rowHeight = 0.0
            } else {
                rowHeight = 100.0
            }
            
        } else {
            rowHeight = 100.0
        }
        return rowHeight
    }

    func cellAction(sender:UIButton) {
        switch sender.tag {
        case 2:
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let upholdListVC = mainStoryboard.instantiateViewControllerWithIdentifier("UpholdListViewController")
            self.navigationController?.pushViewController(upholdListVC, animated: true)

        case 4:
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let accountVC = mainStoryboard.instantiateViewControllerWithIdentifier("AccountViewController")
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popoverMenu" {
            let popoverVC = segue.destinationViewController
            popoverVC.popoverPresentationController?.delegate = self
            popoverVC.popoverPresentationController!
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    

}
