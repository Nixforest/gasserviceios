//
//  menuHomeViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/20/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class menuHomeViewController: UIViewController {

    var loginStatus:Bool = false
    
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
        GlobalConst.LOGIN_STATUS = false
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
        
        if GlobalConst.LOGIN_STATUS == true {
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
        loginButton.frame = CGRect(x: 0, y: 0, width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat(GlobalConst.BUTTON_HEIGHT))
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.setTitle(GlobalConst.CONTENT00051, forState: .Normal)
        loginButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = true
        //logout button
        logoutButton.frame = CGRect(x: 0, y: 0, width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat(GlobalConst.BUTTON_HEIGHT))
        logoutButton.backgroundColor = UIColor.whiteColor()
        logoutButton.setTitle(GlobalConst.CONTENT00132, forState: .Normal)
        logoutButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        self.view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = true

        //config button
        configButton.frame = CGRect(x: 0, y: CGFloat( GlobalConst.BUTTON_HEIGHT) * 2, width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat( GlobalConst.BUTTON_HEIGHT))
        configButton.backgroundColor = UIColor.whiteColor()
        configButton.setTitle(GlobalConst.CONTENT00128, forState: .Normal)
        configButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        self.view.addSubview(loginButton)
        configButton.translatesAutoresizingMaskIntoConstraints = true
        //register button
        registerButton.frame = CGRect(x: 0, y: CGFloat( GlobalConst.BUTTON_HEIGHT), width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat( GlobalConst.BUTTON_HEIGHT))
        registerButton.backgroundColor = UIColor.whiteColor()
        registerButton.setTitle(GlobalConst.CONTENT00052, forState: .Normal)
        registerButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        self.view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = true
        //issue button
        issueButton.frame = CGRect(x: 0, y: CGFloat( GlobalConst.BUTTON_HEIGHT), width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat( GlobalConst.BUTTON_HEIGHT))
        issueButton.backgroundColor = UIColor.whiteColor()
        issueButton.setTitle(GlobalConst.CONTENT00131, forState: .Normal)
        issueButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
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
