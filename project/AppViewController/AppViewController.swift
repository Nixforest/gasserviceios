//
//  AppViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {
    
    class var sharedInstance: AppViewController {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: AppViewController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = AppViewController()
        }
        return Static.instance!
    }
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func changeBackgroundColor(isTrainingMode :Bool, aView :UIView)  {
        if isTrainingMode == true {
            aView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.CGColor
        }else {
            aView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.CGColor
        }
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
