//
//  CommonViewController.swift
//  project
//
//  Created by Nixforest on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class CommonViewController : UIViewController {
    /**
     * Back button
     */
    @IBOutlet weak var navigationBar: UINavigationItem!
    /**
     * Handle turn on training mode
     */
    func trainingModeOn(_ notification: Notification) {
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
    }
    /**
     * Handle turn off training mode
     */
    func trainingModeOff(_ notification: Notification) {
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
    }
}
