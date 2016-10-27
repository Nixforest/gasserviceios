//
//  HomeViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/20/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class HomeViewController: CommonViewController, UIPopoverPresentationControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    var loginStatus:Bool = true
    
    var aList:[String] = [GlobalConst.CONTENT00130, GlobalConst.CONTENT00041, GlobalConst.CONTENT00099, GlobalConst.CONTENT00098, GlobalConst.CONTENT00100]
    var aListIcon:[String] = ["ordergas.png","CreateUpHold.jpeg", "UpHoldList.jpeg", "ServiceRating.jpeg", "Account.jpeg"]
    var aListText:[String] = ["Đặt Gas","Yêu cầu bảo trì", "Danh sách bảo trì", "Đánh giá dịch vụ", "Tài khoản"]
    
    @IBOutlet weak var homeTableView: UITableView!
    
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
        CommonProcess.requestLogout(view: self.view)
        self.homeTableView.reloadData()
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
    
    //MARK: ViewDidLoad
     override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Background
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        // MARK: ViewBackgnd Frame
        homeTableView.translatesAutoresizingMaskIntoConstraints = true
        homeTableView.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: 0, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.SCREEN_HEIGHT)
        homeTableView.backgroundColor = GlobalConst.PARENT_BORDER_COLOR_GRAY
        homeTableView.separatorStyle = .none
        //MARK: NavBar setup
        setupNavigationBar(title: GlobalConst.CONTENT00108, isNotifyEnable: false)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.pushToLoginVC(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_LOGIN_ITEM), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.pushToRegisterVC(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_REGISTER_ITEM), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.configButtonTapped(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM_HOMEVIEW), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.logoutButtonTapped(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_LOGOUT_ITEM), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.issueButtonTapped(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_ISSUE_ITEM), object: nil)
        
        /**
         * Cell register
         */
        self.homeTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
//        self.homeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
//        self.homeTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        // Do any additional setup after loading the view.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.homeCellImageView.image = UIImage(named: aListIcon[(indexPath as NSIndexPath).row])
        cell.titleLbl.text = aListText[(indexPath as NSIndexPath).row]
        //cell text color
        cell.titleLbl.textColor = UIColor.white
        //cell selection style
        cell.selectionStyle = UITableViewCellSelectionStyle.none
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        switch indexPath.row {
        case 1:
            //let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let upholdListVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G01_F01_VIEW_CTRL)
            self.navigationController?.pushViewController(upholdListVC, animated: true)
        case 2:
            //let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let upholdListVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G01_F00_S01_VIEW_CTRL)
            self.navigationController?.pushViewController(upholdListVC, animated: true)
        case 4:
            //let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let accountVC = mainStoryboard.instantiateViewController(withIdentifier: "AccountViewController")
            self.navigationController?.pushViewController(accountVC, animated: true)
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
        if !Singleton.sharedInstance.isLogin {
            self.notificationButton.isEnabled = true
            self.notificationButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        } else {
            self.notificationButton.isEnabled = false
            self.notificationButton.backgroundColor = GlobalConst.BUTTON_COLOR_GRAY
        }
        self.homeTableView.reloadData()
    }
}
