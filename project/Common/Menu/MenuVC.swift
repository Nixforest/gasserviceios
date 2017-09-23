//
//  MenuVC.swift
//  project
//
//  Created by SPJ on 9/22/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class MenuVC: BaseMenuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func openLogin() {
        let loginView = G00LoginExtVC(nibName: G00LoginExtVC.theClassName, bundle: nil)
        if let controller = BaseViewController.getCurrentViewController() {
            controller.present(loginView, animated: true, completion: finishOpenLogin)
        }
    }
    
    internal func finishOpenLogin() -> Void {
        print("finishOpenLogin")
    }

}
