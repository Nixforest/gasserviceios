//
//  HomeViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/20/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework
import GoogleMaps

//++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
//class G00HomeVC: BaseViewController, UITableViewDataSource, UITableViewDelegate {
class G00HomeVC: MapViewController, UITableViewDataSource, UITableViewDelegate {
//-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
    // MARK: Properties
    //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
//    /** List text content */
//    var aList:[String] = [DomainConst.CONTENT00130, DomainConst.CONTENT00041, DomainConst.CONTENT00099, DomainConst.CONTENT00098, DomainConst.CONTENT00100]
    /** Function list */
    private var funcList:       [ConfigBean] = [ConfigBean]()
    //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
    
    /** List icon image */
    var aListIcon:[String] = [
        DomainConst.ORDER_GAS_IMG_NAME,
        DomainConst.UPHOLD_REQUEST_IMG_NAME,
        DomainConst.UPHOLD_LIST_IMG_NAME,
        DomainConst.SERVICE_RATING_IMG_NAME,
        DomainConst.ACCOUNT_IMG_NAME
    ]
    /** Table view */
    @IBOutlet weak var homeTableView: UITableView!
    
    // MARK: Actions
    //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
//    /**
//     * Handle when tap menu item
//     */
//    func asignNotifyForMenuItem() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(configItemTap(_:)),
//                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_COFIG_ITEM_HOMEVIEW),
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(registerItemTapped(_:)),
//                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_REGISTER_ITEM),
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(logoutItemTapped(_:)),
//                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_LOGOUT_ITEM),
//                                               object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(issueItemTapped(_:)),
//                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_ISSUE_ITEM), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(loginItemTapped(_:)),
//                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_LOGIN_ITEM), object: nil)
//    }
    //-- BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
    
    //MARK: ViewDidLoad
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        enableContent(isEnabled: false)
        //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        //-- BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
//        // Menu item tap
//        asignNotifyForMenuItem()
        //-- BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
        
        // Handle display color when training mode is on
//        if BaseModel.shared.checkTrainningMode() {
//            GlobalConst.BUTTON_COLOR_RED = GlobalConst.TRAINING_COLOR
//        } else {    // Training mode off
//            GlobalConst.BUTTON_COLOR_RED = GlobalConst.MAIN_COLOR
//        }
        
        // Background
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        // ViewBackgnd Frame
        let marginX: CGFloat = 0.0
        let marginY: CGFloat = 0.0
        homeTableView.translatesAutoresizingMaskIntoConstraints = true
        homeTableView.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + marginX,
                                     y: marginY,
                                     width: GlobalConst.SCREEN_WIDTH - 2 * marginX,
                                     //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
                                     //height: GlobalConst.SCREEN_HEIGHT - 2 * marginY)
                                     height: GlobalConst.SCREEN_HEIGHT - marginY)
                                     //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        homeTableView.backgroundColor = GlobalConst.PARENT_BORDER_COLOR_GRAY
        homeTableView.separatorStyle = .none
        //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        // Move to front
        //homeTableView.layer.zPosition = 1
        //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        
        // NavBar setup
        //++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        //setupNavigationBar(title: DomainConst.CONTENT00108, isNotifyEnable: BaseModel.shared.checkIsLogin(), isHiddenBackBtn: true)
        createNavigationBar(title: DomainConst.CONTENT00108)
        //-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        
        /** Cell register */
        self.homeTableView.register(UINib(nibName: DomainConst.G00_HOME_CELL, bundle: nil), forCellReuseIdentifier: DomainConst.G00_HOME_CELL)
        
        // Notify set data
        //++ BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
//        NotificationCenter.default.addObserver(self, selector: #selector(G00HomeVC.setData(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_HOMEVIEW), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(updateNotificationStatus(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_UPDATE_NOTIFY_HOMEVIEW), object: nil)
        //-- BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
        
        //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        // Get data from server
//        if BaseModel.shared.checkIsLogin() {
//            //++ BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
////            RequestAPI.requestUpdateConfiguration(view: self)
//            UpdateConfigurationRequest.requestUpdateConfiguration(action: #selector(self.finishRequestUpdateConfig(_:)),
//                                                                  view: self)
//            //-- BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
//        }
        //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        
        // Handle waiting register code confirm
        if !BaseModel.shared.getTempToken().isEmpty {
            self.processInputConfirmCode(message: "")
        }
    }
    
    //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
    /**
     * Set data.
     */
