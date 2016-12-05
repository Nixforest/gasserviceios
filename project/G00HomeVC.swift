//
//  HomeViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/20/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G00HomeVC: CommonViewController, UIPopoverPresentationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    // MARK: Properties
    /** List text content */
    var aList:[String] = [GlobalConst.CONTENT00130, GlobalConst.CONTENT00041, GlobalConst.CONTENT00099, GlobalConst.CONTENT00098, GlobalConst.CONTENT00100]
    /** List icon image */
    var aListIcon:[String] = ["ordergas.png","upholdRequest.png", "UpHoldList.jpeg", "ServiceRating.jpeg", "Account.jpeg"]
    /** Table view */
    @IBOutlet weak var homeTableView: UITableView!
    
    // MARK: Actions
    /**
     * Handle tap on Register menu item
     * - parameter sender:AnyObject
     */
    func pushToRegisterVC(_ notification: Notification){
//        let RegisterVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.REGISTER_VIEW_CTRL)
//        self.navigationController?.pushViewController(RegisterVC, animated: true)
        showAlert(message: GlobalConst.CONTENT00197)
    }
    
    /**
     * Handle tap on Login menu item
     * - parameter sender:AnyObject
     */
    func pushToLoginVC(_ notification: Notification){
        moveToLoginVC()
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configItemTap(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM_HOMEVIEW),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(pushToRegisterVC(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_REGISTER_ITEM),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(logoutItemTapped(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_LOGOUT_ITEM),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(issueItemTapped(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_ISSUE_ITEM), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushToLoginVC(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_LOGIN_ITEM), object: nil)
    }
    
    //MARK: ViewDidLoad
     override func viewDidLoad() {
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        // MARK: Background
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        // MARK: ViewBackgnd Frame
        let marginX: CGFloat = 0.0
        let marginY: CGFloat = 0.0
        homeTableView.translatesAutoresizingMaskIntoConstraints = true
        homeTableView.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + marginX,
                                     y: marginY,
                                     width: GlobalConst.SCREEN_WIDTH - 2 * marginX,
                                     height: GlobalConst.SCREEN_HEIGHT - 2 * marginY)
        homeTableView.backgroundColor = GlobalConst.PARENT_BORDER_COLOR_GRAY
        homeTableView.separatorStyle = .none
        //MARK: NavBar setup
        setupNavigationBar(title: GlobalConst.CONTENT00108, isNotifyEnable: Singleton.sharedInstance.checkIsLogin(), isHiddenBackBtn: true)
        
        /**
         * Cell register
         */
        self.homeTableView.register(UINib(nibName: GlobalConst.G00_HOME_CELL, bundle: nil), forCellReuseIdentifier: GlobalConst.G00_HOME_CELL)
        
        // Notify set data
        NotificationCenter.default.addObserver(self, selector: #selector(G00HomeVC.setData(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_HOMEVIEW), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotificationStatus(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_UPDATE_NOTIFY_HOMEVIEW), object: nil)
        // Get data from server
        if Singleton.sharedInstance.checkIsLogin() {
            CommonProcess.requestUpdateConfiguration(view: self)
        }
    }
    
    /**
     * Set data.
     */
    override func setData(_ notification: Notification) {
        self.homeTableView.reloadData()
        self.updateNotificationStatus()
        // Get notification count from server
        if Singleton.sharedInstance.checkIsLogin() {
            CommonProcess.requestNotificationCount(view: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /**
     * Override: show menu controller
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GlobalConst.POPOVER_MENU_IDENTIFIER {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return aList.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConst.G00_HOME_CELL, for: indexPath) as! G00HomeCell
        cell.homeCellImageView.image = UIImage(named: aListIcon[(indexPath as NSIndexPath).row])
        cell.titleLbl.text = aList[(indexPath as NSIndexPath).row]
        // cell text color
        cell.titleLbl.textColor = UIColor.white
        // cell selection style
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        // cell background color
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
        setShowHideItem(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    /**
     * Handle show/hide item on home view
     * - parameter cell:        Cell item
     * - parameter indexPath:   Indexpath
     */
    func setShowHideItem(cell: G00HomeCell, indexPath: IndexPath) {
        // User is logging
        if Singleton.sharedInstance.checkIsLogin() {
            switch (indexPath as NSIndexPath).row {
            case 0:         // Order gas
                //cell.isHidden = !Singleton.sharedInstance.isCustomerUser()
                cell.isHidden = true
            case 1:         // Create uphold
                cell.isHidden = !Singleton.sharedInstance.checkAllowAccess(key: DomainConst.KEY_UPHOLD_CREATE)
            case 2:         // Uphold list
                cell.isHidden = !Singleton.sharedInstance.checkAllowAccess(key: DomainConst.KEY_UPHOLD_LIST)
            case 3:         // Uphold rating
                cell.isHidden = !Singleton.sharedInstance.checkAllowAccess(key: DomainConst.KEY_UPHOLD_RATING)
            case 4:         // Account -> Always show
                cell.isHidden = false
            default: break
            }
        } else {    // Not login
            switch (indexPath as NSIndexPath).row {
            case 0:      // Order gas + Create uphold -> Always show
                //cell.isHidden = false
                cell.isHidden = true
            case 1, 2, 3, 4:   // Uphold list + Uphold rating + Account -> Always hide
                cell.isHidden = true
            default: break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return setCellHeight(indexPath: indexPath)
    }
    
    /**
     * Set cell height
     * - parameter indexPath:   Indexpath
     */
    func setCellHeight(indexPath: IndexPath) -> CGFloat {
        var rowHeight: CGFloat = 0.0
        if Singleton.sharedInstance.checkIsLogin() {
            switch (indexPath as NSIndexPath).row {
            case 0:         // Order gas
                //rowHeight = Singleton.sharedInstance.isCustomerUser() ? GlobalConst.CELL_HEIGHT_SHOW : GlobalConst.CELL_HEIGHT_HIDE
                rowHeight = 0
            case 1:         // Create uphold
                rowHeight = Singleton.sharedInstance.checkAllowAccess(key: DomainConst.KEY_UPHOLD_CREATE) ? GlobalConst.CELL_HEIGHT_SHOW : GlobalConst.CELL_HEIGHT_HIDE
            case 2:         // Uphold list
                rowHeight = Singleton.sharedInstance.checkAllowAccess(key: DomainConst.KEY_UPHOLD_LIST) ? GlobalConst.CELL_HEIGHT_SHOW : GlobalConst.CELL_HEIGHT_HIDE
            case 3:         // Uphold rating
                rowHeight = Singleton.sharedInstance.checkAllowAccess(key: DomainConst.KEY_UPHOLD_RATING) ? GlobalConst.CELL_HEIGHT_SHOW : GlobalConst.CELL_HEIGHT_HIDE
            case 4:         // Account -> Always show
                rowHeight = GlobalConst.CELL_HEIGHT_SHOW
            default: break
            }
        } else {    // Not login
            switch (indexPath as NSIndexPath).row {
            case 0:      // Order gas + Create uphold -> Always show
                //rowHeight = GlobalConst.CELL_HEIGHT_SHOW
                rowHeight = 0
            case 1, 2, 3, 4:   // Uphold list + Uphold rating + Account -> Always hide
                rowHeight = GlobalConst.CELL_HEIGHT_HIDE
            default: break
            }
        }
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let upholdListVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G01_F01_VIEW_CTRL)
            self.navigationController?.pushViewController(upholdListVC, animated: true)
        case 2:
            //let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let upholdListVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G01_F00_S01_VIEW_CTRL)
            self.navigationController?.pushViewController(upholdListVC, animated: true)
        case 4:
            //let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let accountVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G00_ACCOUNT_VIEW_CTRL)
            self.navigationController?.pushViewController(accountVC, animated: true)
        case 3:
            if !Singleton.sharedInstance.lastUpholdId.isEmpty {
                Singleton.sharedInstance.sharedString = Singleton.sharedInstance.lastUpholdId
                let ratingVC = self.mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G01_F03_VIEW_CTRL)
                self.navigationController?.pushViewController(ratingVC, animated: true)
            }
        default:
            break
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func viewDidAppear(_ animated: Bool) {
        //notification button enable/disable
        self.updateNotificationStatus()
        self.homeTableView.reloadData()
        // Get notification count from server
        if Singleton.sharedInstance.checkIsLogin() {
            CommonProcess.requestNotificationCount(view: self)
        }
        // Check open by notification
        if Singleton.sharedInstance.checkNotificationExist() {
            if Singleton.sharedInstance.checkIsLogin() {
                if Singleton.sharedInstance.isUpholdNotification() {
                    let upholdListVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G01_F00_S01_VIEW_CTRL)
                    self.navigationController?.pushViewController(upholdListVC, animated: true)
                }
            } else {
                moveToLoginVC()
            }
        }
    }
    
    /**
     * Move to login view
     */
    func moveToLoginVC() {
        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G00_LOGIN_VIEW_CTRL)
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
