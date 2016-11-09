//
//  CommonViewController.swift
//  project
//
//  Created by Nixforest on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class CommonViewController : UIViewController {
    // MARK: Properties
    /** Navigation bar */
    @IBOutlet weak var navigationBar: UINavigationItem!
    /** Menu button */
    @IBOutlet weak var menuButton: UIButton!
    /** Notification button */
    @IBOutlet weak var notificationButton: UIButton!
    /** Back button */
    @IBOutlet weak var backButton: UIButton!
    /** Flag check keyboard is show or hide */
    var isKeyboardShow : Bool = false
    /** Main story board */
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK: Methods
    /**
     * Notify turn on training mode
     */
    func trainingModeOn(_ notification: Notification) {
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
        GlobalConst.PARENT_BORDER_WIDTH = 0
        GlobalConst.BUTTON_COLOR_RED = ColorFromRGB().getColorFromRGB(0x38761D)
    }
    
    /**
     * Notify turn off training mode
     */
    func trainingModeOff(_ notification: Notification) {
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        GlobalConst.PARENT_BORDER_WIDTH = 0
        GlobalConst.BUTTON_COLOR_RED = ColorFromRGB().getColorFromRGB(0xF00020)
    }
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        //changeBackgroundColor(Singleton.sharedInstance.checkTrainningMode())
    }
    
    /**
     * TrainingMode on/off
     * - parameter isTrainingMode: Training mode flag
     */
    func changeBackgroundColor(_ isTrainingMode :Bool)  {
        if isTrainingMode {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
            GlobalConst.PARENT_BORDER_WIDTH = 5
        } else {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
            GlobalConst.PARENT_BORDER_WIDTH = 0
        }
    }
    
    /**
     * Set data
     */
    func setData(_ notification: Notification) {
        // Not implement
    }
    
    /**
     * Handle show alert message
     * - parameter message: Message content
     */
    func showAlert(message: String) -> Void {
        let alert = UIAlertController(title: GlobalConst.CONTENT00162, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: GlobalConst.CONTENT00008, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle show alert message
     * - parameter message: Message content
     * - parameter okHandler: Handler when tap OK button
     */
    func showAlert(message: String, okHandler:  @escaping (UIAlertAction) -> Swift.Void) -> Void {
        let alert = UIAlertController(title: GlobalConst.CONTENT00162, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: GlobalConst.CONTENT00008, style: .cancel, handler: okHandler)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle show alert message
     * - parameter message: Message content
     * - parameter okHandler: Handler when tap OK button
     * - parameter cancelHandler: Handler when tap Cancel button
     */
    func showAlert(message: String, okHandler: @escaping (UIAlertAction) -> Swift.Void, cancelHandler: @escaping (UIAlertAction) -> Swift.Void) -> Void {
        
        let alert = UIAlertController(title: GlobalConst.CONTENT00162, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: GlobalConst.CONTENT00008, style: .default, handler: okHandler)
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: GlobalConst.CONTENT00202, style: .cancel, handler: cancelHandler)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Asign notify for training mode change
     */
    func asignNotifyForTrainingModeChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.trainingModeOn(_:)), name:NSNotification.Name(rawValue: "TrainingModeOn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.trainingModeOff(_:)), name:NSNotification.Name(rawValue: "TrainingModeOff"), object: nil)
    }
    
    /**
     * Set up for navigation bar
     * - parameter title: Title of view
     * - parameter isNotifyEnable: True is enable notify button, False otherwise
     */
    func setupNavigationBar(title: String, isNotifyEnable: Bool, isHiddenBackBtn: Bool = false) {
        // Set title
        self.navigationBar.title = title
        // Set color text
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: GlobalConst.BUTTON_COLOR_RED]
        
        // Menu button
        let menu        = UIImage(named: GlobalConst.MENU_IMG_NAME)
        let tintedImg   = menu?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        menuButton.setImage(tintedImg, for: UIControlState())
        menuButton.tintColor    = GlobalConst.BUTTON_COLOR_RED
        menuButton.frame        = CGRect(x: 0, y: 0,
                                  width: GlobalConst.MENU_BUTTON_W,
                                  height: GlobalConst.MENU_BUTTON_H)
        menuButton.setTitle("", for: UIControlState())
        let menuNavBar          = UIBarButtonItem()
        menuNavBar.customView   = menuButton
        menuNavBar.isEnabled    = true
        
        // Notify button
        notificationButton.frame = CGRect(x: 0, y: 0,
                                          width: GlobalConst.MENU_BUTTON_W,
                                          height: GlobalConst.NOTIFY_BUTTON_H)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", for: UIControlState())
        notificationButton.setTitleColor(UIColor.white, for: UIControlState())
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        // Set status of notify button
        if isNotifyEnable {
            notificationButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        } else {
            notificationButton.backgroundColor = GlobalConst.BUTTON_COLOR_GRAY
        }
        let notifyNavBar = UIBarButtonItem()
        notifyNavBar.customView = notificationButton
        notifyNavBar.isEnabled = isNotifyEnable
        
        // Set on Navigation bar
        self.navigationItem.rightBarButtonItems = [menuNavBar, notifyNavBar]
        
        let back = UIImage(named: GlobalConst.BACK_IMG_NAME)
        let tintedBack = back?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedBack, for: UIControlState())
        backButton.tintColor = GlobalConst.BUTTON_COLOR_RED
        backButton.frame = CGRect(x: 0, y: 0,
                                  width: GlobalConst.MENU_BUTTON_W,
                                  height: GlobalConst.MENU_BUTTON_W)
        backButton.setTitle("", for: UIControlState())
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        backNavBar.isEnabled = true
        navigationBar.setLeftBarButton(backNavBar, animated: false)
        backButton.isHidden = isHiddenBackBtn
    }
    
    /**
     * Handle tap on Notification button
     * - parameter sender: AnyObject
     */
    func notificationButtonTapped(_ sender: AnyObject) {
        showAlert(message: Singleton.sharedInstance.notifyCountText)
    }
    
    /**
     * Handle tap on Back button
     * - parameter sender:AnyObject
     */
    func backButtonTapped(_ sender: AnyObject) {
        self.clearData()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /**
     * Handle when tap on Config menu item
     */
    func configItemTap(_ notification: Notification) {
        let config = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G00_CONFIGURATION_VIEW_CTRL)
        self.navigationController?.pushViewController(config, animated: true)
    }
    
    /**
     * Handle when tap on Home menu item
     */
    func gasServiceItemTapped(_ notification: Notification) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    /**
     * Handle when tap on Home menu item
     */
    func issueItemTapped(_ notification: Notification) {
        showAlert(message: "issueItemTapped")
    }
    
    /**
     * Handle when tap on Log out menu item
     */
    func logoutItemTapped(_ notification: Notification) {
        CommonProcess.requestLogout(view: self)
    }
    
    /**
     * Clear data on current view.
     */
    func clearData() {
        
    }
    
    /**
     * Update notification button status
     */
    func updateNotificationStatus() {
        self.notificationButton.isEnabled = !Singleton.sharedInstance.notifyCountText.isEmpty
        if !Singleton.sharedInstance.notifyCountText.isEmpty {
            self.notificationButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        } else {
            self.notificationButton.backgroundColor = GlobalConst.BUTTON_COLOR_GRAY
        }
    }
    
    /**
     * Update notification button status
     */
    func updateNotificationStatus(_ notification: Notification) {
        updateNotificationStatus()
    }
}