//    override func setData(_ notification: Notification) {
//        super.setData(notification)
//        self.funcList.removeAll()
//        //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
//        for item in BaseModel.shared.getListOfMenus() {
//            if item.id != DomainConst.HOME {
//                self.funcList.append(item)
//            }
//        }
//        //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
//        self.homeTableView.reloadData()
//        self.updateNotificationStatus()
//        
//        // Get notification count from server
//        if BaseModel.shared.checkIsLogin() {
//            //++ BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
////            RequestAPI.requestNotificationCount(view: self)
//            NotificationCountRequest.requestNotificationCount(action: #selector(updateNotificationStatus(_:)), view: self)
//            //-- BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
//        }
//    }
    override func finishRequestUpdateConfig(_ notification: Notification) {
        super.finishRequestUpdateConfig(notification)
        self.funcList.removeAll()
        //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        for item in BaseModel.shared.getListOfMenus() {
            if item.id != DomainConst.HOME {
                self.funcList.append(item)
            }
        }
        //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        self.homeTableView.reloadData()
    }
    //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home

    /**
     * Did receive memory warning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table view setup
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        //return aList.count
        return funcList.count
        //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.G00_HOME_CELL, for: indexPath) as! G00HomeCell
        //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
//        cell.homeCellImageView.image = ImageManager.getImage(named: aListIcon[(indexPath as NSIndexPath).row])
//        cell.titleLbl.text = aList[(indexPath as NSIndexPath).row]
//        // cell text color
//        cell.titleLbl.textColor = UIColor.white
//        // cell selection style
//        cell.selectionStyle = UITableViewCellSelectionStyle.none
//        // cell background color
//        switch (indexPath as NSIndexPath).row {
//        case 0:
//            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0x29B6F6)
//        case 1:
//            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0x666666)
//        case 2:
//            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0xFAB102)
//        case 3:
//            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0xFF673E)
//        case 4:
//            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0x8C60FF)
//        default: break
//        }
        //setShowHideItem(cell: cell, indexPath: indexPath)
        
        cell.setData(icon: BaseMenuViewController.getMenuIcon(
            id: funcList[indexPath.row].id), text: funcList[indexPath.row].name)
        cell.makeComponentsColor()
        //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        
        return cell
    }
    
    //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
//    /**
//     * Handle show/hide item on home view
//     * - parameter cell:        Cell item
//     * - parameter indexPath:   Indexpath
//     */
//    func setShowHideItem(cell: G00HomeCell, indexPath: IndexPath) {
//        // User is logging
//        if BaseModel.shared.checkIsLogin() {
//            switch (indexPath as NSIndexPath).row {
//            case 0:         // Order gas
//                //cell.isHidden = !BaseModel.shared.isCustomerUser()
//                cell.isHidden = true
//            case 1:         // Create uphold
//                cell.isHidden = !BaseModel.shared.checkAllowAccess(key: DomainConst.KEY_UPHOLD_CREATE)
//            case 2:         // Uphold list
//                cell.isHidden = !BaseModel.shared.checkAllowAccess(key: DomainConst.KEY_UPHOLD_LIST)
//            case 3:         // Uphold rating
//                cell.isHidden = !BaseModel.shared.checkAllowAccess(key: DomainConst.KEY_UPHOLD_RATING)
//            case 4:         // Account -> Always show
//                cell.isHidden = false
//            default: break
//            }
//        } else {    // Not login
//            switch (indexPath as NSIndexPath).row {
//            case 0:      // Order gas + Create uphold -> Always show
//                //cell.isHidden = false
//                cell.isHidden = true
//            case 1, 2, 3, 4:   // Uphold list + Uphold rating + Account -> Always hide
//                cell.isHidden = true
//            default: break
//            }
//        }
//    }
    //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
        //return setCellHeight(indexPath: indexPath)
        return GlobalConst.ACCOUNT_AVATAR_H / 2
        //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
    }
    
    //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
