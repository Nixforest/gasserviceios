//
//  ConfigurationViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/12/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var configurationNavBar: UINavigationItem!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var configTableView: UITableView!
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func notificationButtonTapped(sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Back", style: .Cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.presentViewController(notificationAlert, animated: true, completion: nil)}
    
    //training mode
    override func viewDidAppear(animated: Bool) {
        let grayColor = UIColor.grayColor().CGColor
        let yellowColor = UIColor.yellowColor().CGColor
        if GlobalConst.TRAINING_MODE_FLAG == true {
            self.view.layer.borderColor = yellowColor
        } else {
            self.view.layer.borderColor = grayColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView.backgroundColor = ColorFromRGB().getColorFromRGB(0xECECEC)
        searchBar.placeholder = GlobalConst.CONTENT00128
        
        
        configurationNavBar.title = GlobalConst.CONTENT00128
        
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        menuButton.setImage(tintedImage, forState: .Normal)
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        menuButton.setTitle("", forState: .Normal)
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.enabled = true //disable menu button
        //noti button on NavBar
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", forState: .Normal)
        notificationButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        //notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)//when enable
        notificationButton.backgroundColor = UIColor.grayColor()//when disable
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), forControlEvents: .TouchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        notificationNavBar.enabled = false
        
        configurationNavBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)
        //back button
        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        backButton.setImage(tintedBackLogo, forState: .Normal)
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        backButton.setTitle("", forState: .Normal)
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        configurationNavBar.setLeftBarButtonItem(backNavBar, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ConfigurationTableViewCell", forIndexPath: indexPath) as! ConfigurationTableViewCell
        
        //custom cell
        switch indexPath.row {
            case 0:
                cell.rightImg.hidden = true
                cell.mySw.hidden = false
                cell.leftImg.image = UIImage(named: "TrainingModeIcon.png")
                cell.nameLbl.text = GlobalConst.CONTENT00138
            case 1:
                cell.rightImg.hidden = false
                cell.mySw.hidden = true
                cell.leftImg.image = UIImage(named: "InfoIcon.png")
                cell.rightImg.image = UIImage(named: "back.png")
                cell.rightImg.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI)) / 180.0)
                cell.nameLbl.text = GlobalConst.CONTENT00139
            default:
                break
            
        }
        
        return cell //ConfigurationTableViewCell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popoverMenu" {
            let popoverVC = segue.destinationViewController
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

}
