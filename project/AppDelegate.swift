//
//  AppDelegate.swift
//  project
//
//  Created by Lâm Phạm on 7/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import UserNotifications

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
        
        let firstVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G00_HOME_VIEW_CTRL)
        rootNav = UINavigationController(rootViewController: firstVC)
        rootNav.isNavigationBarHidden = false
        
        self.window?.rootViewController = rootNav
 
        // Handle notification receive
        if let notification = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [String: AnyObject] {
            handleNotification(data: notification)
        }
        
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
        let notificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert],
                                                              categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != .none {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        Singleton.sharedInstance.setDeviceToken(token: tokenString)
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
        Singleton.sharedInstance.setNotificationData(id: id, notify_id: notifyId, notify_type: notifyType, type: type, reply_id: replyId, message: message)
        
        // Create alert
        // Create alert
        if isManual {
//            let notification = UILocalNotification()
//            notification.fireDate = NSDate(timeIntervalSinceNow: 5) as Date
//            notification.alertBody = message
//            notification.alertAction = "be awesome!"
//            notification.soundName = UILocalNotificationDefaultSoundName
//            notification.userInfo = data
//            UIApplication.shared.scheduleLocalNotification(notification)
            
//            let notifiAlert = UIAlertView()
//            notifiAlert.title = GlobalConst.CONTENT00044
//            notifiAlert.message = message
//            notifiAlert.addButton(withTitle: "OK")
//            notifiAlert.addButton(withTitle: "Cancel")
//            notifiAlert.dismiss(withClickedButtonIndex: 1, animated: true)
//            //notifiAlert.
//            notifiAlert.show()
            let alert = UIAlertController(title: GlobalConst.CONTENT00044, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: GlobalConst.CONTENT00008, style: .default, handler: {
                (alert: UIAlertAction!) in
                if let navigationController = self.window?.rootViewController as? UINavigationController {
                    if navigationController.visibleViewController is G00HomeVC {
                        navigationController.visibleViewController?.viewDidAppear(true)
                    } else {
                        navigationController.popToRootViewController(animated: true)
                    }
                }
//                if let wd = self.window {
//                    var vc = wd.rootViewController
//                    if(vc is UINavigationController){
//                        vc = (vc as! UINavigationController).visibleViewController
//                    }
//                    
//                    if(vc is G00HomeVC){
//                        //your code
//                    } else {
//                        vc.
//                    }
//                }
            })
            alert.addAction(okAction)
            let cancelAction = UIAlertAction(title: GlobalConst.CONTENT00202, style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
        // Reply confirm notify to server
        CommonProcess.requestConfirmNotify(notifyId: notifyId, type: type, objId: id)
        
        // Move to detail
        print(message)
    }
}

