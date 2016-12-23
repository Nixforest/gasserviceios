//
//  G01F01MenuVC.swift
//  project
//
//  Created by Nixforest on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class G01F01MenuVC: CommonMenuViewController {
    /**
     * Override
     */
    override func configItemTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM_HOMEVIEW), object: nil)
        }
    }
    
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        if Singleton.shared.checkIsLogin() {
            setItem(listValues: [false, false, false, true, true])
        } else {
            setItem(listValues: [true, false, true, false, true])
        }
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
