//
//  menuHomeViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/20/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class menuHomeViewController: UIViewController {

    @IBAction func toLoginVC(sender: AnyObject) {
    }
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(false) { 
            NSNotificationCenter.defaultCenter().postNotificationName("pushtoLoginVC", object: nil)
        }
      /*  let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = mainStoryboard.instantiateViewControllerWithIdentifier("LoginViewController")
        //self.navigationController?.pushViewController(loginVC, animated: true)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let aVariable:UINavigationController = appDelegate.rootNav
        aVariable.pushViewController(loginVC, animated: true)*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorFromRGB().getColorFromRGB(0xECECEC)
        loginButton.frame = CGRect(x: 0, y: 10, width: 200, height: 40)
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.setTitle("Đăng nhập", forState: .Normal)
        loginButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), forControlEvents: .TouchUpInside)
        loginButton.layer.cornerRadius = 6
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = true

        self.navigationController?.navigationBarHidden = true
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
