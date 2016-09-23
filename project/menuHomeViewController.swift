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
    
    
    
    
    
    @IBAction func configButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "configButtonInHomeTapped"), object: nil)
        }

    }
    @IBAction func registerButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "registerButtonInHomeTapped"), object: nil)
        }
    }
    @IBAction func loginButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) { 
            NotificationCenter.default.post(name: Notification.Name(rawValue: "loginButtonInHomeTapped"), object: nil)
        }
    }
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        Singleton.sharedInstance.logoutSuccess()
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "logoutButtonInHomeTapped"), object: nil)
        }
    }
    @IBAction func issueButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "issueButtonInHomeTapped"), object: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorFromRGB().getColorFromRGB(0xECECEC)
        //login status
        
        if Singleton.sharedInstance.checkIsLogin() == true {
            loginButton.isHidden = true
            logoutButton.isHidden = false
            registerButton.isHidden = true
            issueButton.isHidden = false
        } else {
            loginButton.isHidden = false
            registerButton.isHidden = false
            logoutButton.isHidden = true
            issueButton.isHidden = true
        }
        
        //login button
        loginButton.frame = CGRect(x: 0, y: 0, width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat(GlobalConst.BUTTON_HEIGHT))
        loginButton.backgroundColor = UIColor.white
        loginButton.setTitle(GlobalConst.CONTENT00051, for: UIControlState())
        loginButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), for: UIControlState())
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = true
        //logout button
        logoutButton.frame = CGRect(x: 0, y: 0, width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat(GlobalConst.BUTTON_HEIGHT))
        logoutButton.backgroundColor = UIColor.white
        logoutButton.setTitle(GlobalConst.CONTENT00132, for: UIControlState())
        logoutButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), for: UIControlState())
        self.view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = true

        //config button
        configButton.frame = CGRect(x: 0, y: CGFloat( GlobalConst.BUTTON_HEIGHT) * 2, width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat( GlobalConst.BUTTON_HEIGHT))
        configButton.backgroundColor = UIColor.white
        configButton.setTitle(GlobalConst.CONTENT00128, for: UIControlState())
        configButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), for: UIControlState())
        self.view.addSubview(loginButton)
        configButton.translatesAutoresizingMaskIntoConstraints = true
        //register button
        registerButton.frame = CGRect(x: 0, y: CGFloat( GlobalConst.BUTTON_HEIGHT), width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat( GlobalConst.BUTTON_HEIGHT))
        registerButton.backgroundColor = UIColor.white
        registerButton.setTitle(GlobalConst.CONTENT00052, for: UIControlState())
        registerButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), for: UIControlState())
        self.view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = true
        //issue button
        issueButton.frame = CGRect(x: 0, y: CGFloat( GlobalConst.BUTTON_HEIGHT), width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat( GlobalConst.BUTTON_HEIGHT))
        issueButton.backgroundColor = UIColor.white
        issueButton.setTitle(GlobalConst.CONTENT00131, for: UIControlState())
        issueButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), for: UIControlState())
        self.view.addSubview(issueButton)
        issueButton.translatesAutoresizingMaskIntoConstraints = true




        self.navigationController?.isNavigationBarHidden = true
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
