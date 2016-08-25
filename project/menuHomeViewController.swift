//
//  menuHomeViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/20/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class menuHomeViewController: UIViewController {

    
    @IBOutlet weak var configButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func configButtonTapped(sender: AnyObject) {
    }
    @IBAction func loginButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(false) { 
            NSNotificationCenter.defaultCenter().postNotificationName("pushtoLoginVC", object: nil)
        }
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
        configButton.frame = CGRect(x: 0, y: 50, width: 200, height: 40)
        configButton.backgroundColor = UIColor.whiteColor()
        configButton.setTitle("Cài đặt", forState: .Normal)
        configButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
       // configButton.addTarget(self, action: #selector(loginButtonTapped), forControlEvents: .TouchUpInside)
        configButton.layer.cornerRadius = 6
        self.view.addSubview(loginButton)
        configButton.translatesAutoresizingMaskIntoConstraints = true


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
