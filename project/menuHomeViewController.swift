//
//  menuHomeViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/20/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class menuHomeViewController: CommonMenuViewController {
    /** Login status */
    var loginStatus:Bool = false
    
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
        
        if Singleton.sharedInstance.isLogin {
            setItem(listValues: [false, true, false, false, true, true])
        } else {
            setItem(listValues: [true, false, true, false, false, true])
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
