//
//  menuAccountViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/14/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00AccountMenuVC: BaseMenuViewController {
    /**
     * Override
     */
    override func configItemTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM_ACCOUNTVIEW), object: nil)
        }
    }
    
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
