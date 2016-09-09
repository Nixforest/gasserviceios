//
//  menuLoginViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/5/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class menuLoginViewController: UIViewController {

    @IBOutlet weak var configButton: UIButton!
    @IBOutlet weak var iconConfigButton: UIImageView!
    
    @IBAction func configButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(false) {
            NSNotificationCenter.defaultCenter().postNotificationName("configButtonInLoginTapped", object: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configButton.frame = CGRect(x: 0, y: 10, width: 200, height: 40)
        configButton.backgroundColor = UIColor.whiteColor()
        configButton.setTitle(GlobalConst.CONTENT00111, forState: .Normal)
        configButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        configButton.addTarget(self, action: #selector(configButtonTapped), forControlEvents: .TouchUpInside)
        configButton.layer.cornerRadius = 6
        self.view.addSubview(configButton)
        configButton.translatesAutoresizingMaskIntoConstraints = true
        
        iconConfigButton.image = UIImage(named: "config.png")
        iconConfigButton.frame = CGRect(x: 20, y: 10, width: 30, height: 30)
        iconConfigButton.translatesAutoresizingMaskIntoConstraints = true
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
