//
//  G05F00S01MenuVC.swift
//  project
//
//  Created by SPJ on 2/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

//++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
//class G05F00S01MenuVC: BaseMenuViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        if BaseModel.shared.checkIsLogin() {
//            setItem(listValues: [false, true, false, true, true])
//        } else {
//            setItem(listValues: [true, false, true, false, true])
//        }
//        setupMenuItem()
//    }
//    
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
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
