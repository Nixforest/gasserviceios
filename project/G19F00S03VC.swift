//
//  G19F00S03VC.swift
//  project
//
//  Created by SPJ on 9/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class G19F00S03VC: BaseChildViewController {
    /** id */
    internal var _id:                String              = DomainConst.BLANK
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar(title: DomainConst.CONTENT00596)
        // Id
        _id = BaseModel.shared.sharedString
        // Do any additional setup after loading the view.
    }

}
