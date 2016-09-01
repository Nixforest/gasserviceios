//
//  menuHomeViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/20/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class menuHomeViewController: UIViewController {

    var loginStatus:Bool!
    
    @IBOutlet weak var configButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var issueButton: UIButton!
    
    
    
    
    
    @IBAction func configButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(false) {
            NSNotificationCenter.defaultCenter().postNotificationName("configButtonInHomeTapped", object: nil)
        }

    }
    @IBAction func registerButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(false) {
            NSNotificationCenter.defaultCenter().postNotificationName("registerButtonInHomeTapped", object: nil)
        }
    }
    @IBAction func loginButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(false) { 
            NSNotificationCenter.defaultCenter().postNotificationName("loginButtonInHomeTapped", object: nil)
        }
    }
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(false) {
            NSNotificationCenter.defaultCenter().postNotificationName("logoutButtonInHomeTapped", object: nil)
        }
    }
    @IBAction func issueButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(false) {
            NSNotificationCenter.defaultCenter().postNotificationName("issueButtonInHomeTapped", object: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorFromRGB().getColorFromRGB(0xECECEC)
        //login status
        loginStatus = true
        if loginStatus == true {
            loginButton.hidden = true
            logoutButton.hidden = false
            registerButton.hidden = true
            issueButton.hidden = false
        } else {
            loginButton.hidden = false
            registerButton.hidden = false
            logoutButton.hidden = true
            issueButton.hidden = true
        }
        
        //login button
        loginButton.frame = CGRect(x: 0, y: 10, width: 200, height: 40)
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.setTitle("@CONTENT00051", forState: .Normal)
        loginButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), forControlEvents: .TouchUpInside)
        loginButton.layer.cornerRadius = 6
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = true
        //logout button
        logoutButton.frame = CGRect(x: 0, y: 10, width: 200, height: 40)
        logoutButton.backgroundColor = UIColor.whiteColor()
        logoutButton.setTitle("@CONTENT00115", forState: .Normal)
        logoutButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        logoutButton.addTarget(self, action: #selector(loginButtonTapped), forControlEvents: .TouchUpInside)
        logoutButton.layer.cornerRadius = 6
        self.view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = true

        //config button
        configButton.frame = CGRect(x: 0, y: 90, width: 200, height: 40)
        configButton.backgroundColor = UIColor.whiteColor()
        configButton.setTitle("@CONTENT00111", forState: .Normal)
        configButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
       // configButton.addTarget(self, action: #selector(loginButtonTapped), forControlEvents: .TouchUpInside)
        configButton.layer.cornerRadius = 6
        self.view.addSubview(loginButton)
        configButton.translatesAutoresizingMaskIntoConstraints = true
        //register button
        registerButton.frame = CGRect(x: 0, y: 50, width: 200, height: 40)
        registerButton.backgroundColor = UIColor.whiteColor()
        registerButton.setTitle("@CONTENT00052", forState: .Normal)
        registerButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        //loginButton.addTarget(self, action: #selector(loginButtonTapped), forControlEvents: .TouchUpInside)
        registerButton.layer.cornerRadius = 6
        self.view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = true
        //manage button
        issueButton.frame = CGRect(x: 0, y: 50, width: 200, height: 40)
        issueButton.backgroundColor = UIColor.whiteColor()
        issueButton.setTitle("@CONTENT00114", forState: .Normal)
        issueButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        //loginButton.addTarget(self, action: #selector(loginButtonTapped), forControlEvents: .TouchUpInside)
        issueButton.layer.cornerRadius = 6
        self.view.addSubview(issueButton)
        issueButton.translatesAutoresizingMaskIntoConstraints = true




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
