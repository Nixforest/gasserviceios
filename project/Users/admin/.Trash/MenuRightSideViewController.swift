//
//  MenuRightSideViewController.swift
//  project
//
//  Created by Lâm Phạm on 7/28/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class MenuRightSideViewController: UIViewController {

    @IBOutlet weak var MenuRightSide: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuRightSide.target = self.revealViewController()
        MenuRightSide.action = #selector(SWRevealViewController.rightRevealToggle(_:))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
