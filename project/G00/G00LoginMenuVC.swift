//
//  menuLoginViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/5/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00LoginMenuVC: BaseMenuViewController {
    /**
     * View did load.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setItem(listValues: [false, false, false, false, true])
        setupMenuItem()
    }
    /**
     * Dis receive memory warning.
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
