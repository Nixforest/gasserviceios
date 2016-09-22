//
//  AppViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {
    
    /*private static var __once: () = {
            Static.instance = AppViewController()
        }()*/
    
    class var sharedInstance: AppViewController {
        let instance = AppViewController()
        
        return instance
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func changeBackgroundColor(_ isTrainingMode :Bool, aView :UIView)  {
        if isTrainingMode == true {
            aView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
        }else {
            aView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
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
