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
    //++ BUG0195-SPJ (NguyenPT 20180411) Add function announce
    /**
     * Handle open announce list
     */
    override func openAnnounce() {
        let view = G15F00S01VC(nibName: G15F00S01VC.theClassName,
                               bundle: nil)
        self.push(view, animated: true)
    }
    
    /**
     * Handle open announce detail
     * - parameter id: Id of announce
     */
    override func openAnnounceDetail(id: String) {
        let view = G15F00S02VC(nibName: G15F00S02VC.theClassName, bundle: nil)
        view.setData(id: id)
        self.push(view, animated: true)
    }
    //-- BUG0195-SPJ (NguyenPT 20180411) Add function announce
//    /**
//     * Handle open login view
//     */
//    override func openLogin() {
//        let view = G00LoginExtVC(nibName: G00LoginExtVC.theClassName, bundle: nil)
//        if let controller = BaseViewController.getCurrentViewController() {
//            controller.present(view, animated: true, completion: finishOpenLogin)
//        }
//    }
//    
//    /**
//     * Handle when finish open login view
//     */
//    internal func finishOpenLogin() -> Void {
//        print("finishOpenLogin")
//    }

}
