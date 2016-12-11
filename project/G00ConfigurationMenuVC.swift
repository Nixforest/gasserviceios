//
//  G00ConfigurationMenuVC.swift
//  project
//
//  Created by Nixforest on 10/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class G00ConfigurationMenuVC: CommonMenuViewController {    
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
        
        if Singleton.shared.isLogin {
            setItem(listValues: [false, true, false, true, false])
        } else {
            setItem(listValues: [true, false, true, false, false])
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
