//
//  InfomationViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class InfomationViewController: UIViewController {

    @IBOutlet weak var infomationNavBar: UINavigationItem!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var infoTextView: UITextView!
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoTextView.text = "application info, version, date create, copyright..."

        infomationNavBar.title = GlobalConst.CONTENT00072
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]

        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        backButton.setImage(tintedBackLogo, forState: .Normal)
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        backButton.setTitle("", forState: .Normal)
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        infomationNavBar.setLeftBarButtonItem(backNavBar, animated: false)

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
