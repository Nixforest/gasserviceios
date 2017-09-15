//
//  AppDelegate.swift
//  project
//
//  Created by Lâm Phạm on 7/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import UserNotifications
import harpyframework
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //var loginStatus:Bool = false

    internal var rootNav:UINavigationController = UINavigationController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Register push notifications
        registerForPushNotifications(application: application)
        
        // Override point for customization after application launch.
        //self.window?.rootViewController = testViewController()
        //self.window?.makeKeyWindow()
 
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        SlideMenuOptions.leftViewWidth = GlobalConst.POPOVER_WIDTH
        SlideMenuOptions.panGesturesEnabled = true
        SlideMenuOptions.hideStatusBar = false
        //-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        
        //let firstVC = mainStoryboard.instantiateViewController(withIdentifier: DomainConst.G00_HOME_VIEW_CTRL)
        let firstVC = mainStoryboard.instantiateViewController(withIdentifier: G04Const.G04_F01_S01_VIEW_CTRL) as! ParentViewController
        rootNav = UINavigationController(rootViewController: firstVC)
        rootNav.isNavigationBarHidden = false
        
        //++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        let slide = BaseSlideMenuViewController(mainViewController: rootNav,
                                        leftMenuViewController: mainStoryboard.instantiateViewController(withIdentifier: "BaseMenuViewController"))
        slide.delegate = firstVC
        //-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        self.window?.rootViewController = slide
        self.window?.makeKeyAndVisible()
 
        //----- Handle notification receive -----
        if let notification = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [String: AnyObject] {
            handleNotification(data: notification)
        }
        
        // Google maps
        //let key = "AIzaSyDpiyIoQSxkj1GAqwUSxk-3wxxUcuQa_6k"
        //let key = "AIzaSyBAp4n2BAmthIPvaF4FCOmQ19WEnb6trfs"
        let key = DomainConst.GOOGLE_API_KEY
        GMSServices.provideAPIKey(key)
        GMSPlacesClient.provideAPIKey(key)
        // Google Direct API
        // AIzaSyB9aMZnBX9TENtEDdhsJtpGI8kfbSFtKgo
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    /**
     * Register for push notifications
     * - parameter application: Application
     */
    func registerForPushNotifications(application: UIApplication) {
        // iOS 10 support
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.badge, .alert, .sound],
                completionHandler: { (granted, error) in })
            application.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            application.registerForRemoteNotifications(matching: [.badge, .alert, .sound])
        }
    }
    
//    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
//        if notificationSettings.types != .none {
//            application.registerForRemoteNotifications()
//        }
//    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        BaseModel.shared.setDeviceToken(token: tokenString)
        print(tokenString)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error when register device token: ", error)
    }
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        print("receive notification 2")
//    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        let data = userInfo as! [String: AnyObject]
        handleNotification(data: data, isManual: true)
        
    }
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, willCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([UNNotificationPresentOptions.alert, UNNotificationPresentOptions.sound,
//                           UNNotificationPresentOptions.badge   ])
//    }
    
    /**
     * Handle when receive notification
     * - parameter data: Data object
     */
    func handleNotification(data: [String: AnyObject], isManual: Bool = false) {
        let notifyType  = data["notify_type"] as? String ?? ""
        let id          = data["id"] as? String ?? ""
        let notifyId    = data["notify_id"] as? String ?? ""
        let type        = data["type"] as? String ?? ""
        let replyId     = data["reply_id"] as? String ?? ""
        let message     = data["spj_message"] as? String ?? ""
        
        // Save to setting
        BaseModel.shared.setNotificationData(id: id, notify_id: notifyId, notify_type: notifyType, type: type, reply_id: replyId, message: message)
        let notify = NotificationBean.init(id: id, notify_id: notifyId,
                                           notify_type: notifyType, type: type,
                                           reply_id: replyId, message: message)
        if let currentView = BaseViewController.getCurrentViewController() {
            currentView.handleNotification(notify: notify, isManual: isManual)
        }
        
        //++ BUG0049-SPJ (NguyenPT 20170313) Handle notification received
//        // Create alert
//        if isManual && BaseModel.shared.canHandleNotification() {
//            let alert = UIAlertController(title: DomainConst.CONTENT00044, message: message, preferredStyle: .alert)
//            let okAction = UIAlertAction(title: DomainConst.CONTENT00223, style: .default, handler: {
//                (alert: UIAlertAction!) in
//                ConfirmNotifyRequest.requestConfirmNotify(notifyId: notifyId, type: type, objId: id)
//                if let navigationController = self.window?.rootViewController as? UINavigationController {
//                    if navigationController.visibleViewController is G00HomeVC {
//                        navigationController.visibleViewController?.viewDidAppear(true)
//                    } else {
//                        navigationController.popToRootViewController(animated: true)
//                    }
//                }
//            })
//            alert.addAction(okAction)
//            let cancelAction = UIAlertAction(title: DomainConst.CONTENT00224, style: .cancel, handler: {
//                (alert: UIAlertAction!) in
//                if let navigationController = self.window?.rootViewController as? UINavigationController {
//                    //++ BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
////                    RequestAPI.requestNotificationCount(view: (navigationController.visibleViewController as! BaseViewController))
//                    let view = (navigationController.visibleViewController as! BaseViewController)
//                    NotificationCountRequest.requestNotificationCount(action: #selector(view.emptyMethod(_:)), view: view)
//                    //-- BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
//                }
//                BaseModel.shared.clearNotificationData()
//            })
//            alert.addAction(cancelAction)
//            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
//        } else {
//            // Reply confirm notify to server
//            ConfirmNotifyRequest.requestConfirmNotify(notifyId: notifyId, type: type, objId: id)
//        }
        //-- BUG0049-SPJ (NguyenPT 20170313) Handle notification received
        
        // Move to detail
        print(message)
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return UIInterfaceOrientationMask.portrait
        case .pad:
            return UIInterfaceOrientationMask.portrait
        default:
            break
        }
        return UIInterfaceOrientationMask.all
    }
}