//    /**
//     * Set cell height
//     * - parameter indexPath:   Indexpath
//     */
//    func setCellHeight(indexPath: IndexPath) -> CGFloat {
//        var rowHeight: CGFloat = 0.0
//        if BaseModel.shared.checkIsLogin() {
//            switch (indexPath as NSIndexPath).row {
//            case 0:         // Order gas
//                //rowHeight = BaseModel.shared.isCustomerUser() ? GlobalConst.CELL_HEIGHT_SHOW : GlobalConst.CELL_HEIGHT_HIDE
//                rowHeight = 0
//            case 1:         // Create uphold
//                rowHeight = BaseModel.shared.checkAllowAccess(key: DomainConst.KEY_UPHOLD_CREATE) ? GlobalConst.CELL_HEIGHT_SHOW : GlobalConst.CELL_HEIGHT_HIDE
//            case 2:         // Uphold list
//                rowHeight = BaseModel.shared.checkAllowAccess(key: DomainConst.KEY_UPHOLD_LIST) ? GlobalConst.CELL_HEIGHT_SHOW : GlobalConst.CELL_HEIGHT_HIDE
//            case 3:         // Uphold rating
//                rowHeight = BaseModel.shared.checkAllowAccess(key: DomainConst.KEY_UPHOLD_RATING) ? GlobalConst.CELL_HEIGHT_SHOW : GlobalConst.CELL_HEIGHT_HIDE
//            case 4:         // Account -> Always show
//                rowHeight = GlobalConst.CELL_HEIGHT_SHOW
//            default: break
//            }
//        } else {    // Not login
//            switch (indexPath as NSIndexPath).row {
//            case 0:      // Order gas + Create uphold -> Always show
//                //rowHeight = GlobalConst.CELL_HEIGHT_SHOW
//                rowHeight = 0
//            case 1, 2, 3, 4:   // Uphold list + Uphold rating + Account -> Always hide
//                rowHeight = GlobalConst.CELL_HEIGHT_HIDE
//            default: break
//            }
//        }
//        return rowHeight
//    }
    //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
