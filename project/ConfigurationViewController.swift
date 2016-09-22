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
    
    @IBOutlet weak var configView: UIView!
    @IBOutlet weak var configTableView: UITableView!
    
    @IBAction func backButtonTapped(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func notificationButtonTapped(_ sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Back", style: .cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.present(notificationAlert, animated: true, completion: nil)}
    
    //training mode
    override func viewDidAppear(_ animated: Bool) {
        //training mode enable/disable
        if GlobalConst.TRAINING_MODE_FLAG == true {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
        } else {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        }
        
        //notification button enable/disable
        if GlobalConst.LOGIN_STATUS == true {
            notificationButton.isEnabled = true
            notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)//when enable
        } else {
            notificationButton.isEnabled = false
            notificationButton.backgroundColor = UIColor.gray//when disable
        }
        
    }
    func trainingModeOn(_ notification: Notification) {
        configView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
    }
    func trainingModeOff(_ notification: Notification) {
        configView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor

        
        NotificationCenter.default.addObserver(self, selector: #selector(ConfigurationViewController.trainingModeOn(_:)), name:NSNotification.Name(rawValue: "TrainingModeOn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ConfigurationViewController.trainingModeOff(_:)), name:NSNotification.Name(rawValue: "TrainingModeOff"), object: nil)
        
        configView.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        configView.translatesAutoresizingMaskIntoConstraints = true
        
        configTableView.backgroundColor = ColorFromRGB().getColorFromRGB(0xECECEC)
        configTableView.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: configView.frame.size.width, height: configView.frame.size.height - GlobalConst.PARENT_BORDER_WIDTH)
        configTableView.translatesAutoresizingMaskIntoConstraints = true
        searchBar.placeholder = GlobalConst.CONTENT00128
        
        
        configurationNavBar.title = GlobalConst.CONTENT00128
        
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        menuButton.setImage(tintedImage, for: UIControlState())
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        menuButton.setTitle("", for: UIControlState())
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.isEnabled = true //disable menu button
        //noti button on NavBar
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", for: UIControlState())
        notificationButton.setTitleColor(UIColor.white, for: UIControlState())
        //notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)//when enable
        notificationButton.backgroundColor = UIColor.gray//when disable
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        notificationNavBar.isEnabled = false
        
        configurationNavBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)
        //back button
        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedBackLogo, for: UIControlState())
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        backButton.setTitle("", for: UIControlState())
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        configurationNavBar.setLeftBarButton(backNavBar, animated: false)

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
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    //cell action
    func cellAction(_ sender:UIButton) {
        switch sender.tag {
            
                
            case 1:
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let InfoVC = mainStoryboard.instantiateViewController(withIdentifier: "InfomationViewController")
                self.navigationController?.pushViewController(InfoVC, animated: true)
            default:
                break
        }
    }

    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfigurationTableViewCell", for: indexPath) as! ConfigurationTableViewCell
        
        //custom cell
        switch (indexPath as NSIndexPath).row {
            case 0:
                cell.rightImg.isHidden = true
                cell.mySw.isHidden = false
                cell.leftImg.image = UIImage(named: "TrainingModeIcon.png")
                cell.nameLbl.text = GlobalConst.CONTENT00138
            case 1:
                cell.rightImg.isHidden = false
                cell.mySw.isHidden = true
                cell.leftImg.image = UIImage(named: "InfoIcon.png")
                cell.rightImg.image = UIImage(named: "back.png")
                cell.rightImg.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
                cell.nameLbl.text = GlobalConst.CONTENT00139
                let cellButton:UIButton = UIButton()
                cellButton.frame = CGRect(x: 0, y: 0, width: cell.contentView.frame.size.width, height: cell.contentView.frame.size.height)
                cellButton.tag = (indexPath as NSIndexPath).row
                cellButton.addTarget(self, action: #selector(cellAction(_ :)), for: UIControlEvents.touchUpInside)
                cell.contentView.addSubview(cellButton)
            

            default:
                break
            
        }
        
        return cell //ConfigurationTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverMenu" {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

}
