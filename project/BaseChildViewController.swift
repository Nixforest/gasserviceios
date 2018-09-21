//
//  BaseChildViewController.swift
//  project
//
//  Created by Pham Trung Nguyen on 4/10/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

open class BaseChildViewController: ChildExtViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override open func openAnnounceDetail(id: String) {
        let view = G15F00S02VC(nibName: G15F00S02VC.theClassName, bundle: nil)
        view.setData(id: id)
        self.push(view, animated: true)
    }
}
