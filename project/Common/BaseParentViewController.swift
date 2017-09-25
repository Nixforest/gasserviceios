      //
//  BaseParentViewController.swift
//  project
//
//  Created by SPJ on 9/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class BaseParentViewController: ParentExtViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /**
     * Handle open login view
     */
    override func openLogin() {
        let login = G00LoginExtVC(nibName: G00LoginExtVC.theClassName, bundle: nil)
        self.present(login, animated: true, completion: finishOpenLogin)
    }
    
    /**
     * Handle when finish open login view
     */
    internal func finishOpenLogin() -> Void {
        print("finishOpenLogin")
    }

}
