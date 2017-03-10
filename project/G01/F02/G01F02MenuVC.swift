//
//  G01F02MenuVC.swift
//  project
//
//  Created by Nixforest on 10/28/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

//++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
//class G01F02MenuVC: BaseMenuViewController {
//    //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
////    /**
////     * Override
////     */
////    override func configItemTapped(_ sender: AnyObject) {
////        self.dismiss(animated: false) {
////            NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_COFIG_ITEM_HOMEVIEW), object: nil)
////        }
////    }
//    //-- BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
//    
//    /**
//     * View did load
//     */
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if BaseModel.shared.checkIsLogin() {
//            setItem(listValues: [false, false, false, true, true])
//        } else {
//            setItem(listValues: [true, false, true, false, true])
//        }
//        setupMenuItem()
//    }
//    
//    /**
//     * Did receive memory warning
//     */
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}
//-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
