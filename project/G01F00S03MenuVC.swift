//
//  G01F00S03MenuVC.swift
//  project
//
//  Created by Nixforest on 10/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

class G01F00S03MenuVC: BaseMenuViewController {
    //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
//    /**
//     * Override
//     */
//    override func configItemTapped(_ sender: AnyObject) {
//        self.dismiss(animated: false) {
//            NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_COFIG_ITEM_UPHOLDLISTVIEW), object: nil)
//        }
//    }
    //-- BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setItem(listValues: [false, false, false, true, true])
        setupMenuItem()
    }
    
    /**
     * Did receive memory warning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
