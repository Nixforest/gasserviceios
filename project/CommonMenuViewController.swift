//
//  CommonMenuViewController.swift
//  project
//
//  Created by Nixforest on 10/10/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class CommonMenuViewController : UIViewController {
    /** List menu flag */
    var listMenu: [Bool] = []
    
    /** Login item: button */
    var loginBtn = UIButton()
    /** Login item: icon */
    var iconLogin = UIImageView()
    
    /** Logout item: button */
    var logoutBtn = UIButton()
    /** Logout item: icon */
    var iconLogout = UIImageView()
    
    /** Register item: button */
    var regBtn = UIButton()
    /** Register item: icon */
    var iconReg = UIImageView()
    
    /** Gas service item: button */
    var gasServiceBtn = UIButton()
    /** Gas service item: icon */
    var iconGasService = UIImageView()
    
    /** Issue item: button */
    var issueBtn = UIButton()
    /** Issue item: icon */
    var iconIssue = UIImageView()
    
    /** Config item: button */
    var configBtn = UIButton()
    /** Config item: icon */
    var iconConfig = UIImageView()
    
    /**
     * Set menu item flag values
     * - parameter listValues: List of values
     */
    func setItem(listValues: [Bool]) {
        if listValues.count <= MenuItemEnum.MENUITEM_NUM.hashValue {
            for item in listValues {
                listMenu.append(item)
            }
        }
    }
    
    /**
     * Setup for menu items view
     */
    func setupMenuItem() {
        // Valid data menu
        if listMenu.count < MenuItemEnum.MENUITEM_NUM.hashValue {
            return
        }
        // Offset
        var offset: CGFloat = 0.0
        
        // Login menu
        if listMenu[MenuItemEnum.LOGIN.hashValue] {
            setItemContent(title: GlobalConst.CONTENT00051, iconPath: "loginMenu.png", action: #selector(loginItemTapped), button: loginBtn, icon: iconLogin, offset: offset)
            offset += GlobalConst.BUTTON_HEIGHT
        }
        
        // Logout menu
        if listMenu[MenuItemEnum.LOGOUT.hashValue] {
            setItemContent(title: GlobalConst.CONTENT00132, iconPath: "logout.png", action: #selector(logoutItemTapped), button: logoutBtn, icon: iconLogout, offset: offset)
            offset += GlobalConst.BUTTON_HEIGHT
        }
        
        // Register menu
        if listMenu[MenuItemEnum.REGISTER.hashValue] {
            setItemContent(title: GlobalConst.CONTENT00052, iconPath: "regMenu.png", action: #selector(registerItemTapped), button: regBtn, icon: iconReg, offset: offset)
            offset += GlobalConst.BUTTON_HEIGHT
        }
        
        // Gas service menu
        if listMenu[MenuItemEnum.GAS_SERVICE.hashValue] {
            setItemContent(title: GlobalConst.CONTENT00127, iconPath: "gasservice.png", action: #selector(gasServiceItemTapped), button: gasServiceBtn, icon: iconGasService, offset: offset)
            offset += GlobalConst.BUTTON_HEIGHT
        }
        
        // Issue menu
        if listMenu[MenuItemEnum.ISSUE_MAN.hashValue] {
            setItemContent(title: GlobalConst.CONTENT00131, iconPath: "issueMenu.png", action: #selector(issueItemTapped), button: issueBtn, icon: iconIssue, offset: offset)
            offset += GlobalConst.BUTTON_HEIGHT
        }
        
        // Configuration menu
        if listMenu[MenuItemEnum.CONFIG.hashValue] {
            setItemContent(title: GlobalConst.CONTENT00128, iconPath: "config.png", action: #selector(configItemTapped), button: configBtn, icon: iconConfig, offset: offset)
            offset += GlobalConst.BUTTON_HEIGHT
        }
        self.preferredContentSize = CGSize(width: 170, height: offset)
    }
    
    /**
     * Set menu items content
     * - parameter title: Title of item
     * - parameter iconPath: Path of icon image
     * - parameter action: Action when tab on item
     * - parameter button: Button object
     * - parameter icon: Icon image
     * - parameter offset: Y offset
     */
    func setItemContent(title: String, iconPath: String, action: Selector,
                        button: UIButton, icon: UIImageView, offset: CGFloat) {
        // Icon
        icon.image = UIImage(named: iconPath)
        icon.translatesAutoresizingMaskIntoConstraints = true
        icon.frame = CGRect(x: GlobalConst.MARGIN,
                            y: offset + GlobalConst.MARGIN,
                            width: GlobalConst.BUTTON_HEIGHT - 2 * GlobalConst.MARGIN,
                            height: GlobalConst.BUTTON_HEIGHT - 2 * GlobalConst.MARGIN)
        
        // Button
        button.translatesAutoresizingMaskIntoConstraints = true
        button.frame = CGRect(x: GlobalConst.MARGIN + icon.frame.maxX,
                              y: offset,
                              width: GlobalConst.POPOVER_WIDTH,
                              height: GlobalConst.BUTTON_HEIGHT)
        button.backgroundColor = UIColor.white
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(GlobalConst.BUTTON_COLOR_RED, for: UIControlState())
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: action, for: .touchUpInside)
        
        self.view.addSubview(button)
        self.view.addSubview(icon)
    }
    
    // MARK: Actions
    /**
     * Handle tap on login item.
     * - parameter sender: AnyObject
     */
    func loginItemTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_LOGIN_ITEM), object: nil)
        }
    }
    
    /**
     * Handle tap on logout item.
     * - parameter sender: AnyObject
     */
    func logoutItemTapped(_ sender: AnyObject) {
        Singleton.sharedInstance.logoutSuccess()
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_LOGOUT_ITEM), object: nil)
        }
    }
    
    /**
     * Handle tap on register item.
     * - parameter sender: AnyObject
     */
    func registerItemTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_REGISTER_ITEM), object: nil)
        }
    }
    
    /**
     * Handle tap on gas service item.
     * - parameter sender: AnyObject
     */
    func gasServiceItemTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_GAS_SERVICE_ITEM), object: nil)
        }
    }
    
    /**
     * Handle tap on issue item.
     * - parameter sender: AnyObject
     */
    func issueItemTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_ISSUE_ITEM), object: nil)
        }
    }
    
    /**
     * Handle tap on configuration item.
     * - parameter sender: AnyObject
     */
    func configItemTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM), object: nil)
        }
    }
}
