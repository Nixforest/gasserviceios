    //
//  UpholdDetailViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdDetailViewController: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet var view1: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSBundle.mainBundle().loadNibNamed("View", owner: self, options: nil)
        mainScrollView.addSubview(view1)
        mainScrollView.contentSize = CGSizeMake(mainScrollView.frame.size.width, view1.frame.size.height)
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
