//
//  G00RegisterMenuVC.swift
//  project
//
//  Created by SPJ on 12/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

class G00RegisterMenuVC: BaseMenuViewController {
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
