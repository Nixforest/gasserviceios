//
//  CommonViewController.swift
//  project
//
//  Created by Nixforest on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class CommonViewController : UIViewController {
    //MARK: Properties
    /**
     * Navigation bar
     */
    @IBOutlet weak var navigationBar: UINavigationItem!
    /**
     * Flag check keyboard is show or hide
     */
    var isKeyboardShow : Bool = false
    
    //MARK: Methods
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
    /**
     * Singleton
     */
    class var sharedInstance: CommonViewController {
        let instance = CommonViewController()
        
        return instance
        
    }
    /**
     * TrainingMode on/off
     */
    func changeBackgroundColor(_ isTrainingMode :Bool, aView :UIView)  {
        if isTrainingMode == true {
            aView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
        }else {
            aView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        }
        
    }

}