//        switch indexPath.row {
//        case 1:     // New uphold
//            if BaseModel.shared.user_info == nil {
//                // User information does not exist
//                //++ BUG0046-SPJ (NguyenPT 20170301) Use action for Request server completion
//                //RequestAPI.requestUserProfile(action: #selector(emptyMethod(_:)), view: self)
//                UserProfileRequest.requestUserProfile(action: #selector(emptyMethod(_:)), view: self)
//                //-- BUG0046-SPJ (NguyenPT 20170301) Use action for Request server completion
//            }
//            self.pushToView(name: DomainConst.G01_F01_VIEW_CTRL)
//        case 2: // List uphold
//            self.pushToView(name: DomainConst.G01_F00_S01_VIEW_CTRL)
//        case 4: // User profile
//            self.pushToView(name: DomainConst.G00_ACCOUNT_VIEW_CTRL)
//        case 3:
//            if !BaseModel.shared.lastUpholdId.isEmpty {
//                BaseModel.shared.sharedString = BaseModel.shared.lastUpholdId
//                // Move to G01_F03 rating view
//                self.pushToView(name: DomainConst.G01_F03_VIEW_CTRL)
//            }
//        default:
//            break
//        }
        switch funcList[indexPath.row].id {
        case DomainConst.USER_PROFILE:                      // User profile
            self.pushToViewAndClearData(name: DomainConst.G00_ACCOUNT_VIEW_CTRL)
            break
        case DomainConst.UPHOLD_LIST:                       // Uphold list
            self.pushToViewAndClearData(name: DomainConst.G01_F00_S01_VIEW_CTRL)
            break
        case DomainConst.ISSUE_LIST:                        // Issue list
            self.showAlert(message: DomainConst.CONTENT00362)
            break
        case DomainConst.MESSAGE:                           // Message
            self.pushToViewAndClearData(name: G03F00S01VC.theClassName)
            break
        case DomainConst.CUSTOMER_LIST:                     // Customer list
            self.pushToViewAndClearData(name: DomainConst.G06_F00_S01_VC)
            break
        case DomainConst.WORKING_REPORT:                    // Working report
            self.pushToViewAndClearData(name: DomainConst.G06_F00_S04_VC)
            break
        case DomainConst.ORDER_LIST:                        // Order list
            self.pushToViewAndClearData(name: DomainConst.G04_F00_S01_VIEW_CTRL)
            break
        case DomainConst.ORDER_VIP_LIST:                    // VIP order list
            if BaseModel.shared.isCustomerUser() {
                self.pushToViewAndClearData(name: DomainConst.G05_F00_S01_VIEW_CTRL)
            } else {
                self.pushToViewAndClearData(name: DomainConst.G05_F00_S03_VIEW_CTRL)
            }
            break
        case DomainConst.KEY_MENU_PROMOTION_LIST:           // Promotion list
            self.pushToViewAndClearData(name: DomainConst.G04_F02_S01_VIEW_CTRL)
            break
        case DomainConst.ORDER_TRANSACTION_LIST:
            self.pushToViewAndClearData(name: DomainConst.G07_F00_S01_VC)
        case DomainConst.KEY_MENU_STORE_CARD_LIST:
            self.pushToViewAndClearData(name: DomainConst.G08_F00_S01_VC)
            break
        case DomainConst.KEY_MENU_CASH_BOOK_LIST:
            BaseModel.shared.sharedString = DomainConst.CASHBOOK_TYPE_LIST
            self.pushToViewAndClearData(name: DomainConst.G09_F00_S01_VC)
            break
        case DomainConst.KEY_MENU_CASH_BOOK_SCHEDULE:
            BaseModel.shared.sharedString = DomainConst.CASHBOOK_TYPE_SCHEDULE
            self.pushToViewAndClearData(name: DomainConst.G09_F00_S03_VC)
            break
        case DomainConst.KEY_MENU_FAMILY_UPHOLD_LIST:
            self.pushToViewAndClearData(name: DomainConst.G01_F00_S04_VC)
            break
        case DomainConst.KEY_MENU_REPORT_LIST:
            self.pushToViewAndClearData(name: DomainConst.G10_F00_S01_VC)
            break
        case DomainConst.KEY_MENU_TICKET_LIST:
            self.pushToViewAndClearData(name: DomainConst.G11_F00_S01_VC)
            break
        case DomainConst.KEY_MENU_GOOGLE_MAP:
            self.pushToViewAndClearData(name: G05F01S01VC.theClassName)
            break
        case DomainConst.KEY_MENU_CCS_CODE_LIST:
            self.pushToViewAndClearData(name: G06F00S06VC.theClassName)
        //++ BUG0183-SPJ (NguyenPT 20171227) Gas remain function
        case DomainConst.KEY_MENU_GAS_REMAIN:
            let view = G14F00S01VC(nibName: G14F00S01VC.theClassName, bundle: nil)
            self.navigationController?.pushViewController(view, animated: true)
            break
        //-- BUG0183-SPJ (NguyenPT 20171227) Gas remain function
        default:
            self.showAlert(message: DomainConst.CONTENT00362)
        }
        //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
    }
    
    /**
     * View did appear
     */
    override func viewDidAppear(_ animated: Bool) {
        //notification button enable/disable
        self.updateNotificationStatus()
        self.homeTableView.reloadData()
        
        // Get notification count from server
        if BaseModel.shared.checkIsLogin() {
            //++ BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
//            RequestAPI.requestNotificationCount(view: self)
            NotificationCountRequest.requestNotificationCount(action: #selector(updateNotificationStatus(_:)), view: self)
            //-- BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
        }
        
        //++ BUG0049-SPJ (NguyenPT 20170313) Handle notification received
        // Check open by notification
//        if BaseModel.shared.checkNotificationExist() {
//            if BaseModel.shared.checkIsLogin() {
//                if BaseModel.shared.isUpholdNotification() {
//                    self.pushToView(name: DomainConst.G01_F00_S01_VIEW_CTRL)
//                }
//            } else {
//                moveToLoginVC()
//            }
//        }
        //-- BUG0049-SPJ (NguyenPT 20170313) Handle notification received
        
        // Handle display color when training mode is on
//        if BaseModel.shared.checkTrainningMode() {
//            GlobalConst.BUTTON_COLOR_RED = GlobalConst.TRAINING_COLOR
//        } else {    // Training mode off
//            GlobalConst.BUTTON_COLOR_RED = GlobalConst.MAIN_COLOR
//        }
    }
    
    /**
     * Move to login view
     */
    func moveToLoginVC() {
        self.pushToView(name: DomainConst.G00_LOGIN_VIEW_CTRL)
    }
//    override func loadView() {
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view.addSubview(mapView)
//        
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }
}
